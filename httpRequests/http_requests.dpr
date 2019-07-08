program http_requests;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FrmMain},
  UAddDialog in 'UAddDialog.pas' {FrmAddDialog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmAddDialog, FrmAddDialog);
  Application.Run;
end.
