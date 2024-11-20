unit U_dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;
  //frxClass, frxExportPDF, frxExportBaseDialog, frxDBSet;

type
  Tdm = class(TDataModule)
    FDConnection1: TFDConnection;
    driver: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    tb_clientes: TFDTable;
    DataSource1: TDataSource;
    SQL_imprimir_cliente: TFDQuery;
    //Report_cliente: TfrxReport;
    //DS_rel_cliente: TfrxDBDataset;
    tb_clientesgame_id: TFDAutoIncField;
    tb_clientesgame_nome: TStringField;
    tb_clientesgame_desenvolvedor: TStringField;
    tb_clientesgame_distribuidor: TStringField;
    tb_clientesgame_genero: TStringField;
    tb_clientesgame_plataforma: TStringField;
    tb_clientesgame_data: TDateField;
    tb_clientesgame_preco: TStringField;
    tb_clientesgame_imagem: TBlobField;
    SQL_con_cliente: TFDQuery;
    DS_con_cliente: TDataSource;
    //frxPDFExport1: TfrxPDFExport;
    procedure DataModuleCreate(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
FDConnection1.Params.Database:= 'alex';
FDConnection1.Params.Username:= 'root';
FDConnection1.Params.Password:= '';

FDConnection1.Connected:= true;
driver.VendorLib := GetCurrentDir + '\lib\libmysql.dll';
end;

end.
