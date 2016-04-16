unit uEducation;

interface

uses
  uBaseObject,
  uLampObject,
  uWireObject,
  Generics.Collections,
  ExtCtrls,
  Dialogs,
  SysUtils,
  Windows,
  uFormConsole,
  uFormChat,
  uNetParamsList;

const chisloLiniiR414 = 2;      //������� ����� ���������


type

TSendMessageEvent = procedure(text: String; client: String) of object;

  TEducationStateEnum = (EVkl_pit, ESet_svaz, ESet_lin, ESet_lin1, EUst_org, ESet_svaz_lin,
    EZapr_viz, EDat_viz1, EDat_viz2, EPol_viz1, EPol_viz2, EPol_viz3, EViz_prin, EInst_prov,
    EProver, EUst_org_ekspl, ESet_svaz_lin_ekspl, EZapr_viz_ekspl, EDat_viz1_ekspl,
    EDat_viz2_ekspl, EPol_viz1_ekspl, EPol_viz2_ekspl, EPol_viz3_ekspl, EViz_prin_ekspl,
    EKanal_prinat);

  TEventKeyPair = procedure(Param: string; Value: string) of object;

  {$REGION '�����'}
  TEducation = class
    private
    FSendMessage: TSendMessageEvent;
      FSendTaskParamsR414: TEventKeyPair;
      objects: TList<TBaseObject>;
      lamps: TList<TLamp>;
      wires: TList<TWire>;
      educationState: TEducationStateEnum;

      formConsole: TformConsole;
      formChat: TformChat;

      sendMessage: TTypeMessage;

      provSoedLin : integer; //����� ����������� �������������� �����
      instrumProvSoedLin : integer; //����� ���������������� �������� �������������� �����
      cdachaEksplSoedLin : integer; //����� ����� � ������������ �������������� �����
    public
      TaskNetParams: TNetParamsList;
      Online: Boolean;
      property SendTaskParamsR414: TEventKeyPair read FSendTaskParamsR414 write FSendTaskParamsR414;

      constructor Create(objectsT: TList<TBaseObject>; lampsT: TList<TLamp>;
        wiresT: TList<TWire>);
      function findWire(name : string; name1 : string):boolean;

      property SendMessageEvent: TSendMessageEvent
      read FSendMessage write FSendMessage;

      procedure changCrossEducation(name : string);
      procedure addForms(formConsole: TformConsole;  formChat: TformChat);
      procedure ButtonClick(Sender: TObject);
      procedure rbPiuBClick(Sender: TObject);
      procedure rbPSSBMClick(Sender: TObject);
      //
      procedure vklPitania(name : string);
      procedure vklPitaniaQuestions();

      procedure ustOrgan(name : string);
      procedure ustOrganQuestions();

      procedure setSvaz(name : string);
      procedure setSvazQuestions();

      procedure setSoedLin(name : string);
      procedure setSoedLinQuestions();

      procedure setSoedLin1(name : string);
      procedure setSoedLinQuestions1();

      procedure setSvaz1(name : string);
      procedure setSvazQuestions1();

      procedure zaprViz(name : string);
      procedure zaprVizQuestions();

      procedure datVizov1(name : string);
      procedure datVizovQuestions1();

      procedure datVizov2(name : string);
      procedure datVizovQuestions2();

      procedure polVizov1(name : string);
      procedure polVizovQuestions1();

      procedure polVizov2(name : string);
      procedure polVizovQuestions2();

      procedure polVizov3(name : string);
      procedure polVizovQuestions3();

      procedure vizPrin(name : string);
      procedure vizPrinQuestions();

      procedure instrProv(name : string);
      procedure instrProvQuestions();

      procedure proveray(name : string);
      procedure proverayQuestions();

      procedure ustOrganEkspl(name : string);
      procedure ustOrganEksplQuestions();

      procedure setSvazEkspl(name : string);
      procedure setSvazEksplQuestions();

      procedure zaprVizEkspl(name : string);
      procedure zaprVizEksplQuestions();

      procedure datVizov1Ekspl(name : string);
      procedure datVizov1EksplQuestions1();

      procedure datVizov2Ekspl(name : string);
      procedure datVizov2EksplQuestions2();

      procedure polVizov1Ekspl(name : string);
      procedure polVizov1EksplQuestions1();

      procedure polVizov2Ekspl(name : string);
      procedure polVizov2EksplQuestions2();

      procedure polVizov3Ekspl(name : string);
      procedure polVizov3EksplQuestions3();

      procedure vizPrinEkspl(name : string);
      procedure vizPrinEksplQuestions();

      procedure kanalPrinat(name : string);
      procedure kanalPrinatQuestions();

  end;
  {$ENDREGION}

implementation

  {$REGION '���� � �����������'}
  constructor TEducation.Create(objectsT: TList<TBaseObject>; lampsT: TList<TLamp>;
        wiresT: TList<TWire>);
  begin
    self.objects := objectsT;
    self.lamps := lampsT;
    self.wires := wiresT;

    self.formConsole := formConsole;
    self.formChat := formChat;

    //� ����� ����� �������� ���������
    self.provSoedLin := 1;
    self.instrumProvSoedLin := 1;
    self.cdachaEksplSoedLin := 1;
    //� ������ ������ ��������
    self.educationState := EVkl_pit;
    Online:= false;

    //==========================================
    TaskNetParams:= TNetParamsList.Create;
    TaskNetParams.AddKeyValue('R414Connected', 'False');
          TaskNetParams.AddKeyValue('CrossConnected', 'False');
    TaskNetParams.AddKeyValue('CrossVoiceGood', 'False');
    TaskNetParams.AddKeyValue('R414StartTestLines', 'False');

    TaskNetParams.AddKeyValue('CrossStartTestLine1', 'False');
    TaskNetParams.AddKeyValue('R414Set4WireLine1', 'False');
    TaskNetParams.AddKeyValue('CrossAgreeSetLine1', 'False');
    TaskNetParams.AddKeyValue('CrossHowVoiceLine1', 'False');
    TaskNetParams.AddKeyValue('R414GiveCallLine1', 'False');
    TaskNetParams.AddKeyValue('CrossCallGivenLine1', 'False');
    TaskNetParams.AddKeyValue('CrossCallPressedLine1', 'False');
    TaskNetParams.AddKeyValue('R414CallGotLine1', 'False');
    TaskNetParams.AddKeyValue('R414CallGivenLine1', 'False');
    TaskNetParams.AddKeyValue('R414CallPressedLine1', 'False');
    TaskNetParams.AddKeyValue('CrossCallGotLine1', 'False');

    TaskNetParams.AddKeyValue('CrossStartTestLine2', 'False');
    TaskNetParams.AddKeyValue('R414Set4WireLine2', 'False');
    TaskNetParams.AddKeyValue('CrossAgreeSetLine2', 'False');
    TaskNetParams.AddKeyValue('CrossHowVoiceLine2', 'False');
    TaskNetParams.AddKeyValue('R414GiveCallLine2', 'False');
    TaskNetParams.AddKeyValue('CrossCallGivenLine2', 'False');
    TaskNetParams.AddKeyValue('CrossCallPressedLine2', 'False');
    TaskNetParams.AddKeyValue('R414CallGotLine2', 'False');
    TaskNetParams.AddKeyValue('R414CallGivenLine2', 'False');
    TaskNetParams.AddKeyValue('R414CallPressedLine2', 'False');
    TaskNetParams.AddKeyValue('CrossCallGotLine2', 'False');

    TaskNetParams.AddKeyValue('R414InstCheckLine1', 'False');
    TaskNetParams.AddKeyValue('R414InstCheckDoneLine1', 'False');
    TaskNetParams.AddKeyValue('CrossInstCheckDoneLine1', 'False');
    TaskNetParams.AddKeyValue('R414InstCheckLine2', 'False');
    TaskNetParams.AddKeyValue('R414InstCheckDoneLine2', 'False');
    TaskNetParams.AddKeyValue('CrossInstCheckDoneLine2', 'False');

    TaskNetParams.AddKeyValue('R414WaitChannels', 'False');
    TaskNetParams.AddKeyValue('R414GivenChannels', 'False');

  end;



  //��������� ���� ������ ����� ��� ������
  procedure TEducation.addForms(formConsole: TformConsole; formChat: TformChat);
  begin
    self.formConsole := formConsole;
    self.formChat := formChat;
    //���������� ��������� ������
    self.changCrossEducation('');
  end;

  //����� ������� � ������ �����������
  function TEducation.findWire(name : string; name1 : string):boolean;
    var I: integer;
  begin
    for I := 0 to self.wires.Count - 1 do
    begin
      if self.wires[I] <> nil then
        if (self.wires[I].firstObject <> nil) and (self.wires[I].lastObject <> nil) then
          if ((self.wires[I].firstObject.name = name) and (self.wires[I].lastObject.name = name1)) or ((self.wires[I].firstObject.name = name1) and (self.wires[I].lastObject.name = name)) then
            exit(true);
    end;

    exit(false);
  end;
  {$ENDREGION}

  {$REGION '�������'}

  //������� ��������� ������
  procedure TEducation.changCrossEducation(name : string);
  begin
    self.formConsole.Memo1.Clear;

    self.vklPitania(name);
    self.setSvaz(name);
    self.setSoedLin(name);
    self.setSoedLin1(name);
    self.ustOrgan(name);
    self.setSvaz1(name);
    self.zaprViz(name);
    self.datVizov1(name);
    self.datVizov2(name);
    self.polVizov1(name);
    self.polVizov2(name);
    self.polVizov3(name);
    self.vizPrin(name);
    self.instrProv(name);
    self.proveray(name);
    self.ustOrganEkspl(name);
    self.setSvazEkspl(name);
    self.zaprVizEkspl(name);
    self.datVizov1Ekspl(name);
    self.datVizov2Ekspl(name);
    self.polVizov1Ekspl(name);
    self.polVizov2Ekspl(name);
    self.polVizov3Ekspl(name);
    self.vizPrinEkspl(name);
    self.kanalPrinat(name);
  end;

  //���������� ����� �� ������ ��������� � ����
  procedure TEducation.ButtonClick(Sender: TObject);
  begin
    if ((self.formChat.rbPSSBM.Checked = true)and((self.educationState = EVkl_pit)or (self.educationState = ESet_svaz)or(self.educationState = ESet_lin)or(self.educationState = ESet_lin1)or(self.educationState = EProver)or(self.educationState = EKanal_prinat)))
      or
      ((self.formChat.rbPiuB.Checked = true)and((self.educationState = ESet_svaz_lin)or(self.educationState = EZapr_viz)or(self.educationState = EViz_prin)or(self.educationState = ESet_svaz_lin_ekspl)or(self.educationState = EZapr_viz_ekspl)or(self.educationState = EViz_prin_ekspl)
      or (((self.educationState = ESet_lin)or(self.educationState = ESet_lin1)) and  (self.provSoedLin>1)  )))  then
    begin

       if (Online) then
       begin
          if (self.formChat.rb1r414.Checked) then
          begin
                FSendMessage(self.formChat.Edit1.Text,  self.formChat.LinkedR414UserName);
          end
          else
          begin
               FSendMessage(self.formChat.Edit1.Text,  self.formChat.LinkedCrossUserName);
          end;
          self.sendMessage := self.formChat.getTypeMessage(self.formChat.Edit1.Text);
          self.formChat.Memo1.Lines.Add(self.formChat.UserName + ': ' + self.formChat.Edit1.Text);
          self.formChat.Edit1.Text := '';
       end
       else
       begin
          self.sendMessage := self.formChat.getTypeMessage(self.formChat.Edit1.Text);
          self.formChat.Memo1.Lines.Add(' ��: ' + self.formChat.Edit1.Text);
          self.formChat.Edit1.Text := '';
       end;

       self.changCrossEducation('');

    end;
  end;

  //������ ���-�
  procedure TEducation.rbPiuBClick(Sender: TObject);
  begin
    self.changCrossEducation('');
  end;

  //������ ���-��
  procedure TEducation.rbPSSBMClick(Sender: TObject);
  begin
    self.changCrossEducation('');
  end;
  {$ENDREGION}

  {$REGION '1.��������� �������'}
  procedure TEducation.vklPitania(name : string);
  begin

    if self.educationState = EVkl_pit then
    begin

      if (Online) and (formChat.linkedR414Connected = false) then
      begin
        self.formConsole.Memo1.Lines.Add('������������ � ������� � ��������� ����������� ��������� �������');
        Exit;
      end;

        self.vklPitaniaQuestions();

        if name = '2�.���' then
          if self.objects[20].noImage = 1 then
            self.lamps[16].onGreenLamp
          else
            self.lamps[16].offLamp;

        if name = '1�.���' then
          if self.objects[18].noImage = 1 then
            self.lamps[0].onGreenLamp()
          else
            self.lamps[0].offLamp;

        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        if (self.objects[18].noImage = 1)and(self.objects[20].noImage = 1)
        and(self.objects[21].noImage = 1)and(self.objects[22].noImage = 1)  then
        begin
          if (Online) then
          begin
              SendTaskParamsR414('CrossConnected', 'True');
              TaskNetParams.ChangeValue('CrossConnected', 'True');

              if (TaskNetParams.GetBoolValue('R414Connected') = True) then
              begin
                  self.educationState := ESet_svaz;
              end;
          end
          else
          begin
            self.formChat.Memo1.Lines.Add('�������������: ��310 � ��360 ��� ���� ������� ?');
            self.educationState := ESet_svaz;
          end;


          self.objects[20].ban := true;
          self.objects[18].ban := true;
        end;
    end;
  end;

  //����� ���������
  procedure TEducation.vklPitaniaQuestions();
  begin
    if self.objects[20].noImage <> 1 then
      self.formConsole.Memo1.Lines.Add('1. ���� "���-�", �������� �������. ');
    if self.objects[18].noImage <> 1 then
      self.formConsole.Memo1.Lines.Add('2. ���� "���-��", �������� �������. ');
    if self.objects[21].noImage <> 1 then
        self.formConsole.Memo1.Lines.Add('3. ���� "���-��", ������������� "���-��" � ��������� "���" ');
    if self.objects[22].noImage <> 1 then
        self.formConsole.Memo1.Lines.Add('4. ���� "���-��", ��� ');

    if (Online) and (TaskNetParams.GetBoolValue('R414Connected') = False) then
    begin
        self.formConsole.Memo1.Lines.Add('5. ��������� ������ �� �414: "��310 � ��360 ��� ���� �������?"');
    end;
  end;
  {$ENDREGION}

  {$REGION '2.��������� ����� � ��������������� �� ��������'}
  procedure TEducation.setSvaz(name : string);
    begin
      if self.educationState = ESet_svaz then
      begin
          self.setSvazQuestions();

          //���� ������������ ������ ���, ����������
          if self.formChat.Visible = true then
          begin

            if name = '2�.1���' then
              if self.objects[7].noImage = 1 then
                self.formChat.Button1.Enabled := true
              else
                self.formChat.Button1.Enabled := false;

          end;


         if (Online) then
         begin
           if (self.sendMessage = EVoice_good) and (TaskNetParams.GetBoolValue('R414Connected') = True) then
           begin
              SendTaskParamsR414('CrossVoiceGood', 'True');
              TaskNetParams.ChangeValue('CrossVoiceGood', 'True');
              if (TaskNetParams.GetBoolValue('R414StartTestLines') = true) then
                  self.educationState := ESet_lin;
           end;
         end

          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          else if (self.sendMessage = EVoice_good)and(self.objects[7].noImage = 0)
            and (self.formChat.rbPSSBM.Checked = true) then
          begin
            self.educationState := ESet_lin;
            //��� ���������� ������
            self.formChat.Memo1.Lines.Add(' �������������: ��310, ������������� � �������� �������������� �����.');
          end;
      end;
    end;

  procedure TEducation.setSvazQuestions();
  begin
    if self.formChat.Visible = false then
      self.formConsole.Memo1.Lines.Add('1. �������� �� "����->�����"');

    if self.formChat.rbPSSBM.Checked = false then
      self.formConsole.Memo1.Lines.Add('2. "����->�����" �������� ������ "���-��" ��� ���������.');

    if (self.objects[7].noImage <> 1)and(self.sendMessage <> EVoice_good) then
      self.formConsole.Memo1.Lines.Add('3. ���� "���-��", ���.1 � ��������� ���.');

     if self.sendMessage <> EVoice_good then
     begin
      self.formConsole.Memo1.Lines.Add('4. ��������: "��360 � ��310 ����� ��� ������."');
      self.formChat.Edit1.Text:= '��360 � ��310 ����� ��� ������.';
     end;

    if (self.objects[7].noImage <> 0)and(self.sendMessage = EVoice_good) then
      self.formConsole.Memo1.Lines.Add('5. ���� "���-��", ���.1 � ����������� ���������.');

    if (Online and (self.objects[7].noImage = 0)and(self.sendMessage = EVoice_good) ) then
    begin
        self.formConsole.Memo1.Lines.Add('6. ��������� ������ �� �414: "��310, ������������� � �������� �������������� �����"');
    end;
  end;
  {$ENDREGION}
  //---
  {$REGION '3.���������� � �������� �������������� �����'}
  procedure TEducation.setSoedLin(name : string);
    begin
      if self.educationState = ESet_lin then
      begin
          self.setSoedLinQuestions();


          //���� ������������ ������ ���, ����������
          if self.formChat.Visible = true then
          begin

            if name = '2�.1���' then
              if self.objects[7].noImage = 1 then
                self.formChat.Button1.Enabled := true
              else
                self.formChat.Button1.Enabled := false;

          end;

          if (Online) then
           begin
                if (self.sendMessage = ESoed_prov_got) and
                ((self.objects[7].noImage = 0) or (self.provSoedLin>1)) then  //��� 2� ����� ����� ������ �������� ��������� ������
                begin
                SendTaskParamsR414('CrossStartTestLine'+ IntToStr(self.provSoedLin), 'True');
                TaskNetParams.ChangeValue('CrossStartTestLine'+ IntToStr(self.provSoedLin), 'True');
                if (TaskNetParams.GetBoolValue('R414Set4WireLine' + IntToStr(self.provSoedLin)) = true) then
                  self.educationState := ESet_lin1;
                end;


                if (self.provSoedLin>1) then self.formChat.Button1.Enabled := true;
           end
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          else if (self.sendMessage = ESoed_prov_got)and(self.objects[7].noImage = 0)
            and (self.formChat.rbPSSBM.Checked = true) then
          begin
            self.educationState := ESet_lin1;
            //��� ���������� ������
            self.formChat.Memo1.Lines.Add(' �������������: �������� ���������� �� ' + IntToStr(self.provSoedLin) + '-� �������������� ����� � 4�� ������');
          end;
      end;
    end;

  procedure TEducation.setSoedLinQuestions();
  begin


    if (self.formChat.Visible = false) and (self.provSoedLin=1) then
      self.formConsole.Memo1.Lines.Add('1. �������� �� "����->�����"');

    if (self.formChat.rbPSSBM.Checked = false) and (self.provSoedLin=1) then
      self.formConsole.Memo1.Lines.Add('2. "����->�����" �������� ������ "���-��" ��� ���������.');


    if (self.objects[7].noImage <> 1)and(self.sendMessage <> ESoed_prov_got) and (self.provSoedLin=1) then
      self.formConsole.Memo1.Lines.Add('3. ���� "���-��", ���.1 � ��������� ���.');

     if (self.sendMessage <> ESoed_prov_got) then
     begin
      self.formConsole.Memo1.Lines.Add('4. ��������: "� �������� �������������� ����� �����"');
      self.formChat.Edit1.Text:= '� �������� �������������� ����� �����';
     end;

    if (self.objects[7].noImage <> 0)and(self.sendMessage = ESoed_prov_got) and (self.provSoedLin=1) then
      self.formConsole.Memo1.Lines.Add('5. ���� "���-��", ���.1 � ����������� ���������.');


    if (Online and ((self.objects[7].noImage = 0) or (self.provSoedLin>1)) and (self.sendMessage = ESoed_prov_got)) then
      begin
          self.formConsole.Memo1.Lines.Add('6. ��������� ������ �� �414: "�������� ���������� �� ' + IntToStr(self.provSoedLin) + '-� �������������� ����� � 4�� ������"');
      end;
  end;

  //----------------------------------------------------------------------------
    procedure TEducation.setSoedLin1(name : string);
    begin
      if self.educationState = ESet_lin1 then
      begin
          self.setSoedLinQuestions1();

          //���� ������������ ������ ���, ����������
          if self.formChat.Visible = true then
          begin

            if name = '2�.1���' then
              if self.objects[7].noImage = 1 then
                self.formChat.Button1.Enabled := true
              else
                self.formChat.Button1.Enabled := false;

          end;

          if (Online) then
           begin
                if (self.sendMessage = EStanovlus)
                and ((self.objects[7].noImage = 0) or (self.provSoedLin>1)) then
                begin
                  SendTaskParamsR414('CrossAgreeSetLine'+ IntToStr(self.provSoedLin), 'True');
                  TaskNetParams.ChangeValue('CrossAgreeSetLine' + IntToStr(self.provSoedLin), 'True');
                  self.educationState := EUst_org;
                end;

                if (self.provSoedLin>1) then self.formChat.Button1.Enabled := true;
           end
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          else if (self.sendMessage = EStanovlus)and(self.objects[7].noImage = 0)
            and (self.formChat.rbPSSBM.Checked = true) then
          begin
            self.educationState := EUst_org;
            //��� ���������� ������

          end;
      end;
    end;

  procedure TEducation.setSoedLinQuestions1();
  begin

          if self.formChat.Visible = false and (self.provSoedLin=1) then
          self.formConsole.Memo1.Lines.Add('1. �������� �� "����->�����"');

          if (self.objects[7].noImage <> 1)and(self.sendMessage <> EStanovlus) and (self.provSoedLin=1) then
          self.formConsole.Memo1.Lines.Add('2. ���� "���-��", ���.1 � ��������� ���.');

          if self.sendMessage <> EStanovlus then
           begin
            self.formConsole.Memo1.Lines.Add('3. ��������: "�����. ����������"');
            self.formChat.Edit1.Text:= '�����. ����������';
           end;

          if (self.objects[7].noImage <> 0) and (self.sendMessage = EStanovlus) and (self.provSoedLin=1) then
          self.formConsole.Memo1.Lines.Add('4. ���� "���-��", ���.1 � ����������� ���������.');

  end;
  {$ENDREGION}

  {$REGION '4. ��������� �������'}
  procedure TEducation.ustOrgan(name : string);
    begin
      if self.educationState = EUst_org then
      begin
          self.ustOrganQuestions();
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.objects[1].noImage = 1)and(self.objects[2].noImage = 1)
            and(self.objects[3].noImage = 2)and(self.objects[4].noImage = 0)
            and (self.objects[5].noImage = 0) and (self.findWire('4��.���_'+ IntToStr(self.provSoedLin) , '4��.����_�') = true)  then
          begin
            self.educationState := ESet_svaz_lin;
          end;
      end;
    end;

    procedure TEducation.ustOrganQuestions();
    begin
       if self.objects[1].noImage <> 1 then
        self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.� ');

       if self.objects[2].noImage <> 1 then
        self.formConsole.Memo1.Lines.Add('2. ���� "���-�", 4�� ');

       if self.objects[3].noImage <> 2 then
        self.formConsole.Memo1.Lines.Add('3. ���� "���-�", ����. ');

       if self.objects[4].noImage <> 0 then
        self.formConsole.Memo1.Lines.Add('3. ���� "���-�", ������������� "���-��" � ������� ���������. ');

       if self.objects[5].noImage <> 0 then
        self.formConsole.Memo1.Lines.Add('3. ���� "���-�", ������������� "����.���-��" � ������� ���������. ');

       if self.findWire('4��.���_' + IntToStr(self.provSoedLin), '4��.����_�') <> true then
        self.formConsole.Memo1.Lines.Add('3. ���� "���-��", �������� ������(��� ������ ��������) � �������� ��� � ����.� ����� ���-� � ���. �����.' + IntToStr(self.provSoedLin));
    end;
  {$ENDREGION}

  {$REGION '5.��������� ����� � ��������������� �����'}
  procedure TEducation.setSvaz1(name : string);
    begin
      if self.educationState = ESet_svaz_lin then
      begin
          self.setSvazQuestions1();

          //���� ������������ ������ ������ ���
          if self.formChat.rbPiuB.Checked = true  then
          begin
            self.formChat.Button1.Enabled := true;
          end;

          if (Online) then
           begin
                if (self.sendMessage = EHow_voice) and (self.formChat.rbPiuB.Checked = true) then
                begin
                  SendTaskParamsR414('CrossHowVoiceLine' + IntToStr(self.provSoedLin), 'True');
                  TaskNetParams.ChangeValue('CrossHowVoiceLine' + IntToStr(self.provSoedLin), 'True');
                  if (TaskNetParams.GetBoolValue('R414GiveCallLine' + IntToStr(self.provSoedLin)) = true) then
                    self.educationState := EZapr_viz;
                end;
           end
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          else if (self.sendMessage = EHow_voice)and(self.formChat.rbPiuB.Checked = true) then
          begin
            self.educationState := EZapr_viz;
            //��� ���������� ������
            self.formChat.Memo1.Lines.Add(' �������������: ����� ��� ������, ����� ��� �����.');
          end;
      end;
    end;

  procedure TEducation.setSvazQuestions1();
  begin
    if self.formChat.rbPiuB.Checked = false then
      self.formConsole.Memo1.Lines.Add('1. "����->�����" �������� ������ "���-�" ��� ���������.');
     if self.sendMessage <> EHow_voice then
     begin
      self.formConsole.Memo1.Lines.Add('2. ��������: "��360, � ��310 ��� ���� ������� ?"');
      self.formChat.Edit1.Text:= '��360 � ��310 ��� ���� ������� ?';
     end;

     if (Online and (self.sendMessage = EHow_voice)) then
      begin
          self.formConsole.Memo1.Lines.Add('3. ��������� ������ �� �414: "����� ��� ������, ����� ��� �����"');
      end;
  end;
  {$ENDREGION}

  {$REGION '6.������ ������'}
  procedure TEducation.zaprViz(name : string);
    begin
      if self.educationState = EZapr_viz then
      begin
          self.zaprVizQuestions();

          //���� ������������ ������ ������ ���
          if self.formChat.rbPiuB.Checked = true  then
          begin
            self.formChat.Button1.Enabled := true;
          end;


          if (Online) then
           begin
                if (self.sendMessage = EDaiu_viz) and (self.formChat.rbPiuB.Checked = true) then
                begin
                  SendTaskParamsR414('CrossCallGivenLine' + IntToStr(self.provSoedLin), 'True');
                  TaskNetParams.ChangeValue('CrossCallGivenLine' + IntToStr(self.provSoedLin), 'True');
                  self.educationState := EDat_viz1;
                end;
           end
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          else if (self.sendMessage = EDaiu_viz)and(self.formChat.rbPiuB.Checked = true) then
          begin
            self.educationState := EDat_viz1;
            //��� ���������� ������

          end;
      end;
    end;

  procedure TEducation.zaprVizQuestions();
  begin
    if self.formChat.rbPiuB.Checked = false then
      self.formConsole.Memo1.Lines.Add('1. "����->�����" �������� ������ "���-�" ��� ���������.');

     if self.sendMessage <> EDaiu_viz then
     begin
      self.formConsole.Memo1.Lines.Add('4. ��������: "��� ��� �����."');
      self.formChat.Edit1.Text:= '��� ��� �����';
     end;
  end;
  {$ENDREGION}

  {$REGION '7.����� ��'}
  procedure TEducation.datVizov1(name : string);
    begin
      if self.educationState = EDat_viz1 then
      begin
          self.datVizovQuestions1();
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.objects[3].noImage = 1)  then
          begin
            SendTaskParamsR414('CrossCallPressedLine' + IntToStr(self.provSoedLin), 'True');
            TaskNetParams.ChangeValue('CrossCallPressedLine'  + IntToStr(self.provSoedLin), 'True');

            self.educationState := EDat_viz2;
            //��� ���������� ������

          end;
      end;
    end;

    procedure TEducation.datVizovQuestions1();
    begin
       if self.objects[3].noImage <> 1 then
        self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ���. (������ 2-3 �������)');
    end;
    //---------------------------------------------------------------------------
    procedure TEducation.datVizov2(name : string);
    begin
      if self.educationState = EDat_viz2 then
      begin
          self.datVizovQuestions2();
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.objects[3].noImage = 2)  then
          begin

            if (Online) then
            begin
              if (TaskNetParams.GetBoolValue('R414CallGotLine' + IntToStr(self.provSoedLin)) = true)
              and (TaskNetParams.GetBoolValue('R414CallGivenLine' + IntToStr(self.provSoedLin)) = true) then
                    self.educationState := EPol_viz1;
            end
            else
            begin
              self.educationState := EPol_viz1;
              //��� ���������� ������
              self.formChat.Memo1.Lines.Add(' �������������: ��� ����� �������. ��� ����� ���.');
            end;
            
          end;
      end;
    end;

    procedure TEducation.datVizovQuestions2();
    begin
       if self.objects[3].noImage <> 2 then
        self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.');

        if (Online) then
          begin
              self.formConsole.Memo1.Lines.Add('2. ��������� ������ �� �414: "��� ����� �������. ��� ����� ���."');
          end;
    end;
  {$ENDREGION}

  {$REGION '8.����� ���'}
  procedure TEducation.polVizov1(name : string);
  begin
    if self.educationState = EPol_viz1 then
    begin
        self.polVizovQuestions1();

        if name = '1�.�����_�����' then
          if self.objects[1].noImage = 2 then
            self.lamps[3].onGreenLamp
          else
            self.lamps[3].offLamp;

        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        if ( self.objects[1].noImage = 2) then
        begin
          self.educationState := EPol_viz2;
          //��� ���������� ������

        end;
    end;
  end;

  //����� ���������
  procedure TEducation.polVizovQuestions1();
  begin
    if self.objects[1].noImage <> 2 then
      self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.� ');
  end;

  //----------------------------------------------------------------------------
  procedure TEducation.polVizov2(name : string);
  begin
    if self.educationState = EPol_viz2 then
    begin
        self.polVizovQuestions2();

        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        if ( self.objects[1].noImage = 1) and ((TaskNetParams.GetBoolValue('R414CallPressedLine'  + IntToStr(self.provSoedLin) ) = True)) then
        begin
          self.educationState := EPol_viz3;
          //��� ���������� ������

        end;
    end;
  end;

  //����� ���������
  procedure TEducation.polVizovQuestions2();
  begin
    if (TaskNetParams.GetBoolValue('R414CallPressedLine'  + IntToStr(self.provSoedLin) ) = False) then
       self.formConsole.Memo1.Lines.Add('1. �������� ������ ')
    else if (self.objects[1].noImage <> 1) then
      self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.� ');

  end;

  //----------------------------------------------------------------------------
  procedure TEducation.polVizov3(name : string);
  begin
    if self.educationState = EPol_viz3 then
    begin
        self.polVizovQuestions3();

        if self.objects[25].noImage = 1 then
          self.lamps[3].offLamp;

        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        if ( self.objects[25].noImage = 1) then
        begin
          self.educationState := EViz_prin;
          //��� ���������� ������

        end;
    end;
  end;

  //����� ���������
  procedure TEducation.polVizovQuestions3();
  begin
    if self.objects[25].noImage <> 1 then
      self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.��� ');
  end;

  //----------------------------------------------------------------------------
  procedure TEducation.vizPrin(name : string);
  begin
    if self.educationState = EViz_prin then
    begin
        self.vizPrinQuestions();

        //���� ������������ ������ ������ ���
        if self.formChat.rbPiuB.Checked = true  then
        begin
          self.formChat.Button1.Enabled := true;
        end;


        if (Online) then
           begin
                if (TaskNetParams.GetBoolValue('R414InstCheckLine1') = true) then
                begin
                      self.educationState := EInst_prov;
                end
                else
                if (self.sendMessage = EViz_poluch) and (self.formChat.rbPiuB.Checked = true) then
                begin
                      SendTaskParamsR414('CrossCallGotLine' + IntToStr(self.provSoedLin), 'True');
                      TaskNetParams.ChangeValue('CrossCallGotLine' + IntToStr(self.provSoedLin), 'True');
                      if self.provSoedLin < chisloLiniiR414 then
                      begin
                        self.provSoedLin := self.provSoedLin + 1;
                        self.educationState := ESet_lin;
                        self.formChat.Button1.Enabled := false;
                        self.changCrossEducation('');
                      end;
                end;
           end
        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        else if (self.sendMessage = EViz_poluch)and(self.formChat.rbPiuB.Checked = true) then
        begin
          if self.provSoedLin < chisloLiniiR414 then
          begin
            self.provSoedLin := self.provSoedLin + 1;
            self.educationState := ESet_lin;
            self.formChat.Button1.Enabled := false;
//            self.formChat.Memo1.Lines.Add(' �������������: �������� ���������� �� ' + IntToStr(self.provSoedLin) + '-� �������������� ����� � 4�� ������');
            self.changCrossEducation('');
          end
          else
          begin
            self.educationState := EInst_prov;
            //��� ���������� ������
            self.formChat.Memo1.Lines.Add(' �������������: ��� ���������������� �������� �������� ����� �� 1-� �����.');
          end;

        end;
    end;
  end;

  procedure TEducation.vizPrinQuestions();
  begin
    if self.formChat.rbPiuB.Checked = false then
      self.formConsole.Memo1.Lines.Add('1. "����->�����" �������� ������ "���-�" ��� ���������.');

     if (self.sendMessage <> EViz_poluch) then
     begin
      self.formConsole.Memo1.Lines.Add('2. ��������: "��� ����� �������."');
      self.formChat.Edit1.Text:= '��� ����� �������';
     end;
     if (Online and (self.sendMessage = EViz_poluch) and (self.provSoedLin = chisloLiniiR414)) then
      begin
          self.formConsole.Memo1.Lines.Add('3. ��������� ������ �� �414: "��� ��������� �������� ��������� �������� ����� �� 1-� �����."');
      end;
  end;
  {$ENDREGION}
  //---
  {$REGION '9.���������������� ��������'}
  procedure TEducation.instrProv(name : string);
  begin
    if self.educationState = EInst_prov then
    begin
        self.instrProvQuestions();


        if (Online) then
        begin
              if (self.objects[26 + instrumProvSoedLin*2].noImage = 1 ) then
              begin
                SendTaskParamsR414('CrossInstCheckDoneLine' + IntToStr(self.instrumProvSoedLin), 'True');
                TaskNetParams.ChangeValue('CrossInstCheckDoneLine' + IntToStr(self.instrumProvSoedLin), 'True');

                if (self.instrumProvSoedLin < chisloLiniiR414)
                  and (TaskNetParams.GetBoolValue('R414InstCheckLine' + IntToStr(self.instrumProvSoedLin+1)) = True)
                  and (TaskNetParams.GetBoolValue('R414InstCheckDoneLine' + IntToStr(self.instrumProvSoedLin+1)) = True) then
                begin
                    self.instrumProvSoedLin := self.instrumProvSoedLin + 1;
                    self.formChat.Button1.Enabled := false;
                    self.changCrossEducation('');
                end
                else if (TaskNetParams.GetBoolValue('R414Wait') = True) and (TaskNetParams.GetBoolValue('R414GivenChannels') = True) then
                begin
                    self.educationState := EProver;
                end;

              end;
        end



        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        else if (self.objects[26 + instrumProvSoedLin*2].noImage = 1 ) then
        begin

          if self.instrumProvSoedLin < chisloLiniiR414 then
          begin
            self.instrumProvSoedLin := self.instrumProvSoedLin + 1;
            self.formChat.Button1.Enabled := false;
            self.formChat.Memo1.Lines.Add(' �������������: ��� ��������� �������� ��������� �������� ����� �� ' + IntToStr(self.instrumProvSoedLin) + ' �����.');
            self.changCrossEducation('');
          end
          else
          begin
            self.educationState := EProver;
            self.formChat.Button1.Enabled := false;
            //��� ���������� ������
            self.formChat.Memo1.Lines.Add(' �������������: �������� ��������� �������.');
            ShowMessage('�� �������� ������������ � ������� �������� �� ������� ����� ������� ������ ������ 10-15 �����.');
            self.formChat.Memo1.Lines.Add(' �������������: ��310 ���� � ������������ �� ' + IntToStr(cdachaEksplSoedLin) + '-� ����� ����� � 4�� ������ � ����� ����� "����� ' + IntToStr(cdachaEksplSoedLin) + ' "');
          end;
        end;
    end;
  end;

  procedure TEducation.instrProvQuestions();
  begin
    if self.objects[26 + instrumProvSoedLin*2].noImage <> 1 then
      begin
        self.formConsole.Memo1.Lines.Add('1. ���������� 4�� ����� � �����. ' + IntToStr(self.instrumProvSoedLin));
      end;
    if (Online) then
    begin
      self.formConsole.Memo1.Lines.Add('2. ��������� ������ ��������������');
    end;
  end;
  {$ENDREGION}
  //---
  {$REGION '10.��������_��������� �� ��������'}
  procedure TEducation.proveray(name : string);
    begin
      if self.educationState = EProver then
      begin
          self.proverayQuestions();

          //���� ������������ ������ ���, ����������
          if self.formChat.Visible = true then
          begin

            if name = '2�.1���' then
              if self.objects[7].noImage = 1 then
                self.formChat.Button1.Enabled := true
              else
                self.formChat.Button1.Enabled := false;

          end;

          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.sendMessage = Eproveray)and(self.objects[7].noImage = 0)
            and (self.formChat.rbPSSBM.Checked = true) then
          begin
            self.educationState := EUst_org_ekspl;
            //��� ���������� ������
          end;
      end;
    end;

  procedure TEducation.proverayQuestions();
  begin
    if self.formChat.Visible = false then
      self.formConsole.Memo1.Lines.Add('1. �������� �� "����->�����"');

    if self.formChat.rbPSSBM.Checked = false then
      self.formConsole.Memo1.Lines.Add('2. "����->�����" �������� ������ "���-��" ��� ���������.');

    if (self.objects[7].noImage <> 1)and(self.sendMessage <> Eproveray) then
      self.formConsole.Memo1.Lines.Add('3. ���� "���-��", ���.1 � ��������� ���.');

     if self.sendMessage <> Eproveray then
     begin
      self.formConsole.Memo1.Lines.Add('4. ��������: "��� �����. ��������."');
      self.formChat.Edit1.Text:= '��� �����. ��������';
     end;

    if (self.objects[7].noImage <> 0)and(self.sendMessage = Eproveray) then
      self.formConsole.Memo1.Lines.Add('5. ���� "���-��", ���.1 � ����������� ���������.');
  end;
  {$ENDREGION}

  {$REGION '11. ��������� ������� �� ����� �������'}
  procedure TEducation.ustOrganEkspl(name : string);
    begin
      if self.educationState = EUst_org_ekspl then
      begin
          self.ustOrganEksplQuestions();
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.objects[1].noImage = 1)and(self.objects[2].noImage = 1)
            and(self.objects[3].noImage = 2)and(self.objects[4].noImage = 0)
            and (self.objects[5].noImage = 0) and (self.findWire('4��.���_'+ IntToStr(self.cdachaEksplSoedLin) , '4��.����_�') = true)  then
          begin
            self.educationState := ESet_svaz_lin_ekspl;
          end;
      end;
    end;

    procedure TEducation.ustOrganEksplQuestions();
    begin
       if self.objects[1].noImage <> 1 then
        self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.� ');

       if self.objects[2].noImage <> 1 then
        self.formConsole.Memo1.Lines.Add('2. ���� "���-�", 4�� ');

       if self.objects[3].noImage <> 2 then
        self.formConsole.Memo1.Lines.Add('3. ���� "���-�", ����. ');

       if self.objects[4].noImage <> 0 then
        self.formConsole.Memo1.Lines.Add('3. ���� "���-�", ������������� "���-��" � ������� ���������. ');

       if self.objects[5].noImage <> 0 then
        self.formConsole.Memo1.Lines.Add('3. ���� "���-�", ������������� "����.���-��" � ������� ���������. ');

       if self.findWire('4��.���_' + IntToStr(self.cdachaEksplSoedLin), '4��.����_�') <> true then
        self.formConsole.Memo1.Lines.Add('3. ���� "���-��", �������� ������(��� ������ ��������) � �������� ��� � ����.� ����� ���-� � ���. �����.' + IntToStr(self.cdachaEksplSoedLin));
    end;
  {$ENDREGION}

  {$REGION '12.��������� ����� � ��������������� ����� �������'}
  procedure TEducation.setSvazEkspl(name : string);
    begin
      if self.educationState = ESet_svaz_lin_ekspl then
      begin
          self.setSvazEksplQuestions();

          //���� ������������ ������ ������ ���
          if self.formChat.rbPiuB.Checked = true  then
          begin
            self.formChat.Button1.Enabled := true;
          end;

          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.sendMessage = EHow_voice)and(self.formChat.rbPiuB.Checked = true) then
          begin
            self.educationState := EZapr_viz_ekspl;
            //��� ���������� ������
            self.formChat.Memo1.Lines.Add(' �������������:� ��310 ���� ����� �����' + IntToStr(cdachaEksplSoedLin) + ' ����� ��� ������, ����� ��� �����.');
          end;
      end;
    end;

  procedure TEducation.setSvazEksplQuestions();
  begin
    if self.formChat.rbPiuB.Checked = false then
      self.formConsole.Memo1.Lines.Add('1. "����->�����" �������� ������ "���-�" ��� ���������.');
     if self.sendMessage <> EHow_voice then
     begin
      self.formConsole.Memo1.Lines.Add('4. ��������: "� ��310 ���� ����� ����� ��� ���� ������� ?"');
      self.formChat.Edit1.Text:= '� ��310 ���� ����� ����� ��� ���� ������� ?';
     end;
  end;
  {$ENDREGION}

  {$REGION '13.������ ������'}
  procedure TEducation.zaprVizEkspl(name : string);
    begin
      if self.educationState = EZapr_viz_ekspl then
      begin
          self.zaprVizQuestions();

          //���� ������������ ������ ������ ���
          if self.formChat.rbPiuB.Checked = true  then
          begin
            self.formChat.Button1.Enabled := true;
          end;

          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.sendMessage = EDaiu_viz)and(self.formChat.rbPiuB.Checked = true) then
          begin
            self.educationState := EDat_viz1_ekspl;
            //��� ���������� ������

          end;
      end;
    end;

  procedure TEducation.zaprVizEksplQuestions();
  begin
    if self.formChat.rbPiuB.Checked = false then
      self.formConsole.Memo1.Lines.Add('1. "����->�����" �������� ������ "���-�" ��� ���������.');

     if self.sendMessage <> EDaiu_viz then
      self.formConsole.Memo1.Lines.Add('4. ��������: "��� ��� �����."');
  end;
  {$ENDREGION}

  {$REGION '14.����� ��'}
  procedure TEducation.datVizov1Ekspl(name : string);
    begin
      if self.educationState = EDat_viz1_ekspl then
      begin
          self.datVizov1EksplQuestions1();
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.objects[3].noImage = 1)  then
          begin
            self.educationState := EDat_viz2_ekspl;
            //��� ���������� ������

          end;
      end;
    end;

    procedure TEducation.datVizov1EksplQuestions1();
    begin
       if self.objects[3].noImage <> 1 then
        self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ���. (������ 2-3 �������)');
    end;
    //---------------------------------------------------------------------------
    procedure TEducation.datVizov2Ekspl(name : string);
    begin
      if self.educationState = EDat_viz2_ekspl then
      begin
          self.datVizov2EksplQuestions2();
          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.objects[3].noImage = 2)  then
          begin
            self.educationState := EPol_viz1_ekspl;
            //��� ���������� ������
            self.formChat.Memo1.Lines.Add(' �������������: ��� ����� �������. ��� ����� ���.');
          end;
      end;
    end;

    procedure TEducation.datVizov2EksplQuestions2();
    begin
       if self.objects[3].noImage <> 2 then
        self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.');
    end;
  {$ENDREGION}

  {$REGION '15.����� ���'}
  procedure TEducation.polVizov1Ekspl(name : string);
  begin
    if self.educationState = EPol_viz1_ekspl then
    begin
        self.polVizov1EksplQuestions1();

        if name = '1�.�����_�����' then
          if self.objects[1].noImage = 2 then
            self.lamps[3].onGreenLamp
          else
            self.lamps[3].offLamp;

        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        if ( self.objects[1].noImage = 2) then
        begin
          self.educationState := EPol_viz2_ekspl;
          //��� ���������� ������

        end;
    end;
  end;

  //����� ���������
  procedure TEducation.polVizov1EksplQuestions1();
  begin
    if self.objects[1].noImage <> 2 then
      self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.� ');
  end;

  //----------------------------------------------------------------------------
  procedure TEducation.polVizov2Ekspl(name : string);
  begin
    if self.educationState = EPol_viz2_ekspl then
    begin
        self.polVizov2EksplQuestions2();

        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        if ( self.objects[1].noImage = 1) then
        begin
          self.educationState := EPol_viz3_ekspl;
          //��� ���������� ������

        end;
    end;
  end;

  //����� ���������
  procedure TEducation.polVizov2EksplQuestions2();
  begin
    if self.objects[1].noImage <> 1 then
      self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.� ');
  end;

  //----------------------------------------------------------------------------
  procedure TEducation.polVizov3Ekspl(name : string);
  begin
    if self.educationState = EPol_viz3_ekspl then
    begin
        self.polVizov3EksplQuestions3();

        if self.objects[25].noImage = 1 then
          self.lamps[3].offLamp;

        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        if ( self.objects[25].noImage = 1) then
        begin
          self.educationState := EViz_prin_ekspl;
          //��� ���������� ������

        end;
    end;
  end;

  //����� ���������
  procedure TEducation.polVizov3EksplQuestions3();
  begin
    if self.objects[25].noImage <> 1 then
      self.formConsole.Memo1.Lines.Add('1. ���� "���-�", ����.��� ');
  end;

  //----------------------------------------------------------------------------
  procedure TEducation.vizPrinEkspl(name : string);
  begin
    if self.educationState = EViz_prin_ekspl then
    begin
        self.vizPrinEksplQuestions();

        //���� ������������ ������ ������ ���
        if self.formChat.rbPiuB.Checked = true  then
        begin
          self.formChat.Button1.Enabled := true;
        end;

        //���� ��� ������ ���� � ��������� ����� � ������ �����������
        if (self.sendMessage = EViz_poluch)and(self.formChat.rbPiuB.Checked = true) then
        begin
          self.educationState := EKanal_prinat;
          self.formChat.Button1.Enabled := false;
          self.formChat.Memo1.Lines.Add(' �������������: ��� �����. ����� � ������������ ������. ����� XX-XX.');
        end;
    end;
  end;

  procedure TEducation.vizPrinEksplQuestions();
  begin
    if self.formChat.rbPiuB.Checked = false then
      self.formConsole.Memo1.Lines.Add('1. "����->�����" �������� ������ "���-�" ��� ���������.');

     if self.sendMessage <> EViz_poluch then
     begin
      self.formConsole.Memo1.Lines.Add('4. ��������: "��� ����� �������.����� � ������������ ������. ����� XX-XX"');
      self.formChat.Edit1.Text:= '��� ����� �������.����� � ������������ ������. �����';
     end;
  end;
  {$ENDREGION}

  {$REGION '16. �������� ������ ��� ����� �����'}
  procedure TEducation.kanalPrinat(name : string);
    begin
      if self.educationState = EKanal_prinat then
      begin
          self.kanalPrinatQuestions();

          //���� ������������ ������ ���, ����������
          if self.formChat.Visible = true then
          begin

            if name = '2�.1���' then
              if self.objects[7].noImage = 1 then
                self.formChat.Button1.Enabled := true
              else
                self.formChat.Button1.Enabled := false;

          end;

          //���� ��� ������ ���� � ��������� ����� � ������ �����������
          if (self.sendMessage = EKan_prin)and(self.objects[7].noImage = 0)
            and (self.formChat.rbPSSBM.Checked = true) then
          begin
              if self.cdachaEksplSoedLin < chisloLiniiR414 then
              begin
                self.cdachaEksplSoedLin := self.cdachaEksplSoedLin + 1;
                self.educationState := EProver;
                self.formChat.Button1.Enabled := false;
                self.changCrossEducation('');

                self.formChat.Memo1.Lines.Add(' �������������: ��310 ���� � ������������ �� ' + IntToStr(cdachaEksplSoedLin) + '-� ����� ����� � 4�� ������ � ����� ����� "����� ' + IntToStr(instrumProvSoedLin) + ' "');
              end
              else
              begin

                //��� ���������� ������
                ShowMessage('�������� ������� !');
              end;
          end;
      end;
    end;

  procedure TEducation.kanalPrinatQuestions();
  begin
    if self.formChat.Visible = false then
      self.formConsole.Memo1.Lines.Add('1. �������� �� "����->�����"');

    if self.formChat.rbPSSBM.Checked = false then
      self.formConsole.Memo1.Lines.Add('2. "����->�����" �������� ������ "���-��" ��� ���������.');

    if (self.objects[7].noImage <> 1)and(self.sendMessage <> EKan_prin) then
      self.formConsole.Memo1.Lines.Add('3. ���� "���-��", ���.1 � ��������� ���.');

     if self.sendMessage <> EKan_prin then
     begin
      self.formConsole.Memo1.Lines.Add('4. ��������: "��360, ����� � ����� ����� �����' + IntToStr(cdachaEksplSoedLin) + ' ������ � ������������ � XX-XX"');
      self.formChat.Edit1.Text:= '��� ����� �������.����� � ������������ ������. �����';
     end;

    if (self.objects[7].noImage <> 0)and(self.sendMessage = EKan_prin) then
      self.formConsole.Memo1.Lines.Add('5. ���� "���-��", ���.1 � ����������� ���������.');
  end;
  {$ENDREGION}

  end.
