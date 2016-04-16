unit uFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormCross, uFormNavigator, uFormConsole, ExtCtrls, Menus, uFormChat,
  uTCPClient, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  uFormServer;

type
  TformMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    menuOffline: TMenuItem;
    menuOnline: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure menuOfflineClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure menuOnlineClick(Sender: TObject);
  private
    formCross: TformCross;
    formNavigator: TformNavigator;
    formConsole: TformConsole;
    formChat: TformChat;
    tcpClientCross: TTCPClientCross;
    formConnectToServer: TformConnectToServer;
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

procedure TformMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  self.tcpClientCross.tryDisconnect;
end;

procedure TformMain.FormCreate(Sender: TObject);
begin

  self.formConsole := TformConsole.Create(self);
  self.formConsole.Parent := self;
  self.formConsole.Show;

  self.formCross := TFormCross.Create(self);
  self.formCross.Parent := self;
  self.formCross.Show;

  self.formConsole.BringToFront;

  self.formNavigator := TformNavigator.Create(self);
  self.formNavigator.Parent := self;
  self.formNavigator.Hide;
  self.formNavigator.addCrossForm(formCross);

  self.formChat := TformChat.Create(self);
  self.formChat.Show;
  self.formChat.Parent := self;
  tcpClientCross := TTCPClientCross.Create(self.formChat);

  self.formConnectToServer := TformConnectToServer.Create(self);

  self.formConnectToServer.addTCPClient(tcpClientCross);
  self.formConnectToServer.Parent := self;



end;

procedure TformMain.FormDestroy(Sender: TObject);
begin
  self.tcpClientCross.tryDisconnect;
end;

procedure TformMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta > 0 then
    self.formCross.VertScrollBar.Position :=  self.formCross.VertScrollBar.Position - 50
  else
    self.formCross.VertScrollBar.Position :=  self.formCross.VertScrollBar.Position + 50;
end;

procedure TformMain.FormPaint(Sender: TObject);
begin
  formConsole.Left := Self.ClientWidth - formConsole.ClientWidth- 25;
  formConsole.Top := Self.ClientHeight - formConsole.ClientHeight-5;

  formNavigator.left := 5;
  formNavigator.Top := Self.ClientHeight - formNavigator.ClientHeight-5;

    self.formChat.Left := self.ClientWidth - self.formChat.ClientWidth-25;
end;

procedure TformMain.menuOfflineClick(Sender: TObject);
begin
  //создаем обучение
  if self.menuOffline.Checked = false then
  begin
    self.formConsole.Memo1.Clear;
    self.formCross.cross.createEducation;
    self.formCross.cross.education.addForms(self.formConsole, self.formChat);
    self.formChat.Button1.OnClick := self.formCross.cross.education.ButtonClick;
    self.formChat.rbPiuB.OnClick := self.formCross.cross.education.rbPiuBClick;
    self.formChat.rbPSSBM.OnClick := self.formCross.cross.education.rbPSSBMClick;
    self.menuOffline.Checked := true;
    self.menuOnline.Checked:= false;

    self.formChat.Show;
    Self.N6.Checked:= true;


  end
  else
  begin
    self.formCross.cross.freeEducation;
    self.formChat.Button1.OnClick := nil;
    self.formChat.rbPiuB.OnClick := nil;
    self.formChat.rbPSSBM.OnClick := nil;
    self.menuOffline.Checked := false;
  end;
end;

procedure TformMain.menuOnlineClick(Sender: TObject);
begin
  if self.menuOnline.Checked = false then
  begin
    self.formConsole.Memo1.Clear;
    self.formCross.cross.createEducation;
    tcpClientCross.BindEducation(formCross.cross.education);  ////

    self.formCross.cross.education.addForms(self.formConsole, self.formChat);
    self.formChat.Button1.OnClick := self.formCross.cross.education.ButtonClick;
    self.formChat.rbPiuB.OnClick := self.formCross.cross.education.rbPiuBClick;
    self.formChat.rbPSSBM.OnClick := self.formCross.cross.education.rbPSSBMClick;
    self.menuOnline.Checked := true;
    self.menuOffline.Checked:= false;

    self.formChat.Show;
    Self.N6.Checked:= true;
    self.formConnectToServer.Show;
    Self.N7.Checked:= true;


  end
  else
  begin
    self.formCross.cross.freeEducation;
    self.formChat.Button1.OnClick := nil;
    self.formChat.rbPiuB.OnClick := nil;
    self.formChat.rbPSSBM.OnClick := nil;
    self.menuOnline.Checked := false;
  end;
end;

procedure TformMain.N4Click(Sender: TObject);
begin
  if self.formNavigator.Visible = true then
    self.formNavigator.Visible := false
  else
    self.formNavigator.Visible := true;
end;

procedure TformMain.N5Click(Sender: TObject);
begin
  if self.formConsole.Visible = true then
    self.formConsole.Visible := false
  else
    self.formConsole.Visible := true;
end;

procedure TformMain.N6Click(Sender: TObject);
begin


  if self.formChat.Visible = true then
    self.formChat.Visible := false
  else
  begin
    self.formChat.Visible := true;

    if self.formCross.cross.education <> nil then
      self.formCross.cross.education.changCrossEducation('');
  end;


end;

procedure TformMain.N7Click(Sender: TObject);
begin
  if self.formConnectToServer.Visible = true then
    self.formConnectToServer.Visible := false
  else
    self.formConnectToServer.Visible := true;

end;

end.
