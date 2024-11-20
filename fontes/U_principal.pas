unit U_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  Tfrm_principal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Clientes2: TMenuItem;
    Clientes1: TMenuItem;
    Image1: TImage;
    procedure Clientes2Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

implementation

{$R *.dfm}

uses U_Clientes;



procedure Tfrm_principal.Clientes1Click(Sender: TObject);
begin
frm_principal.close;
end;

procedure Tfrm_principal.Clientes2Click(Sender: TObject);
begin
frm_cad_clientes.ShowModal;
end;


end.
