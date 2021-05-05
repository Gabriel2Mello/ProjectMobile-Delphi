unit Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.TabControl,
  System.Actions, FMX.ActnList, u99Permissions, FMX.MediaLibrary.Actions,
  FMX.StdActns;

type
  TfrmLogin = class(TForm)
    Layout1: TLayout;
    imgLogoLogin: TImage;
    Layout2: TLayout;
    RoundRect1: TRoundRect;
    edtLoginEmail: TEdit;
    StyleBook1: TStyleBook;
    Layout3: TLayout;
    RoundRect2: TRoundRect;
    edtLoginSenha: TEdit;
    Layout4: TLayout;
    RoundRect3: TRoundRect;
    Label1: TLabel;
    TabControl1: TTabControl;
    tabLogin: TTabItem;
    tabConta: TTabItem;
    Layout5: TLayout;
    Image1: TImage;
    Layout6: TLayout;
    RoundRect4: TRoundRect;
    edtCadNome: TEdit;
    Layout7: TLayout;
    RoundRect5: TRoundRect;
    edtCadSenha: TEdit;
    Layout8: TLayout;
    btnContaProximo: TRoundRect;
    lblContaProximo: TLabel;
    Layout9: TLayout;
    RoundRect7: TRoundRect;
    edtCadEmail: TEdit;
    tabFoto: TTabItem;
    Layout10: TLayout;
    cFotoEditar: TCircle;
    Layout11: TLayout;
    RoundRect8: TRoundRect;
    Label3: TLabel;
    Layout12: TLayout;
    imgVoltaConta: TImage;
    Layout13: TLayout;
    imgVoltaLogin: TImage;
    Layout14: TLayout;
    Layout15: TLayout;
    lblTabLogin: TLabel;
    lblTabConta: TLabel;
    Rectangle1: TRectangle;
    ActionList1: TActionList;
    actConta: TChangeTabAction;
    actFoto: TChangeTabAction;
    actLogin: TChangeTabAction;
    Layout16: TLayout;
    lglTabLogin: TLabel;
    Label5: TLabel;
    Rectangle4: TRectangle;
    Layout17: TLayout;
    actLibrary: TTakePhotoFromLibraryAction;
    actCamera: TTakePhotoFromCameraAction;
    imgTeste: TImage;
    procedure lblTabContaClick(Sender: TObject);
    procedure lglTabLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnContaProximoClick(Sender: TObject);
    procedure imgVoltaContaClick(Sender: TObject);
    procedure imgVoltaLoginClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cFotoEditarClick(Sender: TObject);
    procedure actLibraryDidFinishTaking(Image: TBitmap);
    procedure actCameraDidFinishTaking(Image: TBitmap);
  private
    { Private declarations }
    permissao : T99Permissions;
    procedure TrataErroPermissao(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

procedure TfrmLogin.actCameraDidFinishTaking(Image: TBitmap);
begin
  cFotoEditar.Fill.Bitmap.Bitmap := Image;
end;

procedure TfrmLogin.actLibraryDidFinishTaking(Image: TBitmap);
var
  LImage : TImage;
begin
  LImage.Bitmap := Image;
  LImage.RotationAngle := LImage.RotationAngle + 90;

  cFotoEditar.Fill.Bitmap.Bitmap := Image;
end;

procedure TfrmLogin.btnContaProximoClick(Sender: TObject);
begin
  actFoto.Execute;
end;

procedure TfrmLogin.TrataErroPermissao(Sender: TObject);
begin
  ShowMessage('Você não tem permissão para essa ação.');
end;

procedure TfrmLogin.cFotoEditarClick(Sender: TObject);
begin
  MessageDlg('Abrir câmera?', System.UITypes.TMsgDlgType.mtInformation,
  [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: System.UITypes.TModalResult)
  begin
  case AResult of
  mrYES:
  begin
    permissao.Camera(actCamera, TrataErroPermissao);
    Exit;
  end;
  mrNo:
  begin
    permissao.PhotoLibrary(actLibrary, TrataErroPermissao);
    Exit;
  end;
  end;
  end);

end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  actLogin.Execute;
  permissao:= T99Permissions.Create;
  ReportMemoryLeaksOnShutdown:= True;
end;

procedure TfrmLogin.FormDestroy(Sender: TObject);
begin
  permissao.DisposeOf;
end;

procedure TfrmLogin.imgVoltaContaClick(Sender: TObject);
begin
  actConta.Execute;
end;

procedure TfrmLogin.imgVoltaLoginClick(Sender: TObject);
begin
  actLogin.Execute;
end;

procedure TfrmLogin.lblTabContaClick(Sender: TObject);
begin
  actConta.Execute;
end;

procedure TfrmLogin.lglTabLoginClick(Sender: TObject);
begin
  actLogin.Execute;
end;

end.
