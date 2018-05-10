unit SalesModel.Context;

{$I EntityDac.inc}

interface

uses
  Classes,
  EntityDAC.MetaData,
  EntityDAC.EntityConnection,
  EntityDAC.EntityContext,
  SalesModel.Linq;

type
{$IFDEF VER16P}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
{$ENDIF}
  TSalesContext = class(TCustomEntityContext)
  public
  {$IFNDEF EXPRESS}
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; AConnection: TEntityConnection); overload;
    constructor Create(AOwner: TComponent; AModel: TMetaModel; AConnection: TEntityConnection); overload; override;
  {$ENDIF}
    constructor Create; overload; override;
    constructor Create(AConnection: TEntityConnection); overload;
    constructor Create(AModel: TMetaModel; AConnection: TEntityConnection); overload; override;

    function Customer: ICustomerExpression;
    function Item: IItemExpression;
    function Order: IOrderExpression;
    function Product: IProductExpression;
    function User: IUserExpression;
    function Viewsale: IViewsaleExpression;

    property CacheManager;
    property QueryCompiler;
{$IFNDEF EXPRESS}
  published
    property Connection;
    property Options;

    property OnGetGeneratorValue;
{$ENDIF}
  end;

{$IFNDEF EXPRESS}
procedure Register;
{$ENDIF}

implementation

{$IFNDEF EXPRESS}
uses
  EntityDAC.Context;

procedure Register;
begin
  RegisterComponents('Devart EntityDAC Custom', [TSalesContext]);
end;
{$ENDIF}

{ TSalesContext }

{$IFNDEF EXPRESS}
constructor TSalesContext.Create(AOwner: TComponent);
begin
  Create(AOwner, 'SalesModel', nil);
end;

constructor TSalesContext.Create(AOwner: TComponent; AConnection: TEntityConnection);
begin
  Create(AOwner, 'SalesModel', AConnection);
end;

constructor TSalesContext.Create(AOwner: TComponent; AModel: TMetaModel; AConnection: TEntityConnection);
begin
  inherited Create(AOwner, AModel, AConnection);

  Options.AllowNullableString := False;
  Options.AllowNullableBytes := False;
end;
{$ENDIF}

constructor TSalesContext.Create;
begin
  Create('SalesModel', nil);
end;

constructor TSalesContext.Create(AConnection: TEntityConnection);
begin
  Create(Models.Get('SalesModel'), AConnection);
end;

constructor TSalesContext.Create(AModel: TMetaModel; AConnection: TEntityConnection);
begin
  inherited Create(AModel, AConnection);

  Options.AllowNullableString := False;
  Options.AllowNullableBytes := False;
end;

function TSalesContext.Customer: ICustomerExpression;
begin
  Result := TCustomerExpression.Create(Model, Model['Customer']) as ICustomerExpression;
end;

function TSalesContext.Item: IItemExpression;
begin
  Result := TItemExpression.Create(Model, Model['Item']) as IItemExpression;
end;

function TSalesContext.Order: IOrderExpression;
begin
  Result := TOrderExpression.Create(Model, Model['Order']) as IOrderExpression;
end;

function TSalesContext.Product: IProductExpression;
begin
  Result := TProductExpression.Create(Model, Model['Product']) as IProductExpression;
end;

function TSalesContext.User: IUserExpression;
begin
  Result := TUserExpression.Create(Model, Model['User']) as IUserExpression;
end;

function TSalesContext.Viewsale: IViewsaleExpression;
begin
  Result := TViewsaleExpression.Create(Model, Model['Viewsale']) as IViewsaleExpression;
end;

end.
