unit OrdersDM;

interface

uses
  SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, System.ImageList, Vcl.ImgList, uniImageList,
  uniGUIBaseClasses, uniGUIClasses, System.Actions, Vcl.ActnList, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmOrders = class(TDataModule)
    dsOrders: TDataSource;
    dsItems: TDataSource;
    tblCustomers: TFDTable;
    tblCustomersID: TIntegerField;
    tblCustomersUserName: TStringField;
    tblProducts: TFDTable;
    tblProductsID: TIntegerField;
    tblProductsDescription: TStringField;
    tblProductsPrice: TCurrencyField;
    tblOrders: TFDTable;
    tblOrdersID: TIntegerField;
    tblOrdersCustomerID: TIntegerField;
    tblOrdersCustomer: TStringField;
    tblOrdersPosted: TDateTimeField;
    tblOrdersTotal: TCurrencyField;
    tblOrdersPaid: TDateTimeField;
    tblItems: TFDTable;
    tblItemsOrderID: TIntegerField;
    tblItemsProductID: TIntegerField;
    tblItemsProduct: TStringField;
    tblItemsQuantity: TIntegerField;
    tblItemsPrice: TCurrencyField;
    tblItemsTotal: TCurrencyField;
    dsCustomers: TDataSource;
    dsProducts: TDataSource;
    ActionList1: TActionList;
    actMarkAsPaid: TAction;
    procedure tblOrdersCalcFields(DataSet: TDataSet);
    procedure tblItemsCalcFields(DataSet: TDataSet);
    procedure tblItemsAfterPost(DataSet: TDataSet);
    procedure actMarkAsPaidExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function dmOrders: TdmOrders;

implementation

{$R *.dfm}

uses
  Variants,
  UniGUIVars, uniGUIMainModule, MainModule;

function dmOrders: TdmOrders;
begin
  Result := TdmOrders(UniMainModule.GetModuleInstance(TdmOrders));
end;

procedure TdmOrders.actMarkAsPaidExecute(Sender: TObject);
begin
  if tblOrders.State = dsBrowse then
    tblOrders.Edit;

  tblOrdersPaid.Value := Now;
  tblOrders.Post;
end;

procedure TdmOrders.DataModuleCreate(Sender: TObject);
begin
  tblCustomers.Open;
  tblProducts.Open;
  tblOrders.Open;
  tblItems.Open;
end;

procedure TdmOrders.DataModuleDestroy(Sender: TObject);
begin
  tblItems.Close;
  tblOrders.Close;
  tblProducts.Close;
  tblCustomers.Close;
end;

procedure TdmOrders.tblItemsAfterPost(DataSet: TDataSet);
begin
  // After posting a change in items, force a recalculation of the order

  tblOrders.Edit;
  tblOrdersCalcFields(tblOrders);
  tblOrders.Post;
end;

procedure TdmOrders.tblItemsCalcFields(DataSet: TDataSet);
begin
  if tblItems.Connection.Connected and not tblItemsQuantity.IsNull and not tblItemsPrice.IsNull then
    tblItemsTotal.Value := tblItemsQuantity.Value * tblItemsPrice.Value;
end;

procedure TdmOrders.tblOrdersCalcFields(DataSet: TDataSet);
var
  t : Variant;
begin
  t :=
    tblOrders.Connection.ExecSQLScalar
    (
      Format
      (
        'SELECT' +
        '  sum(i.Quantity * p.Price) ' +
        'FROM' +
        '  Orders o' +
        '    INNER JOIN Items    i ON o.ID = i.OrderID' +
        '    INNER JOIN Products p ON i.ProductID = p.ID ' +
        'WHERE o.ID = %d',
        [tblOrdersID.Value]
      )
    );


  if VarIsNull(t) then
    t := 0;

  tblOrdersTotal.Value := t;
end;

initialization
  RegisterModuleClass(TdmOrders);

end.
