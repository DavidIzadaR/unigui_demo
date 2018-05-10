unit FormDesignerUnit;

interface

uses
  Classes,
  IQModuleFormDesigner, IQUniModuleFrame;

  TFormDesigner = class
  private
    procedure AfterCreateModule(Sender: TObject);
    procedure BeforeDestroyModule(Sender: TObject);
    procedure LoadDesign(Sender: TObject; const Stream: TMemoryStream);
    procedure SaveDesign(Sender: TObject; const Stream: TMemoryStream);
    procedure NewDialog(Sender: TObject);
    procedure LoadDialog(Sender: TObject);
    procedure SaveDialog(Sender: TObject);
    procedure LoadModuleList(MList: TStrings);
    procedure DoAfterCreateFrame(Frame: TIQUniModuleFrame);
    procedure FrameDestroy(Sender: TObject);
    procedure DoBeforeDestroyFrame(Frame: TIQUniModuleFrame);
  public

    procedure StartDesigner;
  end;

implementation

uses
  IQUniEditorUtils;


procedure TFormDesigner.UniToolButtonAdminToolsClick(Sender: TObject);
begin
  StartDesigner;
end;

procedure TFormDesigner.DoAfterCreateFrame(Frame: TIQUniModuleFrame);
var
  DM : TComponent;
  II : IIQDataModuleFrameEventHandler;
begin
  if Assigned(Frame) and Assigned(Frame.Controller) then
  begin
    DM := Frame.Controller.Owner;
    if Supports(DM, IIQDataModuleFrameEventHandler, II) then
      II.DoOnFrameCreate(Frame);
  end;
end;

procedure TFormDesigner.DoBeforeDestroyFrame(Frame: TIQUniModuleFrame);
var
  DM : TComponent;
  II : IIQDataModuleFrameEventHandler;
begin
  if Assigned(Frame) and Assigned(Frame.Controller) then
  begin
    DM := Frame.Controller.Owner;
    if Supports(DM, IIQDataModuleFrameEventHandler, II) then
      II.DoOnFrameDestroy(Frame);
  end;
end;

procedure TFormDesigner.AfterCreateModule(Sender: TObject);
var
  Frame: TIQUniModuleFrame;
begin
  Frame := (Sender as TIQUniModuleFormDesigner).CurrentFrame;
  DoAfterCreateFrame(Frame);
end;

procedure TFormDesigner.BeforeDestroyModule(Sender: TObject);
var
  Frame: TIQUniModuleFrame;
begin
  Frame := (Sender as TIQUniModuleFormDesigner).CurrentFrame;
  DoBeforeDestroyFrame(Frame);
end;

procedure TFormDesigner.StartDesigner;
var
  Ts : TUniTabSheet;
  FDesigner : TIQUniModuleFormDesigner;
begin
  Ts := TUniTabSheet.Create(Self);
  Ts.PageControl := UniPageControl1;

  Ts.AlignmentControl := uniAlignmentClient;
  Ts.Layout     := 'fit';
  Ts.Closable   := True;
//    Ts.OnClose    := TabSheetClose;
//    Ts.Tag        := NativeInt(Nd);
//    Ts.ImageIndex := Nd.ImageIndex;

  Ts.Caption    := 'Module Designer';
  FDesigner := TIQUniModuleFormDesigner.Create(Self);
  FDesigner.Parent := Ts;
  FDesigner.AfterCreateModuleForm := AfterCreateModule;
  FDesigner.BeforeDestroyModuleForm := BeforeDestroyModule;
  FDesigner.OnSaveModuleForm := SaveDesign;
  FDesigner.OnLoadModuleForm := LoadDesign;
  FDesigner.OnNewDialog := NewDialog;
  FDesigner.OnLoadDialog := LoadDialog;
  FDesigner.OnSaveDialog := SaveDialog;
  UniPageControl1.ActivePage := Ts;
end;

procedure TFormDesigner.LoadModuleList(MList : TStrings);
var
  LoadFolder, cFolder : string;
  sr: TSearchRec;

  procedure LoadSubFolder;
  var
    sr: TSearchRec;
    cModule : string;
  begin
    if SysUtils.FindFirst(LoadFolder + cFolder + '\*.dfm', faAnyFile, sr) = 0 then
      begin
        repeat
          cModule := ExtractFileNameNoExt(sr.Name);
          MList.Values[cFolder] := cModule;
        until FindNext(sr) <> 0;
        FindClose(sr);
      end;
  end;
begin
  LoadFolder := UniServerModule.DFMFolder;

  if SysUtils.FindFirst(LoadFolder + '*.*', faDirectory, sr) = 0 then
  begin
    repeat
      if sr.Attr and faDirectory <> 0 then
      begin
        cFolder := sr.Name;
        if Copy(cFolder, 1, 1) <> '.' then
          LoadSubFolder;
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

procedure TFormDesigner.LoadDialog(Sender: TObject);
var
  MList : TStrings;
  Dsgn : TIQUniModuleFormDesigner;

begin
  Dsgn := Sender as TIQUniModuleFormDesigner;

  MList := TStringList.Create;
  try
    LoadModuleList(MList);
    if MList.Count > 0 then
    begin
      LoadPromptForm.AssignList(MList);
      LoadPromptForm.ShowModal(
        procedure(Sender: TComponent; AResult:Integer)
        begin
          if AResult = mrOK then
          begin
            Dsgn.ModuleCategory := (Sender as TLoadPromptForm).SelectedCategory;
            Dsgn.ModuleName := (Sender as TLoadPromptForm).SelectedModule;
            Dsgn.LoadModule;
          end;
        end
      );
    end;
  finally
    MList.Free;
  end;
end;

procedure TFormDesigner.SaveDialog(Sender: TObject);
begin
  (Sender as TIQUniModuleFormDesigner).SaveModule;
end;

procedure TFormDesigner.NewDialog(Sender: TObject);
var
  Dsgn : TIQUniModuleFormDesigner;
  category : IIQCategory;
  S : string;
  Cmb : TUniComboBox;
begin
  Dsgn := Sender as TIQUniModuleFormDesigner;
  Cmb := PromptModuleForm.UniComboBox1;
  Cmb.Clear;
  for category in UniMainModule.UserIQRegVar.Categories.Values do
  begin
    S := category.Name;
    Cmb.Items.Add(S);
  end;
  Cmb.Text := '';

  PromptModuleForm.Show
  (
    procedure(Sender: TComponent; AResult:Integer)
    begin
      if AResult = mrOK then
      begin
        Dsgn.ModuleCategory := PromptModuleForm.UniComboBox1.Text;
        Dsgn.ModuleName := PromptModuleForm.UniEdit1.Text;
        Dsgn.CreateNewModule;
      end;
    end
  );
end;

procedure TFormDesigner.SaveDesign(Sender: TObject; const Stream: TMemoryStream);
var
  SaveFolder : string;
begin
  SaveFolder := UniServerModule.DFMFolder + (Sender as TIQUniModuleFormDesigner).CurrentFrame.ModuleCategory+'\';
  if not DirectoryExists(SaveFolder) then
    CreateDir(SaveFolder);

  Stream.SaveToFile(SaveFolder + (Sender as TIQUniModuleFormDesigner).CurrentFrame.ModuleName + '.dfm');
end;

procedure TFormDesigner.LoadDesign(Sender: TObject; const Stream: TMemoryStream);
var
  LoadFolder : string;
begin
  LoadFolder := UniServerModule.DFMFolder + (Sender as TIQUniModuleFormDesigner).ModuleCategory + '\';
  if DirectoryExists(LoadFolder) then
    Stream.LoadFromFile(LoadFolder + (Sender as TIQUniModuleFormDesigner).ModuleName + '.dfm');
end;

end.
