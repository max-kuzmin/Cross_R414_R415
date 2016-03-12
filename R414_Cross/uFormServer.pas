unit uFormServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,uTCPClient;

type
  TformConnectToServer = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    tcpClientCross: TTCPClientCross;
    { Private declarations }
  public
    procedure addTCPClient(crossTCPClient: TTCPClientCross);
  end;

var
  formConnectToServer: TformConnectToServer;

implementation

{$R *.dfm}

  procedure TformConnectToServer.addTCPClient(crossTCPClient: TTCPClientCross);
  begin
    self.tcpClientCross := crossTCPClient;
  end;

  procedure TformConnectToServer.Button1Click(Sender: TObject);
  begin
    if self.tcpClientCross.tryConect(self.Edit1.Text, self.Edit2.Text, self.Edit3.Text) then
    begin
      self.Button1.Enabled := false;
      self.Button2.Enabled := true;
      Self.Hide;
    end;
  end;

  procedure TformConnectToServer.Button2Click(Sender: TObject);
  begin
    if self.tcpClientCross.tryDisconnect then
    begin
      self.Button2.Enabled := false;
      self.Button1.Enabled := true;

    end;

  end;

end.
