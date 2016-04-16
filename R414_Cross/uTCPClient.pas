unit uTCPClient;

interface

uses
  Windows, Messages, Variants, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus,IdBaseComponent, IdComponent, IdGlobal,  Classes,
   SysUtils, IdTCPClient, uResponseListener, uRequestDM, uKeyValueDM, uFormChat, uEducation;

type

  //��� ���������� ������
  TTypeCross  = (T_C_NIL, T_C_SUBORDINATE, T_C_MAIN);
  //��� ���������� �-414
  TTypeStationR414 = (T_R414_NIL, T_R414_SUBORDINATE, T_R414_MAIN);

  TTCPClientCross = class
    private
      IdTCPClient: TIdTCPClient;
      ResponseListener: TResponseListener;
      formChat: TformChat;
      typeCross: TTypeCross;
      typeStationR414: TTypeStationR414;
      Education: TEducation;


    public
      constructor Create(formChat: TformChat);
      function tryConect(nick: string; hostName: string; hostPort: string):boolean;
      function tryDisconnect():boolean;
      procedure OnResponse(strResponse: string);
      procedure ProcessMessage(strMessage: string);
      procedure SendMessage(Value: string; Name: string);
      procedure SendTaskParamsR414(Key: string; Value: string);
      procedure BindEducation(education: TEducation);

  end;




implementation
uses
  IdExceptionCore;


  constructor TTCPClientCross.Create(formChat: TformChat);
  begin
    self.IdTCPClient := TIdTCPClient.Create(nil);
    self.formChat := formChat;
    //formChat.SendMessageEvent:= self.SendMessage;

    self.typeCross := T_C_NIL;
    self.typeStationR414 := T_R414_NIL;

  end;

  procedure TTCPClientCross.BindEducation(education: TEducation);
  begin
    Self.Education:= education;
    Education.SendTaskParamsR414 := SendTaskParamsR414;
    Education.SendMessageEvent:= SendMessage;
    Education.Online := True;
  end;


  procedure TTCPClientCross.SendMessage(Value: string; Name: string);
  var
    Request: TRequest;
  begin
    Request := TRequest.Create;                 // ������ ����� ������
    Request.Name := REQ_NAME_MESSAGE;
    //Request.AddKeyValue(KEY_TYPE, Client);      // ��� �������  �������� ���� ���������

    Request.AddKeyValue(KEY_USERNAME_FROM, self.formChat.UserName);
    Request.AddKeyValue(KEY_USERNAME_TO, Name);
    Request.AddKeyValue(KEY_MESSAGE_TEXT, Value);            // ���� ���� � ��������

    self.IdTCPClient.IOHandler.WriteLn(Request.ConvertToText);
    Request.Free;
  end;


  //������� ������������ � �������
  function TTCPClientCross.tryConect(nick: string; hostName: string; hostPort: string):boolean;
    var
      Request : TRequest;
      strResponse : string;
  begin
    try
      self.IdTCPClient.Host := hostName;
      self.IdTCPClient.Port := StrToInt(hostPort);
      self.IdTCPClient.Connect;
      self.IdTCPClient.IOHandler.DefStringEncoding := TIdTextEncoding.UTF8;
    except
      ShowMessage('����� � �������� ���.');
      exit(false);
    end;

    Self.formChat.UserName:= nick;

    Request := TRequest.Create;                       // ������ ����� ������
    Request.Name := REQ_NAME_REGISTRATION;
    Request.AddKeyValue(KEY_NAME, nick);              // �������� � ������ ���
                                                      // ������������
    Request.AddKeyValue(KEY_TYPE, 'cross');            // � ��� �������
    self.IdTCPClient.IOHandler.WriteLn(Request.ConvertToText);
    Request.Free;

    try
      strResponse := self.IdTCPClient.IOHandler.ReadLn();
    except
      strResponse := '';                              // ����� ����� ��� ������
    end;

    if strResponse = '' then
    begin
      self.IdTCPClient.Disconnect;                           // ���� �� ��������
      ShowMessage('������ �� ��������.');
      exit(false);
    end;

    Request := TRequest.Create;
    Request.ConvertToKeyValueList(strResponse);       // ��������� ����� �������
                                                      // � ��������� ���
    if Request.Name <> REQ_NAME_OK  then
    begin                                             // ���� ���� �� ������ ���,
      self.IdTCPClient.Disconnect;                    // �� �������, ��� ��� ��
      Request.Free;                                   // ���������
      ShowMessage('�������� �����.');
      exit(false);
    end;

    Request.Free;                                     // �� �������� ������ �����

    //������������� �� ������� ��������� ���� �� �������
    ResponseListener := TResponseListener.Create(self.IdTCPClient);
    ResponseListener.ResponseEvent := OnResponse;

    exit(true);
  end;

  //������� ����������� �� �������
  function TTCPClientCross.tryDisconnect():boolean;
  begin
    try
      self.IdTCPClient.Disconnect;

      self.formChat.Label4.Caption := '�������';
      self.formChat.Label3.Caption := '�������';

      self.formChat.Label4.Font.Color := clRed;
      self.formChat.Label3.Font.Color := clRed;

      self.formChat.LinkedCrossUserName:= '';
      self.formChat.LinkedR414UserName:= '';

    except
      Exit(false);
    end;
    exit(true);
  end;

  //������ �������
  procedure TTCPClientCross.OnResponse(strResponse: string);
  begin
    self.ProcessMessage(strResponse);
//    ShowMessage(strResponse);
  end;

  procedure TTCPClientCross.ProcessMessage(strMessage: string);
  var
    Request: TRequest;
    strValue: string;
    kvRecord: TKeyValue;
    i: Integer;
  begin
    Request := TRequest.Create;
    Request.ConvertToKeyValueList(strMessage);       // ������ ��������� �������

    //��������� ��������� ��������� �� ����������� �������
    if Request.Name = REQ_NAME_MESSAGE then
    begin
      strValue := Request.GetValue(KEY_TEXT);
      self.formChat.Memo1.Lines.Add(Request.GetValue(KEY_USERNAME_FROM) + ': ' + strValue);
    end
    else

    if Request.Name = REQ_NAME_PARAMS then            {TODO: ������� ���� � ������ ������� }
    begin
      strValue := Request.GetValue(KEY_TYPE);

      if strValue = SERVER then
      begin
        strValue := Request.GetValue(KEY_STATUS); // ������� � ������� ������������

        if strValue = 'subordinate' then
        begin
          self.typeCross := T_C_SUBORDINATE;
        end
        else
        begin
          self.typeCross := T_C_MAIN;
        end;
      end

      else
      if strValue = CLIENT_CROSS then
      begin
        for i := 0 to Request.GetCountKeys - 1 do
        try
          kvRecord := Request.GetKeyValue(i);
          if kvRecord.Key = KEY_NAME then             // ���� ��������� �������
          begin                                       // �������� ��� ���, ��
                                                      // ��� ����������� ��� ������������
            strValue := Request.GetValue(KEY_CONNECTED);

            if strToBool(strValue) then               // ���� connected = true
            begin
                //���� ���� ����������� ������ ����� ������ � ���
                self.formChat.Button1.Enabled := true;
                //���������� ���
                strValue := Request.GetValue(KEY_NAME);
                self.formChat.Label4.Caption := strValue;
                self.formChat.Label4.Font.Color := clLime;

                self.formChat.LinkedCrossUserName:=  strValue;
                self.formChat.linkedCrossConnected := true;
            end
            else                                      // connected = false
            begin
                self.formChat.Button1.Enabled := false;

                self.formChat.Label4.Caption := '�������';
                self.formChat.Label4.Font.Color := clRed;

                self.formChat.LinkedCrossUserName:= '';
                self.formChat.linkedCrossConnected := false;
            end;
            break;
          end;
        except
          on E: Exception do;                   //��������, ��� ���� ������� �����
        end;                                    // (������ ����������� strValue);
      end
      else
      if strValue = CLIENT_STATION_R414 then
      begin
        for i := 0 to Request.GetCountKeys - 1 do
        try
          kvRecord := Request.GetKeyValue(i);
          if kvRecord.Key = KEY_NAME then             // ���� ��������� �������
          begin                                       // �������� ��� ���, ��
                                                      // ��� ����������� ��� ������������
            strValue := Request.GetValue(KEY_CONNECTED);

            if strToBool(strValue) then               // ���� connected = true
            begin
                //���� ���� ����������� ������ ����� ������ � ���
                self.formChat.Button1.Enabled := true;
                //���������� ���
                strValue := Request.GetValue(KEY_NAME);
                self.formChat.Label3.Caption := strValue;
                self.formChat.Label3.Font.Color := clLime;

                self.formChat.LinkedR414UserName:=  strValue;
                self.formChat.linkedR414Connected := true;
            end
            else                                      // connected = false
            begin
                self.formChat.Button1.Enabled := false;

                self.formChat.Label3.Caption := '�������';
                self.formChat.Label3.Font.Color := clRed;

                self.formChat.LinkedR414UserName:= '';
                self.formChat.linkedR414Connected := false;
            end;
            break;
          end;
        except
          on E: Exception do;                   //��������, ��� ���� ������� �����
        end;                                    // (������ ����������� strValue);
      end
      else if (strValue = CLIENT_CROSS_TASK) then
      begin
        for i := 0 to Request.GetCountKeys - 1 do
        try
          kvRecord := Request.GetKeyValue(i);
          if kvRecord.Key <> KEY_TYPE then
          begin
              Education.TaskNetParams.ChangeValue(kvRecord.Key, kvRecord.Value);
              Education.changCrossEducation('');
          end;
        except
          on E: Exception do;
        end;
      end;
    end;
    Education.changCrossEducation('');
    Request.Free;                                  // ������� �����
  end;



  procedure TTCPClientCross.SendTaskParamsR414(Key: string; Value: string);
  var
    Request: TRequest;
  begin
    Request := TRequest.Create;                 // ������ ����� ������
    Request.Name := REQ_NAME_PARAMS;
    Request.AddKeyValue(KEY_TYPE, CLIENT_STATION_R414_TASK);      // ��� �������

    Request.AddKeyValue(Key, Value);            // ���� ���� � ��������

    IdTCPClient.IOHandler.WriteLn(Request.ConvertToText);
    Request.Free;                               // ������ �����
  end;

end.
