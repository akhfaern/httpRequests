unit UAddDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmAddDialog = class(TForm)
    Label1: TLabel;
    edtKey: TEdit;
    Label2: TLabel;
    edtValue: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbFile: TCheckBox;
    btnSelectFile: TButton;
    procedure FormShow(Sender: TObject);
    procedure cbFileClick(Sender: TObject);
    procedure btnSelectFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAddDialog: TFrmAddDialog;

implementation

{$R *.dfm}

uses UMain;

procedure TFrmAddDialog.btnSelectFileClick(Sender: TObject);
begin
  if FrmMain.OpenDialog.Execute then
    edtValue.Text := 'file:' + FrmMain.OpenDialog.FileName;
end;

procedure TFrmAddDialog.cbFileClick(Sender: TObject);
begin
  btnSelectFile.Visible := cbFile.Checked;
end;

procedure TFrmAddDialog.FormShow(Sender: TObject);
begin
  edtKey.SetFocus;
end;

end.
