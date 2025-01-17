unit U_Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.Buttons, Data.DB, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtDlgs, jpeg, Vcl.Imaging.pngimage;

type
  Tfrm_cad_clientes = class(TForm)
    PageControl1: TPageControl;
    tb_cadastro: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label15: TLabel;
    Label13: TLabel;
    btn_inserir: TSpeedButton;
    btn_editar: TSpeedButton;
    btn_excluir: TSpeedButton;
    btn_cancelar: TSpeedButton;
    btn_salvar: TSpeedButton;
    btn_localizar: TSpeedButton;
    txt_id: TDBEdit;
    txt_nome: TDBEdit;
    txt_distribuidora: TDBEdit;
    txt_preco: TDBEdit;
    txt_desenvolvedor: TDBEdit;
    cb_plataforma: TDBComboBox;
    txt_data_lanc: TDBEdit;
    tb_consulta: TTabSheet;
    lb_buscar: TLabel;
    DBGrid1: TDBGrid;
    btn_mostrar: TButton;
    btn_pesquisar: TButton;
    btn_imprimir: TButton;
    txt_buscar: TEdit;
    rg_opcoes: TRadioGroup;
    data_nasc: TDateTimePicker;
    txt_impressao: TEdit;
    cb_genero: TDBComboBox;
    img_game: TDBImage;
    btn_mudaimg: TButton;
    abre_img: TOpenPictureDialog;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    procedure btn_inserirClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_localizarClick(Sender: TObject);
    procedure btn_voltarClick(Sender: TObject);
    procedure rg_opcoesClick(Sender: TObject);
    procedure btn_pesquisarClick(Sender: TObject);
    procedure txt_buscarKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btn_imprimirClick(Sender: TObject);
    procedure btn_mudaimgClick(Sender: TObject);
    procedure btn_mostrarClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);

    
  private

    procedure ConfigBotoes;


    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_cad_clientes: Tfrm_cad_clientes;

implementation

{$R *.dfm}

uses U_dm;

{ Tfrm_cad_clientes }

procedure Tfrm_cad_clientes.btn_cancelarClick(Sender: TObject);
begin

dm.tb_clientes.Cancel;
ConfigBotoes;

end;

procedure Tfrm_cad_clientes.btn_editarClick(Sender: TObject);
begin

dm.tb_clientes.Edit;
ConfigBotoes;

end;

procedure Tfrm_cad_clientes.btn_excluirClick(Sender: TObject);
begin

case Application.MessageBox('Deseja excluir esse cliente','excluir cliente',
MB_YESNO + MB_ICONQUESTION) of
IDYES:
begin
  dm.tb_clientes.Delete;
  showmessage(' O jogo foi excluido ');

end;

IDNO:
begin

  exit;

end;


end;
end;

procedure Tfrm_cad_clientes.btn_fecharClick(Sender: TObject);
begin
if dm.tb_clientes.State in [dsinsert,dsedit] then
begin
  showmessage(' Salve ou cancele antes de fechar ');
  exit;
end
else
begin
  close;
end;


end;

procedure Tfrm_cad_clientes.btn_imprimirClick(Sender: TObject);
begin
 with dm.SQL_imprimir_cliente do
  begin
  Close;
  Sql.Clear;
  if txt_impressao.text = '' then
      begin
       SQL.Add('select * from games');

      end else
      begin
        SQL.Add('select * from games where game_id = :codigo');
        ParamByName('codigo').Value:= StrToInt(txt_impressao.text);
      end;

      open;
      //dm.Report_cliente.LoadFromFile(GetCurrentDir +'\rel\lista.fr3' ) ;
      //dm.Report_cliente.ShowReport();


  end;


end;

procedure Tfrm_cad_clientes.btn_inserirClick(Sender: TObject);
begin
//Iniciando a inseção de dados
dm.tb_clientes.Active:= true;
dm.tb_clientes.Insert;
// Habilitanto e desabilitando botões
ConfigBotoes;
btn_mudaimg.Enabled:= true;
txt_nome.SetFocus;

end;

procedure Tfrm_cad_clientes.btn_localizarClick(Sender: TObject);
begin
pageControl1.TabIndex := 1;
tb_consulta.TabVisible := true;
tb_cadastro.TabVisible := false;

dm.SQL_con_cliente.Open;
dm.SQL_con_cliente.Refresh;



end;

procedure Tfrm_cad_clientes.btn_mostrarClick(Sender: TObject);
begin
  with dm.SQL_con_cliente do
  begin
  close;
  SQL.Clear;
  SQL.Add('select * from games');
  open;
  end;
end;

procedure Tfrm_cad_clientes.btn_mudaimgClick(Sender: TObject);
begin

if abre_img.execute then
 begin
   img_game.Picture.LoadFromFile(abre_img.filename);
 end;



end;

procedure Tfrm_cad_clientes.btn_pesquisarClick(Sender: TObject);
begin
if txt_buscar.Text = '' then
    begin
      showmessage('digite algo para pesquisar');
      txt_buscar.SetFocus;
      exit;
    end;

  with dm.SQL_con_cliente do
  begin
  close;
  SQL.Clear;
  SQL.Add('select * from games');


  case rg_opcoes.ItemIndex of

    0:
        begin
        SQL.Add('where game_id = :codigo');
        ParamByName('codigo').Value := txt_buscar.Text;


        end;

    1:
        begin
         SQL.Add('where game_nome like :nome');
        ParamByName('nome').Value := '%'+txt_buscar.Text + '%';
        end;
    2:
        begin
        SQL.Add('where game_preco = :preco');
        ParamByName('preco').Value := txt_buscar.Text;
        end;

    3:
        begin
        SQL.Add('where game_genero = :genero');
        ParamByName('genero').Value := txt_buscar.Text;
        end;

    4:
        begin
         SQL.Add('where game_data = :data');
        ParamByName('data').AsDate :=
        StrToDate(formatDateTime('dd/mm/yyyy',data_nasc.Date));
        end;

    5:
        begin
        SQL.Add('where game_plataforma = :plataforma');
        ParamByName('plataforma').Value := txt_buscar.Text;
        end;
  end;

     open;

  end;



end;

procedure Tfrm_cad_clientes.btn_salvarClick(Sender: TObject);
begin
dm.tb_clientes.Post;
showmessage('Jogo cadastrado com sucesso');
ConfigBotoes;
end;

procedure Tfrm_cad_clientes.btn_voltarClick(Sender: TObject);
begin
pageControl1.TabIndex := 0;
tb_consulta.TabVisible := false;
tb_cadastro.TabVisible := true;
end;

procedure Tfrm_cad_clientes.ConfigBotoes;
begin
btn_inserir .Enabled:= dm.tb_clientes.State in [ dsbrowse ];
btn_editar .Enabled:= dm.tb_clientes.State in [ dsbrowse ];
btn_excluir .Enabled:= dm.tb_clientes.State in [ dsbrowse ];

btn_salvar .Enabled:= dm.tb_clientes.State in [ dsinsert,dsedit ];
btn_cancelar .Enabled:= dm.tb_clientes.State in [ dsinsert,dsedit ];


end;


procedure Tfrm_cad_clientes.DBGrid1CellClick(Column: TColumn);
begin
//  txt_impressao.text:= IntToStr(dm.SQL_con_clientecli_id.Value);
  btn_imprimir.Enabled:= true;



end;


procedure Tfrm_cad_clientes.FormCreate(Sender: TObject);
begin
PageControl1.TabIndex:=0;
tb_consulta.TabVisible := false;

btn_salvar.Enabled := false;
btn_cancelar.Enabled := false;

txt_buscar.Visible:= false;
lb_buscar.Visible:= false;
data_nasc.Visible:= false;

btn_imprimir.Enabled := false;
btn_pesquisar.Enabled:= false;

btn_mudaimg.Enabled:= false;


end;

procedure Tfrm_cad_clientes.Image3Click(Sender: TObject);
begin
if dm.tb_clientes.State in [dsinsert,dsedit] then
begin
  showmessage(' Salve ou cancele antes de fechar ');
  exit;
end
else
begin
  close;
end;
end;



procedure Tfrm_cad_clientes.Image5Click(Sender: TObject);
begin
pageControl1.TabIndex := 0;
tb_consulta.TabVisible := false;
tb_cadastro.TabVisible := true;
end;



procedure Tfrm_cad_clientes.rg_opcoesClick(Sender: TObject);
begin
   case rg_opcoes.ItemIndex of
      0:
        begin
        txt_buscar.Visible:= true;
        lb_buscar.Visible := true;
        lb_buscar.Caption := 'Digite o código';
        data_nasc.Visible := false;
        txt_buscar.Clear;

        btn_pesquisar.Enabled:= true;
        txt_buscar.SetFocus;


        end;

      1:
        begin
        txt_buscar.Visible:= true;
        lb_buscar.Visible := true;
        lb_buscar.Caption := 'Digite o nome';
        data_nasc.Visible := false;
        txt_buscar.Clear;

        btn_pesquisar.Enabled:= true;
        txt_buscar.SetFocus;

        end;

      2:
        begin

        txt_buscar.Visible:= true;
        lb_buscar.Visible := true;
        lb_buscar.Caption := 'Digite o preco';
        data_nasc.Visible := false;
        txt_buscar.Clear;

        btn_pesquisar.Enabled:= true;
        txt_buscar.SetFocus;
        end;

      3:
        begin
        txt_buscar.Visible:= true;
        lb_buscar.Visible := true;
        lb_buscar.Caption := 'Digite o genero';
        data_nasc.Visible := false;
        txt_buscar.Clear;

        btn_pesquisar.Enabled:= true;
        txt_buscar.SetFocus;

        end;
      4:
        begin
        txt_buscar.Visible:= false;
        lb_buscar.Visible := true;
        lb_buscar.Caption := 'Digite a data de lançamento';
        data_nasc.Visible := true;
        txt_buscar.text:= 'a';

        btn_pesquisar.Enabled:= true;


        end;

      5:
        begin
        txt_buscar.Visible:= true;
        lb_buscar.Visible := true;
        lb_buscar.Caption := 'Digite a plataforma';
        data_nasc.Visible := false;
        txt_buscar.Clear;

        btn_pesquisar.Enabled:= true;
        txt_buscar.SetFocus;

        end;


   end;




end;




procedure Tfrm_cad_clientes.txt_buscarKeyPress(Sender: TObject; var Key: Char);
begin

  case rg_opcoes.ItemIndex of
  0:
  begin
    if(key in ['0'..'9'] = false ) and (word (key) <> VK_BACK) then
    begin
      ShowMessage ('Digite aqui apenas números');
      key := #0;
    end;
  end;

   2:
  begin
     if(key in ['0'..'9'] = false ) and (word (key) <> VK_BACK) then
    begin
      ShowMessage ('Digite aqui apenas números');
      key := #0;
    end;
  end;
  end;
end;



end.
