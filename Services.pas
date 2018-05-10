unit Services;

interface

type

  TServices = class

    class procedure EditUsers;
    class procedure EditOrders;
    class procedure ReportSales;
  end;

implementation

uses
  MainModule,
  Interfaces,
  Spring.Container,
  ReportDM;

{ TServices }

class procedure TServices.EditOrders;
var
  frm : IOrdersEditorForm;
begin
  frm := UniMainModule.Container.Resolve<IOrdersEditorForm>;
  frm.ShowAsModal;
end;

class procedure TServices.EditUsers;
var
  frm : IOperatorsEditorForm;
begin
  frm := UniMainModule.Container.Resolve<IOperatorsEditorForm>;
  frm.ShowAsModal;
end;

class procedure TServices.ReportSales;
var
  frm : ISalesReportForm;
  rdm : TfrDataModule;
begin
  frm := UniMainModule.Container.Resolve<ISalesReportForm>;

  rdm := TfrDataModule.Create(nil);
  try
    frm.PDFUrl := rdm.ExportReport;
    frm.ShowAsModal;
  finally
    rdm.Free;
  end;
end;

end.
