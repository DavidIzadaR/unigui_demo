unit ReportDM;

interface

uses
  SysUtils, Classes, frxClass, frxExportPDF, frxDBSet,
  MainModule, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrDataModule = class(TDataModule)
    frxReport: TfrxReport;
    frxSales: TfrxDBDataset;
    frxPDFExport: TfrxPDFExport;
    qrySales: TFDQuery;
  private
  public
    function ExportReport: string;
  end;

implementation

uses
  ServerModule;

{$R *.dfm}

function TfrDataModule.ExportReport : string;
begin
  frxReport.PrintOptions.ShowDialog := False;
  frxReport.ShowProgress := false;

  frxReport.EngineOptions.SilentMode := True;
  frxReport.EngineOptions.EnableThreadSafe := True;
  frxReport.EngineOptions.DestroyForms := False;
  frxReport.EngineOptions.UseGlobalDataSetList := False;

  frxPDFExport.Background := True;
  frxPDFExport.ShowProgress := False;
  frxPDFExport.ShowDialog := False;
  frxPDFExport.DefaultPath := '';
  frxPDFExport.FileName := UniServerModule.NewCacheFileUrl(False, 'pdf', '', '', Result);

  frxReport.PreviewOptions.AllowEdit := False;

  if not (frxReport.PrepareReport and frxReport.Export(frxPDFExport)) then
    Result := '';
end;

end.
