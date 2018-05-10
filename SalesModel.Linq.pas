unit SalesModel.Linq; 

{$I EntityDac.inc}

interface

uses
  EntityDAC.Linq.Expression,
  EntityDAC.MetaData;
 
type
  ICustomerExpression = interface;
  IItemExpression = interface;
  IOrderExpression = interface;
  IProductExpression = interface;
  IUserExpression = interface;
  IViewsaleExpression = interface;
  // collections
  ICustomerOrdersExpression = interface;
  IOrderItemsExpression = interface;
  IProductItemsExpression = interface;
  
  ICustomerExpression = interface(IMetaType)
  ['{95356453-3677-4214-B2D5-5709FBFA89FA}']
    function Id: TExpression;
    function Name: TExpression;

    function Orders: ICustomerOrdersExpression;
    function Unique: ICustomerExpression;
  end;
  
  IItemExpression = interface(IMetaType)
  ['{71B0C8D9-76A9-4543-97AA-6701BFCDD672}']
    function Orderid: TExpression;
    function Productid: TExpression;
    function Quantity: TExpression;

    function Order: IOrderExpression;
    function Product: IProductExpression;
    function Unique: IItemExpression;
  end;
  
  IOrderExpression = interface(IMetaType)
  ['{3CDDA521-F978-4C6C-97C8-528869A6A8D5}']
    function Id: TExpression;
    function Customerid: TExpression;
    function Posted: TExpression;
    function Paid: TExpression;

    function Customer: ICustomerExpression;

    function Items: IOrderItemsExpression;
    function Unique: IOrderExpression;
  end;
  
  IProductExpression = interface(IMetaType)
  ['{BA981021-B416-4463-8930-290085960204}']
    function Id: TExpression;
    function Description: TExpression;
    function Price: TExpression;

    function Items: IProductItemsExpression;
    function Unique: IProductExpression;
  end;
  
  IUserExpression = interface(IMetaType)
  ['{438228CC-5DFA-46EB-9B39-AAA199F21948}']
    function Username: TExpression;
    function Password: TExpression;
    function Admin: TExpression;
    function Unique: IUserExpression;
  end;
  
  IViewsaleExpression = interface(IMetaType)
  ['{136AE952-A3C3-4C1A-BD4C-21DDDB749896}']
    function Customerid: TExpression;
    function Customer: TExpression;
    function Orderid: TExpression;
    function Posted: TExpression;
    function Productid: TExpression;
    function Product: TExpression;
    function Quantity: TExpression;
    function Price: TExpression;
    function Total: TExpression;
    function Unique: IViewsaleExpression;
  end;

  TCustomerExpression = class(TMetaTypeExpression, ICustomerExpression)
  public
    function UniqueCustomer: ICustomerExpression;
    function ICustomerExpression.Unique = UniqueCustomer;

    function Id: TExpression;
    function Name: TExpression;

    function Orders: ICustomerOrdersExpression;
  end;

  TItemExpression = class(TMetaTypeExpression, IItemExpression)
  public
    function UniqueItem: IItemExpression;
    function IItemExpression.Unique = UniqueItem;

    function Orderid: TExpression;
    function Productid: TExpression;
    function Quantity: TExpression;

    function Order: IOrderExpression;
    function Product: IProductExpression;
  end;

  TOrderExpression = class(TMetaTypeExpression, IOrderExpression)
  public
    function UniqueOrder: IOrderExpression;
    function IOrderExpression.Unique = UniqueOrder;

    function Id: TExpression;
    function Customerid: TExpression;
    function Posted: TExpression;
    function Paid: TExpression;

    function Customer: ICustomerExpression;

    function Items: IOrderItemsExpression;
  end;

  TProductExpression = class(TMetaTypeExpression, IProductExpression)
  public
    function UniqueProduct: IProductExpression;
    function IProductExpression.Unique = UniqueProduct;

    function Id: TExpression;
    function Description: TExpression;
    function Price: TExpression;

    function Items: IProductItemsExpression;
  end;

  TUserExpression = class(TMetaTypeExpression, IUserExpression)
  public
    function UniqueUser: IUserExpression;
    function IUserExpression.Unique = UniqueUser;

    function Username: TExpression;
    function Password: TExpression;
    function Admin: TExpression;
  end;

  TViewsaleExpression = class(TMetaTypeExpression, IViewsaleExpression)
  public
    function UniqueViewsale: IViewsaleExpression;
    function IViewsaleExpression.Unique = UniqueViewsale;

    function Customerid: TExpression;
    function Customer: TExpression;
    function Orderid: TExpression;
    function Posted: TExpression;
    function Productid: TExpression;
    function Product: TExpression;
    function Quantity: TExpression;
    function Price: TExpression;
    function Total: TExpression;
  end;

  ICustomerOrdersExpression = interface(IMetaCollection)
  ['{95356453-3677-4214-B2D5-5709FBFA89FA}']
    function RowType: IOrderExpression;
  end;

  TCustomerOrdersExpression = class(TMetaCollectionExpression, ICustomerOrdersExpression)
  public
    function RowTypeOrder: IOrderExpression;
    function ICustomerOrdersExpression.RowType = RowTypeOrder;
  end;

  IOrderItemsExpression = interface(IMetaCollection)
  ['{3CDDA521-F978-4C6C-97C8-528869A6A8D5}']
    function RowType: IItemExpression;
  end;

  TOrderItemsExpression = class(TMetaCollectionExpression, IOrderItemsExpression)
  public
    function RowTypeItem: IItemExpression;
    function IOrderItemsExpression.RowType = RowTypeItem;
  end;

  IProductItemsExpression = interface(IMetaCollection)
  ['{BA981021-B416-4463-8930-290085960204}']
    function RowType: IItemExpression;
  end;

  TProductItemsExpression = class(TMetaCollectionExpression, IProductItemsExpression)
  public
    function RowTypeItem: IItemExpression;
    function IProductItemsExpression.RowType = RowTypeItem;
  end;

implementation

{ TCustomerExpression }

function TCustomerExpression.UniqueCustomer: ICustomerExpression;
begin
  Result := (inherited Unique) as ICustomerExpression;
end;

function TCustomerExpression.Id: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Customer'].MetaAttributes.Get('Id')));
end;

function TCustomerExpression.Name: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Customer'].MetaAttributes.Get('Name')));
end;

function TCustomerExpression.Orders: ICustomerOrdersExpression;
begin
  Result := TCustomerOrdersExpression.Create(Self, Model['Customer'].MetaCollections.Get('Orders')) as ICustomerOrdersExpression;
end;

{ TItemExpression }

function TItemExpression.UniqueItem: IItemExpression;
begin
  Result := (inherited Unique) as IItemExpression;
end;

function TItemExpression.Orderid: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Item'].MetaAttributes.Get('Orderid')));
end;

function TItemExpression.Productid: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Item'].MetaAttributes.Get('Productid')));
end;

function TItemExpression.Quantity: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Item'].MetaAttributes.Get('Quantity')));
end;

function TItemExpression.Order: IOrderExpression;
begin
  Result := TOrderExpression.Create(Self, Model['Item'].MetaReferences.Get('Order'));
end;

function TItemExpression.Product: IProductExpression;
begin
  Result := TProductExpression.Create(Self, Model['Item'].MetaReferences.Get('Product'));
end;

{ TOrderExpression }

function TOrderExpression.UniqueOrder: IOrderExpression;
begin
  Result := (inherited Unique) as IOrderExpression;
end;

function TOrderExpression.Id: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Order'].MetaAttributes.Get('Id')));
end;

function TOrderExpression.Customerid: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Order'].MetaAttributes.Get('Customerid')));
end;

function TOrderExpression.Posted: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Order'].MetaAttributes.Get('Posted')));
end;

function TOrderExpression.Paid: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Order'].MetaAttributes.Get('Paid')));
end;

function TOrderExpression.Customer: ICustomerExpression;
begin
  Result := TCustomerExpression.Create(Self, Model['Order'].MetaReferences.Get('Customer'));
end;

function TOrderExpression.Items: IOrderItemsExpression;
begin
  Result := TOrderItemsExpression.Create(Self, Model['Order'].MetaCollections.Get('Items')) as IOrderItemsExpression;
end;

{ TProductExpression }

function TProductExpression.UniqueProduct: IProductExpression;
begin
  Result := (inherited Unique) as IProductExpression;
end;

function TProductExpression.Id: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Product'].MetaAttributes.Get('Id')));
end;

function TProductExpression.Description: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Product'].MetaAttributes.Get('Description')));
end;

function TProductExpression.Price: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Product'].MetaAttributes.Get('Price')));
end;

function TProductExpression.Items: IProductItemsExpression;
begin
  Result := TProductItemsExpression.Create(Self, Model['Product'].MetaCollections.Get('Items')) as IProductItemsExpression;
end;

{ TUserExpression }

function TUserExpression.UniqueUser: IUserExpression;
begin
  Result := (inherited Unique) as IUserExpression;
end;

function TUserExpression.Username: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['User'].MetaAttributes.Get('Username')));
end;

function TUserExpression.Password: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['User'].MetaAttributes.Get('Password')));
end;

function TUserExpression.Admin: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['User'].MetaAttributes.Get('Admin')));
end;

{ TViewsaleExpression }

function TViewsaleExpression.UniqueViewsale: IViewsaleExpression;
begin
  Result := (inherited Unique) as IViewsaleExpression;
end;

function TViewsaleExpression.Customerid: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Viewsale'].MetaAttributes.Get('Customerid')));
end;

function TViewsaleExpression.Customer: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Viewsale'].MetaAttributes.Get('Customer')));
end;

function TViewsaleExpression.Orderid: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Viewsale'].MetaAttributes.Get('Orderid')));
end;

function TViewsaleExpression.Posted: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Viewsale'].MetaAttributes.Get('Posted')));
end;

function TViewsaleExpression.Productid: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Viewsale'].MetaAttributes.Get('Productid')));
end;

function TViewsaleExpression.Product: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Viewsale'].MetaAttributes.Get('Product')));
end;

function TViewsaleExpression.Quantity: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Viewsale'].MetaAttributes.Get('Quantity')));
end;

function TViewsaleExpression.Price: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Viewsale'].MetaAttributes.Get('Price')));
end;

function TViewsaleExpression.Total: TExpression;
begin
  Result := TExpression(TMetaExpression.Create(Self, Model['Viewsale'].MetaAttributes.Get('Total')));
end;

{ TCustomerOrdersExpression }

function TCustomerOrdersExpression.RowTypeOrder: IOrderExpression;
begin
  Result := TOrderExpression.Create(Self as TMetaExpression, Model['Order']) as IOrderExpression;
end;

{ TOrderItemsExpression }

function TOrderItemsExpression.RowTypeItem: IItemExpression;
begin
  Result := TItemExpression.Create(Self as TMetaExpression, Model['Item']) as IItemExpression;
end;

{ TProductItemsExpression }

function TProductItemsExpression.RowTypeItem: IItemExpression;
begin
  Result := TItemExpression.Create(Self as TMetaExpression, Model['Item']) as IItemExpression;
end;

end.
