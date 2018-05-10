unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniLabel,
  uniButton, uniToolBar, uniBitBtn, Vcl.Menus, uniMainMenu, uniPanel, uniPageControl, uniTimer, uniStatusBar,
  uniTreeView, uniTreeMenu, uniSplitter, uniGUIFrame,
  Session.RegServices;

type
  TMainForm = class(TUniForm)
    UniToolBar1: TUniToolBar;
    btnEditUsers: TUniToolButton;
    btnEditOrders: TUniToolButton;
    btnReportSales: TUniToolButton;
    UniTreeMenu1: TUniTreeMenu;
    UniTimer1: TUniTimer;
    UniStatusBar1: TUniStatusBar;
    UniPageControl1: TUniPageControl;
    btnMicro: TUniToolButton;
    UniTabSheet1: TUniTabSheet;
    procedure NavTreeClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Logoff1Click(Sender: TObject);
    procedure UniTimer1Timer(Sender: TObject);
    procedure TabSheetClose(Sender: TObject; var AllowClose: Boolean);
    procedure UniTreeMenu1SelectionChange(Sender: TObject);
    procedure btnMicroClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowModuleAsTab(aModule : IModule; aID : integer);
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  TypInfo,
  uniGUIVars, MainModule, uniGUIApplication, Interfaces;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.btnMicroClick(Sender: TObject);
begin
  UniTreeMenu1.Micro := not UniTreeMenu1.Micro;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TMainForm.Logoff1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TMainForm.UniTimer1Timer(Sender: TObject);
begin
  UniStatusBar1.Panels[0].Text := FormatDateTime('mm/dd/yyyy hh:nn', Time);
end;

procedure TMainForm.TabSheetClose(Sender: TObject; var AllowClose: Boolean);
var
  N : TUniTreeNode;
begin
  N := (Sender as TUniTabSheet).Data;
  if N is TUniTreeNode then
    (N as TUniTreeNode).Data := nil;

  if UniPageControl1.PageCount = 1 then
    UniTreeMenu1.Selected := nil;
end;

procedure TMainForm.ShowModuleAsTab(aModule : IModule; aID : integer);
var
  Fr : TUniFrame;
  Ts : TUniTabSheet;
  Li : ILocatable;
begin
  Fr := aModule.Instance as TUniFrame;
  if not Assigned(Fr) then
    raise Exception.Create(Format('Module <%s> not available!', [aModule]));

  Ts := TUniTabSheet.Create(Self);
  Ts.PageControl := UniPageControl1;

  if aID >= 0 then
    if Supports(Fr, ILocatable, Li) then
      Li.LocateID(aID)
    else
      raise Exception.Create(Format('Module <%s> does not support "locatable" interface!', [aModule.Name]));

  Ts.Caption    := aModule.Name;
  if aID >= 0 then
    Ts.Caption := Format('%s = (%d)', [Ts.Caption, aID]);
  Ts.ImageIndex := aModule.IconIndex;

  Ts.AlignmentControl := uniAlignmentClient;
  Ts.Layout     := 'fit';
  Ts.Closable   := True;
  Ts.OnClose    := TabSheetClose;

  Fr.Align  := alClient;
  Fr.Parent := Ts;

  UniPageControl1.ActivePage := Ts;
end;

procedure TMainForm.NavTreeClick(Sender: TObject);
var
  Nd : TUniTreeNode;
  Ts : TUniTabSheet;
  Fr : TUniFrame;
  md : IModule;
  NdText : string;

begin
  //Nd := NavTree.Selected;

  if Nd.Count = 0 then
  begin
    Ts := Nd.Data;
    NdText := Nd.Text;

    if NdText <> '' then
      md := UniMainModule.RegVar.GetModuleByTreeCaption(NdText);

    if not Assigned(md) then
      exit;

    if not Assigned(Ts) or (Assigned(md) and not md.Singleton) then
    begin
      Ts := TUniTabSheet.Create(Self);
      Ts.PageControl := UniPageControl1;

      Ts.AlignmentControl := uniAlignmentClient;
      Ts.Layout     := 'fit';
      Ts.Closable   := True;
      Ts.OnClose    := TabSheetClose;
      Ts.Tag        := NativeInt(Nd);

//      DfmModule := False;
//      if Copy(NdText, 1 ,1) = '_' then
//      begin
//        DfmModule := True;
//        Delete(NdText, 1 ,1);
//      end;

      Ts.Caption    := NdText;
      Ts.ImageIndex := Nd.ImageIndex;

//      if DfmModule then
//      begin
//        Fr := TIQUniModuleFrame.Create(Self);
//        MM := TMemoryStream.Create;
//        try
//          MM.LoadFromFile(UniServerModule.DFMFolder + Nd.Parent.Text + '\' + NdText + '.dfm' );
//          LoadComponentFromStream(Self, Fr, MM);
//          DoAfterCreateFrame(Fr as TIQUniModuleFrame);
//          Fr.OnDestroy := FrameDestroy;
//        finally
//          MM.Free;
//        end;
//
//        Fr.Align  := alClient;
//        Fr.Parent := Ts;
//
//        Nd.Data := Ts;
//      end
//      else
      begin
        Fr := md.Instance as TUniFrame;

        if Assigned(Fr) then
        begin
          if not md.Singleton then
            Fr.Name := Fr.Name + IntToStr(md.Sequence);

          Fr.Align  := alClient;
          Fr.Parent := Ts;

          Nd.Data := Ts;
        end
        else
        begin
          UniPageControl1.RemoveControl(Ts);

          Abort;
        end;
      end;
    end;
    UniPageControl1.ActivePage := Ts;
  end;
end;

procedure TMainForm.UniTreeMenu1SelectionChange(Sender: TObject);
var
  N : TUniTreeNode;
  T : TUniTabSheet;
  I : IInterface;
  C : TControl;
begin
  N := UniTreeMenu1.Selected;

  // Check if the selected node is valid and is a leaf (that is,
  // if it will have an associated tabsheet)

  if Assigned(N) and N.IsLeaf then
  begin
    if N.Data = nil then
    begin
      // This node was never selected or it is transient
      // Create the tabsheet

      T := TUniTabSheet.Create(Self);
      T.PageControl       := UniPageControl1;
      T.AlignmentControl  := uniAlignmentClient;
      T.Layout            := 'fit';
      T.Caption           := N.Text;
      T.ImageIndex        := N.ImageIndex;
      T.Closable          := True;
      T.OnClose           := TabSheetClose;

      // Use the node information to create the frame

      I := UniMainModule.Container.Resolve<IOperatorsEditorForm>;
      if Assigned(I) then
      begin
        C := TControl(I);
        if C.InheritsFrom(TUniForm) then
        begin
          TUniForm(C).Align := alClient;
          T.InsertControl(C);
          TUniForm(C).Parent := T;
        end
        else if TControl(I).InheritsFrom(TUniFrame) then
        begin
          TUniFrame(C).LayoutConfig.Region := 'center';
          T.InsertControl(C);
          TUniFrame(C).Parent := T;
        end;
      end;

      // Keep track of the tabsheet associated to the node

      N.Data := T;

      // Keep track of the node associated to the tabsheet

      T.Data := N;
    end
    else
    begin
      // This node was previously selected and it keeps the link to its tabsheet

      T := N.Data;
    end;

    // Switch to the selected tabsheet

    UniPageControl1.ActivePage := T;
  end;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
