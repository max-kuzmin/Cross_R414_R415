unit uFormChat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uRequestDM;

type
  TTypeMessage = (ENone, EHow_voice, EVoice_good, EPrig_prov_soed_lin, ESoed_prov_got,
    EVstat_razg, EStanovlus, EDaite_viz, EDaiu_viz, EViz_poluch,ESday_eksp, Eproveray,
    EKan_prin);

    //TSendMessageEvent = procedure(text: String; client: String) of object;

  TformChat = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    rbPiuB: TRadioButton;
    rbPSSBM: TRadioButton;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    rb1r414: TRadioButton;
    rb1cross: TRadioButton;

    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);




  private
    { Private declarations }
    //FSendMessage: TSendMessageEvent;

  public
    { Public declarations }

    LinkedR414UserName: string;
      LinkedCrossUserName: string;
      UserName: string;

    linkedCrossConnected: boolean;  //����������� �� ����� � ������ �������
    linkedR414Connected: boolean;   //������������ �� � ��� ���� �-414

    function getTypeMessage(name : string):TTypeMessage;

    //property SendMessageEvent: TSendMessageEvent
    //  read FSendMessage write FSendMessage;


  end;

var
  formChat: TformChat;

implementation

{$R *.dfm}
  //���������� ��� ���������
  procedure TformChat.FormCreate(Sender: TObject);
  begin
    self.linkedCrossConnected := false;
    self.linkedR414Connected := false;
  end;

  function TformChat.getTypeMessage(name : string):TTypeMessage;
  begin
    if (((Pos('���',name) <> 0) or (Pos('���',name) <> 0) )and ((Pos('�������',name) <> 0) or (Pos('�������',name) <> 0) )) then
      exit(EHow_voice);

    if ((Pos('�����',name) <> 0)or(Pos('�����',name) <> 0))and((Pos('������',name) <> 0)or(Pos('������',name) <> 0)) then
      exit(EVoice_good);

    if (((Pos('�������������',name) <> 0)or(Pos('�������������',name) <> 0))and((Pos('��������',name) <> 0)or(Pos('��������',name) <> 0))) then
      exit(EPrig_prov_soed_lin);

    if ((Pos('��������',name) <> 0)or(Pos('��������',name) <> 0))and((Pos('�����',name) <> 0)or(Pos('�����',name) <> 0)) then
      exit(ESoed_prov_got);

    if ((Pos('��������',name) <> 0)or(Pos('��������',name) <> 0))and((Pos('����������',name) <> 0)or(Pos('����������',name) <> 0)) then
      exit(EVstat_razg);

    if (Pos('����������',name) <> 0)or(Pos('����������',name) <> 0) then
      exit(EStanovlus);

   if ((Pos('�����',name) <> 0)or(Pos('�����',name) <> 0))and((Pos('�����',name) <> 0)or(Pos('�����',name) <> 0)) then
      exit(EDaite_viz);

   if ((Pos('���',name) <> 0)or(Pos('���',name) <> 0))and((Pos('�����',name) <> 0)or(Pos('�����',name) <> 0)) then
      exit(EDaiu_viz);

   if ((Pos('�����',name) <> 0)or(Pos('�����',name) <> 0))and((Pos('�������',name) <> 0)or(Pos('�������',name) <> 0)) then
      exit(EViz_poluch);

   if ((Pos('����',name) <> 0)or(Pos('����',name) <> 0))and((Pos('������������',name) <> 0)or(Pos('������������',name) <> 0)) then
      exit(ESday_eksp);

   if ((Pos('��������',name) <> 0)or(Pos('��������',name) <> 0)) then
      exit(Eproveray);

   if ((Pos('�����',name) <> 0)or(Pos('�����',name) <> 0))and((Pos('������',name) <> 0)or(Pos('������',name) <> 0)) then
      exit(EKan_prin);

    exit(ENone);
  end;




procedure TformChat.Button1Click(Sender: TObject);
begin
//if (rb1r414.Checked) then
//begin
//      FSendMessage(self.Edit1.Text,  LinkedR414UserName);
//end
//else
//begin
//     FSendMessage(self.Edit1.Text,  LinkedCrossUserName);
//end;
Memo1.Lines.Add(UserName + ': ' + self.Edit1.Text);
self.Edit1.Text := '';

end;



end.
