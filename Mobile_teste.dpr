program Mobile_teste;

uses
  System.StartUpCopy,
  FMX.Forms,
  Login in 'Login.pas' {frmLogin},
  u99Permissions in 'Units\u99Permissions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
