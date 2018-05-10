unit _mOrdersForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIForm, uniGUImForm, uniGUImJSForm,
  uniGUIBaseClasses, uniDBNavigator, unimDBNavigator, uniBasicGrid, uniDBGrid,
  unimDBListGrid, unimDBGrid, uniToolBar, unimToolbar, unimCarousel,
  Interfaces,
  OrdersDM;

type
  TmOrdersForm = class(TUnimForm, IOrdersEditorForm)
    dbgOrders: TUnimDBGrid;
    barOrders: TUnimToolBar;
    btnMarkAsPaid: TUnimToolButton;
    UnimCarousel1: TUnimCarousel;
    cpOrders: TUnimCarouselPage;
    pnlOrders: TUnimContainerPanel;
    pnlItems: TUnimContainerPanel;
    barItems: TUnimToolBar;
    dbgItems: TUnimDBGrid;
    cpCustomers: TUnimCarouselPage;
    barCustomers: TUnimToolBar;
    dbgCustomers: TUnimDBGrid;
    cpProducts: TUnimCarouselPage;
    barProducts: TUnimToolBar;
    dbgProducts: TUnimDBGrid;
    cntOrders: TUnimToolButton;
    dbnOrders: TUnimDBNavigator;
    UnimToolButton2: TUnimToolButton;
    cntItems: TUnimToolButton;
    dbnItems: TUnimDBNavigator;
    UnimToolButton4: TUnimToolButton;
    cntProducts: TUnimToolButton;
    dbnProducts: TUnimDBNavigator;
    UnimToolButton6: TUnimToolButton;
    cntCustomers: TUnimToolButton;
    dbnCustomers: TUnimDBNavigator;
  private
    { Private declarations }
  public
    procedure ShowAsModal;
  end;

function mOrdersForm: TmOrdersForm;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function mOrdersForm: TmOrdersForm;
begin
  Result := TmOrdersForm(UniMainModule.GetFormInstance(TmOrdersForm));
end;

procedure TmOrdersForm.ShowAsModal;
begin
  ShowModal;
end;

end.
