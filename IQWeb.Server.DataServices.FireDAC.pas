unit IQWeb.Server.DataServices.FireDAC;

interface

uses
  Classes,
  Data.DB,
  Spring,
  Spring.Services,
  Spring.Collections,
  Spring.Collections.Lists,
  IQWeb.Server.DataServices;

type

  TDataServicesFireDAC_Oracle = class(TInterfacedObject, IDataServices)
  protected
    // Sorting as IndexFieldNames FieldName1[:[A|D][N]];FieldName2...
    // Where A - Ascending, D - Descending, N - Non Case Insensitive, and ; is field delimiter

    function SortingCriteriaToString(const aSortingCriteria : IDataSetSortingCriteria) : string;
    function StringToSortingCriteria(const aIndexFieldNames : string) : IDataSetSortingCriteria;
  public

    function  GetIQMSConnection   : TCustomConnection;
    function  CloneConnection     (const aConnection  : TCustomConnection) : TCustomConnection;
    function  GetQuery            (const aSQL : string) : TDataSet;
    function  GetNextSeqVal
    (
      const aConnection   : TCustomConnection;
      const aSequenceName : string
    ) : Variant;
    function  CloneDataSet
    (
      const aDataSet      : TDataSet;
            aReset        : boolean = false;
            aKeepSettings : boolean = false
    ) : TDataSet;
    function  RefreshRecord       (const aDataSet     : TDataSet) : boolean;

    function  GetSortingCriteria  (const aDataSet     : TDataSet) : IDataSetSortingCriteria;
    procedure SetSortingCriteria  (const aDataSet     : TDataSet; const aSortingCriteria : IDataSetSortingCriteria);

    procedure SetParamValue       (const aDataSet     : TDataSet; const aParamName : string; aParamValue : Variant);
    procedure NotifyOnAfterScroll (const aDataSet     : TDataSet; DoOnAfterScroll : TDataSetNotifyEvent);

    procedure SortDataSet
    (
      const aDataSet          : TDataSet;
      const aFieldName        : string;
      const aAscending        : boolean;
      const aCaseInsensitive  : boolean
    );

    function LoadBlob
    (
      const aConnection : TCustomConnection;
      const aTable,
            aKeyField,
            aColumn     : string;
      const aKeyValue   : Variant;
      const aBlob       : TMemoryStream
    ) : boolean;

    procedure SaveBlob
    (
      const aConnection : TCustomConnection;
      const aTable,
            aKeyField,
            aColumn     : string;
      const aKeyValue   : Variant;
      const aBlob       : TMemoryStream
    );
  end;

implementation

uses
  SysUtils,
  StrUtils,
  Variants,
  Spring.ResourceStrings,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  IQMS.Common.Params;

{ TDataServicesFireDAC_Oracle }

procedure TDataServicesFireDAC_Oracle.SortDataSet
(
  const aDataSet          : TDataSet;
  const aFieldName        : string;
  const aAscending        : boolean;
  const aCaseInsensitive  : boolean
);
begin
  Guard.CheckInheritsFrom(aDataSet, TFDDataSet, 'ADataSet');

  (aDataSet as TFDDataSet).IndexFieldNames :=
    aFieldName + ':' +
    IfThen(aAscending, 'A', 'D') +
    IfThen(aCaseInsensitive, 'N', '');
end;

function TDataServicesFireDAC_Oracle.GetIQMSConnection: TCustomConnection;
begin
  Result := ServiceLocator.GetService<TIQMS_Params>.IQMSConnection;
end;

function  TDataServicesFireDAC_Oracle.CloneConnection(const aConnection   : TCustomConnection) : TCustomConnection;
begin
  Guard.CheckInheritsFrom(aConnection, TFDCustomConnection, 'aConnection');

  Result := TFDCustomConnection(aConnection).CloneConnection;
end;

function TDataServicesFireDAC_Oracle.GetNextSeqVal
(
  const aConnection   : TCustomConnection;
  const aSequenceName : string
) : Variant;
begin
  Guard.CheckInheritsFrom(aConnection, TFDCustomConnection, 'aConnection');

  Result := TFDCustomConnection(aConnection).ExecSQLScalar(Format('SELECT %s.NextVal FROM dual', [aSequenceName]));
end;

function TDataServicesFireDAC_Oracle.GetQuery(const aSQL : string) : TDataSet;
var
  Qry : TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  Qry.Connection := GetIQMSConnection as TFDCustomConnection;
  Qry.SQL.Text := aSQL;

  Result := Qry;
end;

function TDataServicesFireDAC_Oracle.CloneDataSet
(
  const aDataSet      : TDataSet;
        aReset        : boolean = false;
        aKeepSettings : boolean = false
) : TDataSet;
var
  Active  : boolean;
  DataSet : TFDDataSet;
begin
  Guard.CheckInheritsFrom(aDataSet, TFDDataSet, 'ADataSet');

  DataSet := TFDMemTable.Create(nil);
  Active := aDataSet.Active;
  aDataSet.Open;
  try
    DataSet.CloneCursor(aDataSet as TFDDataSet, aReset, aKeepSettings);
  finally
    aDataSet.Active := Active;
  end;

  Result := DataSet;
end;

function TDataServicesFireDAC_Oracle.GetSortingCriteria(
  const aDataSet: TDataSet): IDataSetSortingCriteria;
begin
  Guard.CheckInheritsFrom(aDataSet, TFDDataSet, 'ADataSet');

  Result := StringToSortingCriteria((aDataSet as TFDDataSet).IndexFieldNames);
end;

procedure TDataServicesFireDAC_Oracle.SetParamValue(const aDataSet: TDataSet;
  const aParamName: string; aParamValue: Variant);
begin
  Guard.CheckInheritsFrom(aDataSet, TFDDataSet, 'ADataSet');

  (aDataSet as TFDDataSet).ParamByName(aParamName).Value := aParamValue;
end;

procedure TDataServicesFireDAC_Oracle.SetSortingCriteria(
  const aDataSet: TDataSet; const aSortingCriteria: IDataSetSortingCriteria);
begin
  Guard.CheckInheritsFrom(aDataSet, TFDDataSet, 'ADataSet');

  (aDataSet as TFDDataSet).IndexFieldNames := SortingCriteriaToString(aSortingCriteria);
end;

function TDataServicesFireDAC_Oracle.SortingCriteriaToString(
  const aSortingCriteria: IDataSetSortingCriteria): string;
var
  FieldSortingCriteria : TFieldSortingCriteria;
  DataSetSortList : TStringList;
begin
  DataSetSortList := TStringList.Create;
  try
    DataSetSortList.Delimiter := ';';

    for FieldSortingCriteria in aSortingCriteria do
      with FieldSortingCriteria do
        DataSetSortList.Add
        (
          Format
          (
            '%s:%s%s',
            [
              FieldName,
              IfThen(Ascending, 'A', 'D'),
              IfThen(CaseInsensitive, 'N', '')
            ]
          )
        );
    Result := DataSetSortList.DelimitedText;
  finally
    DataSetSortList.Free;
  end;
end;

function TDataServicesFireDAC_Oracle.StringToSortingCriteria(
  const aIndexFieldNames: string): IDataSetSortingCriteria;
begin

end;

function TDataServicesFireDAC_Oracle.LoadBlob
(
  const aConnection : TCustomConnection;
  const aTable,
        aKeyField,
        aColumn     : string;
  const aKeyValue   : Variant;
  const aBlob       : TMemoryStream
) : boolean;
const
  CRLF = #13#10;
  sqlSelectBlob =
    'SELECT %s' + CRLF +
    'FROM %s' + CRLF +
    'WHERE %s = %s';
var
  FireDAC_Connection : TFDConnection;
  SelectQuery : TFDQuery;
begin
  Guard.CheckInheritsFrom(aConnection, TFDConnection, 'AConnection');

  Result := false;

  // This is now a FireDAC connection
  FireDAC_Connection := aConnection as TFDConnection;

  // Build and execute the query
  SelectQuery := TFDQuery.Create(nil);
  try
    SelectQuery.Connection := FireDAC_Connection;
    SelectQuery.SQL.Text   :=
    Format(
      sqlSelectBlob,
      [
        aColumn,
        aTable,
        aKeyField,
        VarToStr(aKeyValue)
      ]);

    SelectQuery.Open;

    if SelectQuery.Fields[0] is TBlobField then
    begin
      (SelectQuery.Fields[0] as TBlobField).SaveToStream(aBlob);
      Result := aBlob.Size > 0;
    end;
  finally
    SelectQuery.Free;
  end;
end;

procedure TDataServicesFireDAC_Oracle.NotifyOnAfterScroll(const aDataSet: TDataSet; DoOnAfterScroll: TDataSetNotifyEvent);
begin
  Guard.CheckInheritsFrom(aDataSet, TFDDataSet, 'ADataSet');

  (aDataSet as TFDDataSet).AfterScroll := DoOnAfterScroll;
end;

function TDataServicesFireDAC_Oracle.RefreshRecord(const aDataSet: TDataSet): boolean;
begin
  Guard.CheckInheritsFrom(aDataSet, TFDDataSet, 'ADataSet');

  Result := (aDataSet as TFDDataSet).RefreshRecord;
end;

procedure TDataServicesFireDAC_Oracle.SaveBlob
(
  const aConnection : TCustomConnection;
  const aTable,
        aKeyField,
        aColumn     : string;
  const aKeyValue   : Variant;
  const aBlob       : TMemoryStream
);
const
  CRLF = #13#10;
  sqlUpdateBlob =
    'UPDATE %s' + CRLF +
    'SET' + CRLF +
    '  %s = :BLOB_COLUMN' + CRLF +
    'WHERE %s = %s';
var
  FireDAC_Connection : TFDConnection;
  UpdateCommand : TFDCommand;
begin
  Guard.CheckInheritsFrom(aConnection, TFDConnection, 'AConnection');

  // Cloning the connection to execute the update in a different transaction
  FireDAC_Connection := CloneConnection(aConnection) as TFDConnection;
  try
    // Note:  Transactions are required when writing BLOB data.  If we do
    // not use a transaction, then we will get the dreaded error:
    // "ORA-22990: LOB locators cannot span transactions"

    FireDAC_Connection.StartTransaction;

    // Build and execute the command
    UpdateCommand := TFDCommand.Create(nil);
    try
      UpdateCommand.Connection := FireDAC_Connection;
      UpdateCommand.CommandText.Text :=
        Format(
          sqlUpdateBlob,
          [
            aTable,
            aColumn,
            aKeyField,
            VarToStr(aKeyValue)
          ]);
      UpdateCommand.Params[0].DataType := ftBlob;
      UpdateCommand.Params[0].LoadFromStream(aBlob, ftOraBlob, -1);

      try
        UpdateCommand.Execute;
        FireDAC_Connection.Commit;
      except
        FireDAC_Connection.Rollback;
      end;
    finally
      UpdateCommand.Free;
    end;
  finally
    FireDAC_Connection.Free;
  end;
end;

end.
