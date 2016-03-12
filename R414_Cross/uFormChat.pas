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

    linkedCrossConnected: boolean;  //подключился ли кросс с другой стороны
    linkedR414Connected: boolean;   //подключилась ли к нам наша Р-414

    function getTypeMessage(name : string):TTypeMessage;

    //property SendMessageEvent: TSendMessageEvent
    //  read FSendMessage write FSendMessage;


  end;

var
  formChat: TformChat;

implementation

{$R *.dfm}
  //возвращяет тип сообщения
  procedure TformChat.FormCreate(Sender: TObject);
  begin
    self.linkedCrossConnected := false;
    self.linkedR414Connected := false;
  end;

  function TformChat.getTypeMessage(name : string):TTypeMessage;
  begin
    if (((Pos('Как',name) <> 0) or (Pos('как',name) <> 0) )and ((Pos('Слышите',name) <> 0) or (Pos('слышите',name) <> 0) )) then
      exit(EHow_voice);

    if ((Pos('Слышу',name) <> 0)or(Pos('слышу',name) <> 0))and((Pos('Хорошо',name) <> 0)or(Pos('хорошо',name) <> 0)) then
      exit(EVoice_good);

    if (((Pos('Приготовиться',name) <> 0)or(Pos('приготовиться',name) <> 0))and((Pos('Проверке',name) <> 0)or(Pos('проверке',name) <> 0))) then
      exit(EPrig_prov_soed_lin);

    if ((Pos('Проверке',name) <> 0)or(Pos('проверке',name) <> 0))and((Pos('Готов',name) <> 0)or(Pos('готов',name) <> 0)) then
      exit(ESoed_prov_got);

    if ((Pos('Встаньте',name) <> 0)or(Pos('встаньте',name) <> 0))and((Pos('Разговором',name) <> 0)or(Pos('разговором',name) <> 0)) then
      exit(EVstat_razg);

    if (Pos('Становлюсь',name) <> 0)or(Pos('становлюсь',name) <> 0) then
      exit(EStanovlus);

   if ((Pos('Дайте',name) <> 0)or(Pos('дайте',name) <> 0))and((Pos('Вызов',name) <> 0)or(Pos('вызов',name) <> 0)) then
      exit(EDaite_viz);

   if ((Pos('Даю',name) <> 0)or(Pos('даю',name) <> 0))and((Pos('Вызов',name) <> 0)or(Pos('вызов',name) <> 0)) then
      exit(EDaiu_viz);

   if ((Pos('Вызов',name) <> 0)or(Pos('вызов',name) <> 0))and((Pos('Получил',name) <> 0)or(Pos('получил',name) <> 0)) then
      exit(EViz_poluch);

   if ((Pos('Сдаю',name) <> 0)or(Pos('сдаю',name) <> 0))and((Pos('Эксплуатацию',name) <> 0)or(Pos('эусплуатацию',name) <> 0)) then
      exit(ESday_eksp);

   if ((Pos('Проверяю',name) <> 0)or(Pos('проверяю',name) <> 0)) then
      exit(Eproveray);

   if ((Pos('Канал',name) <> 0)or(Pos('канал',name) <> 0))and((Pos('Принят',name) <> 0)or(Pos('принят',name) <> 0)) then
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
