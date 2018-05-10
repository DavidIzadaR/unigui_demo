unit Session.RegServices;

interface

uses
  Spring.Collections,
  Spring.Collections.Lists,
  Controls, Classes;

type

  // Our "modules" will be of two kinds: TUniForm and TUniFrame
  // A TUniFrame will be used in the main page as a tab in the page control
  // but it can also be used in a pop-up ad-hoc form.
  // A TUniForm should only be used as a pop-up form (modal or non-modal).
  
  TDataModuleClass = class of TDataModule;

  IModule = interface
    ['{85CE17E9-EF44-41D1-A7FF-39A74FE494DC}']
    function  GetName            : string;
    function  GetSingleton       : boolean;
    function  GetIconIndex       : integer;
    function  GetInstance        : TControl;
    function  GetIsFrame         : boolean;
    function  GetIsForm          : boolean;
    function  GetSequence        : integer;
    procedure SetIconIndex       (const Value : integer);
    function  GetDataModuleClass : TDataModuleClass;
    procedure SetDataModuleClass (const Value : TDataModuleClass);
    function  GetOwnsDataModule  : boolean;
    procedure SetOwnsDataModule  (const Value : boolean);

    procedure DoOnCreate;
    procedure DoOnDestroy;

    property  Name            : string           read GetName;
    property  Singleton       : boolean          read GetSingleton;
    property  IconIndex       : integer          read GetIconIndex       write SetIconIndex;
    property  Instance        : TControl         read GetInstance;
    property  IsFrame         : boolean          read GetIsFrame;
    property  IsForm          : boolean          read GetIsForm;
    property  Sequence        : integer          read GetSequence;
    property  DataModuleClass : TDataModuleClass read GetDataModuleClass write SetDataModuleClass;
    property  OwnsDataModule  : boolean          read GetOwnsDataModule  write SetOwnsDataModule;
  end;

  IModules = IDictionary<string, IModule>;

  // If a module can be the target of a Jump, its concrete class should implement the interface
  // ILocatable and its method LocateID(aID)

  ILocatable = interface
    ['{73DA3609-9FEC-45A5-A1FB-F03148660D3B}']

    procedure LocateID(aID : integer);
  end;

  // This registration system will be upgraded to allow several ways of
  // registering categories and modules.
  // Once registration is finished, it will act as the factory for the
  // dynamic handling of any of the registered modules

  ISessionRegistration = interface
    ['{814E302C-5C2E-43F5-9891-C3D2B44FD778}']
    function  GetModules  : IModules;

    property  Modules     : IModules read GetModules;

    procedure RegisterModule  (aModuleClass : TClass; aSingleton : boolean);
    procedure RegisterServerModules;

    function  GetModuleByTreeCaption(aTreeCaption : string) : IModule;

    function  GetModule       (aModuleName : string ) : IModule;
    function  CreateInstance  (aModuleName : string ) : TControl;
    procedure ReleaseInstance (aInstance   : TObject);

    procedure ShowModuleAsTab (aModuleName : string; aID : integer = -1);
    procedure ShowModuleAsForm(aModuleName : string; aID : integer = -1);
  end;

implementation

end.
