unit Server.Resources;

interface

uses
  _dOperatorsForm;

type

  TModuleDef = record
    ModuleClass : TClass;
    Singleton   : boolean;
    ImplInfs    : array of integer
  end;

  TNavNode = record
    Caption : string;
    Level   : integer;
    FormIdx : integer;
  end;

const

  IntfQty = 0;
  FormQty = 1;
  NodeQty = 3;

  ModuleDefs : array[1..FormQty] of TModuleDef =
  (
//    { 1 } (ModuleClass: TFrmDayHrsCalc         ; Singleton: false),
//    { 2 } (ModuleClass: TFrmLabor_Details_Base ; Singleton: false),
//    { 3 } (ModuleClass: TFrmLabor_Shift        ; Singleton: false),
//    { 4 } (ModuleClass: TFrmProjectedHoursShift; Singleton: false),
//    { 5 } (ModuleClass: TFrmSelClass           ; Singleton: false),
      { 6 } (ModuleClass: TdOperatorsForm        ; Singleton: true )
//    { 7 } (ModuleClass: TFrmShowDayParts       ; Singleton: false),
//    { 8 } (ModuleClass: TFrmLabor_WO           ; Singleton: false)
  );

  NavTree : array[1..NodeQty] of TNavNode =
  (
    (Caption: 'Home'         ; Level: 0; FormIdx: 0),
    (Caption: 'Capacity'     ; Level: 1; FormIdx: 0),
    (Caption: 'Capacity Main'; Level: 2; FormIdx: 1)
  );

//var
//  Intfs : array[1..IntfQty] of TGUID;

implementation

initialization

end.
