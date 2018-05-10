unit _dSalesReportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniURLFrame,
  Interfaces;

type
  TdSalesReportForm = class(TUniForm, ISalesReportForm)
    UniPDFFrame1: TUniPDFFrame;
  private
    procedure SetPDFUrl(const Value : string);
  public
    procedure ShowAsModal;

    property PDFUrl : string write SetPDFUrl;
  end;

function dSalesReportForm: TdSalesReportForm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function dSalesReportForm: TdSalesReportForm;
begin
  Result := TdSalesReportForm(UniMainModule.GetFormInstance(TdSalesReportForm));
end;

{ TdSalesReportForm }

procedure TdSalesReportForm.SetPDFUrl(const Value : string);
begin
  UniPDFFrame1.PdfURL := Value;
end;

procedure TdSalesReportForm.ShowAsModal;
begin
  ShowModal;
end;

end.
