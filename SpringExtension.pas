unit SpringExtension;

interface

uses
  System.Rtti,
  Spring.Container.Core,
  Spring.Container.LifetimeManager;

type

  TCustomLifetimeManager = class(TTransientLifetimeManager)
  public
    procedure Release(const instance: TValue); override;
  end;

implementation

{ TCustomLifetimeManager }

procedure TCustomLifetimeManager.Release(const instance: TValue);
begin
  // Instances won't be released because they are managed by uniGUI
end;

end.
