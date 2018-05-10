unit _mSalesReportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIForm, uniGUImForm, uniGUImJSForm,
  uniGUIBaseClasses, uniURLFrame, unimURLFrame,
  Interfaces;

type
  TmSalesReportForm = class(TUnimForm, ISalesReportForm)
    UnimPDFFrame1: TUnimPDFFrame;
  private
    procedure SetPDFUrl(const Value : string);
  public
    procedure ShowAsModal;

    property PDFUrl : string write SetPDFUrl;
  end;

function mSalesReportForm: TmSalesReportForm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function mSalesReportForm: TmSalesReportForm;
begin
  Result := TmSalesReportForm(UniMainModule.GetFormInstance(TmSalesReportForm));
end;

{ TmSalesReportForm }

procedure TmSalesReportForm.SetPDFUrl(const Value : string);
begin
   UnimPDFFrame1.PDFUrl := Value;
end;

procedure TmSalesReportForm.ShowAsModal;
begin
  ShowModal;
end;

end.
