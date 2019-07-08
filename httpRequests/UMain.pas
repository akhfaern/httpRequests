unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.ComCtrls, IdURI,
  IdCookieManager, System.RegularExpressions;

type
  TFrmMain = class(TForm)
    IdHTTP: TIdHTTP;
    Label1: TLabel;
    edtURL: TEdit;
    Label2: TLabel;
    cmbRequestMethod: TComboBox;
    Label3: TLabel;
    cmbHttp: TComboBox;
    GroupBox1: TGroupBox;
    lbCookieList: TListBox;
    btnAddCookie: TButton;
    btnRemoveCookie: TButton;
    GroupBox2: TGroupBox;
    lbParamList: TListBox;
    btnAddParam: TButton;
    btnRemoveParam: TButton;
    btnRun: TButton;
    btnStop: TButton;
    Progress: TProgressBar;
    btnLoadCookieList: TButton;
    btnSaveCookieList: TButton;
    btnSaveParamList: TButton;
    btnLoadParamList: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    IdCookieManager: TIdCookieManager;
    GroupBox3: TGroupBox;
    cbSaveResultsToFile: TCheckBox;
    edtSaveFile: TEdit;
    btnSelectSaveFile: TButton;
    cbFilterRegEx: TCheckBox;
    edtRegEx: TEdit;
    GroupBox4: TGroupBox;
    memDebug: TMemo;
    btnClearResults: TButton;
    cbIgnoreCase: TCheckBox;
    cbExplicitCapture: TCheckBox;
    cbMultiLine: TCheckBox;
    cbCompiled: TCheckBox;
    cbSingleLine: TCheckBox;
    cbIgnorePatternSpace: TCheckBox;
    Label4: TLabel;
    procedure btnAddCookieClick(Sender: TObject);
    procedure btnRemoveCookieClick(Sender: TObject);
    procedure btnSaveCookieListClick(Sender: TObject);
    procedure btnLoadCookieListClick(Sender: TObject);
    procedure btnAddParamClick(Sender: TObject);
    procedure btnRemoveParamClick(Sender: TObject);
    procedure btnSaveParamListClick(Sender: TObject);
    procedure btnLoadParamListClick(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnClearResultsClick(Sender: TObject);
    procedure btnSelectSaveFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure addItem(FList: TListBox; FileSelectable: Boolean);
    procedure removeItem(FList: TListBox);
    procedure saveList(FList: TListBox);
    procedure loadList(FList: TListBox);
    function getURL(FURL: string): string;
    procedure addLog(FLogMessage: string);
    function filterResultWithRegEx(FResponse: string): string;
    procedure processResponse(FResponse: string);
  end;

var
  FrmMain: TFrmMain;
  FRunning: Boolean;
  FLogFile: TextFile;

implementation

{$R *.dfm}

uses UAddDialog;

procedure TFrmMain.addItem(FList: TListBox; FileSelectable: Boolean);
begin
  with FrmAddDialog do
  begin
    edtKey.Clear;
    edtValue.Clear;
    cbFile.Visible := FileSelectable;
    cbFile.Checked := False;
    btnSelectFile.Visible := False;
  end;
  if FrmAddDialog.ShowModal = mrOk then
    FList.Items.Add(FrmAddDialog.edtKey.Text + '=' +
      FrmAddDialog.edtValue.Text);
end;

procedure TFrmMain.loadList(FList: TListBox);
begin
  if OpenDialog.Execute then
    FList.Items.LoadFromFile(OpenDialog.FileName);
end;

procedure TFrmMain.processResponse(FResponse: string);
begin
  if cbFilterRegEx.Checked then
    FResponse := filterResultWithRegEx(FResponse);
  if cbSaveResultsToFile.Checked then
    Writeln(FLogFile, FResponse);
  addLog(FResponse);
end;

procedure TFrmMain.removeItem(FList: TListBox);
begin
  if FList.ItemIndex > -1 then
    case Application.MessageBox('Are u sure you want to delete this item?',
      'Confirm', MB_OKCANCEL + MB_ICONINFORMATION) of
      IDOK:
        FList.Items.Delete(FList.ItemIndex);
    end;
end;

procedure TFrmMain.saveList(FList: TListBox);
begin
  if SaveDialog.Execute then
    FList.Items.SaveToFile(SaveDialog.FileName);
end;

procedure TFrmMain.addLog(FLogMessage: string);
begin
  memDebug.Lines.Add(FLogMessage);
end;

procedure TFrmMain.btnAddCookieClick(Sender: TObject);
begin
  addItem(lbCookieList, False);
end;

procedure TFrmMain.btnAddParamClick(Sender: TObject);
begin
  addItem(lbParamList, True);
end;

procedure TFrmMain.btnClearResultsClick(Sender: TObject);
begin
  case Application.MessageBox('Are you sure you want to delete the results?',
    'Confirm', MB_OKCANCEL + MB_ICONINFORMATION) of
    IDOK:
      memDebug.Lines.Clear;
  end;
end;

procedure TFrmMain.btnLoadCookieListClick(Sender: TObject);
begin
  loadList(lbCookieList);
end;

procedure TFrmMain.btnLoadParamListClick(Sender: TObject);
begin
  loadList(lbParamList);
end;

procedure TFrmMain.btnRemoveCookieClick(Sender: TObject);
begin
  removeItem(lbCookieList);
end;

procedure TFrmMain.btnRemoveParamClick(Sender: TObject);
begin
  removeItem(lbParamList);
end;

procedure TFrmMain.btnRunClick(Sender: TObject);
var
  PostData: TStringList;
  I, J, X: Integer;
  FFileName, FKey: string;
  Uri: TIdURI;
  FFileList: array of TStringList;
begin
  FRunning := True;
  if IdHTTP.Connected then
    IdHTTP.Disconnect;

  IdHTTP.Request.Referer := edtURL.Text;
  Uri := TIdURI.Create(getURL(edtURL.Text));
  IdCookieManager.AddServerCookies(lbCookieList.Items, Uri);
  IdHTTP.AllowCookies := True;
  Uri.Free;
  case cmbHttp.ItemIndex of
    0:
      IdHTTP.ProtocolVersion := pv1_1;
    1:
      IdHTTP.ProtocolVersion := pv1_0;
  end;

  if cbSaveResultsToFile.Checked and (Trim(edtSaveFile.Text) <> '') then
  begin
    try
      AssignFile(FLogFile, edtSaveFile.Text);
      Rewrite(FLogFile);
    except
      on E: Exception do
      begin
        Application.MessageBox
          (PChar(E.ClassName + ' error raised, with message : ' + E.Message),
          'Error', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
  end;

  case cmbRequestMethod.ItemIndex of
    0:
      begin
        PostData := TStringList.Create;
        try
          if Pos('=file:', lbParamList.Items.Text) > 0 then
          begin
            for I := 0 to lbParamList.Items.Count - 1 do
              if Pos('=file:', lbParamList.Items[I]) > 0 then
              begin
                SetLength(FFileList, Length(FFileList) + 1);
                FFileList[High(FFileList)] := TStringList.Create;
                FFileName := Copy(lbParamList.Items[I],
                  Pos('=file:', lbParamList.Items[I]) + 6,
                  Length(lbParamList.Items[I]));
                FFileList[High(FFileList)].LoadFromFile(FFileName);
              end;
            // assuming all file lengths are same
            Progress.Max := FFileList[High(FFileList)].Count;
            for I := 0 to FFileList[High(FFileList)].Count - 1 do
            begin
              if not FRunning then
                Break;
              PostData.Clear;
              X := 0;
              for J := 0 to lbParamList.Items.Count - 1 do
                if Pos('=file:', lbParamList.Items[J]) < 1 then
                  PostData.Add(lbParamList.Items[J])
                else
                begin
                  FKey := Copy(lbParamList.Items[J], 1,
                    Pos('=', lbParamList.Items[J]));
                  PostData.Add(FKey + FFileList[X][I]);
                  Inc(X);
                end;
              processResponse(IdHTTP.Post(edtURL.Text, PostData));
              Progress.Position := I + 1;
              Application.ProcessMessages;
            end;
          end
          else
          begin
            PostData.Text := lbParamList.Items.Text;
            processResponse(IdHTTP.Post(edtURL.Text, PostData));
          end;
        finally
          PostData.Free;
        end;
      end;
    1:
      processResponse(IdHTTP.Get(edtURL.Text));
  end;
  FRunning := False;
  CloseFile(FLogFile);
end;

procedure TFrmMain.btnSaveCookieListClick(Sender: TObject);
begin
  saveList(lbCookieList);
end;

procedure TFrmMain.btnSaveParamListClick(Sender: TObject);
begin
  saveList(lbParamList);
end;

procedure TFrmMain.btnSelectSaveFileClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    edtSaveFile.Text := OpenDialog.FileName;
end;

procedure TFrmMain.btnStopClick(Sender: TObject);
begin
  FRunning := False;
end;

function TFrmMain.filterResultWithRegEx(FResponse: string): string;
var
  FRegExp: TRegEx;
  FOptions: TRegExOptions;
  FMatch: TMatch;
  I: Integer;
begin
  Result := '';
  if cbIgnoreCase.Checked then
    Include(FOptions, TRegExOption.roIgnoreCase);
  if cbMultiLine.Checked then
    Include(FOptions, TRegExOption.roMultiLine);
  if cbSingleLine.Checked then
    Include(FOptions, TRegExOption.roSingleLine);
  if cbExplicitCapture.Checked then
    Include(FOptions, TRegExOption.roExplicitCapture);
  if cbCompiled.Checked then
    Include(FOptions, TRegExOption.roCompiled);
  if cbIgnorePatternSpace.Checked then
    Include(FOptions, TRegExOption.roIgnorePatternSpace);

  try
    FRegExp := TRegEx.Create(edtRegEx.Text, FOptions);
    FMatch := FRegExp.Match(FResponse);
    if FMatch.Success then
      while FMatch.Success do
      begin
        Result := Result + FMatch.Value;
        FMatch := FMatch.NextMatch;
      end;
  finally
    //
  end;
end;

function TFrmMain.getURL(FURL: string): string;
begin
  if Copy(FURL, 1, 7) = 'http://' then
    Delete(FURL, 1, 7);
  if Pos('/', FURL) > 0 then
    Result := 'http://' + Copy(FURL, 1, Pos('/', FURL) - 1)
  else
    Result := 'http://' + FURL;
end;

end.
