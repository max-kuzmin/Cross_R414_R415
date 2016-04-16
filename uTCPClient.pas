unit uTCPClient;

interface

uses
  Windows, Messages, Variants, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus,IdBaseComponent, IdComponent, IdGlobal,  Classes,
   SysUtils, IdTCPClient, uResponseListener, uRequestDM, uKeyValueDM, uFormChat, uEducation;

type

  //тип подчинения кросса
  TTypeCross  = (T_C_NIL, T_C_SUBORDINATE, T_C_MAIN);
  //тип подчинения Р-414
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
    Request := TRequest.Create;                 // Создаём новый запрос
    Request.Name := REQ_NAME_MESSAGE;
    //Request.AddKeyValue(KEY_TYPE, Client);      // Тип клиента  которому шлем сообщение

    Request.AddKeyValue(KEY_USERNAME_FROM, self.formChat.UserName);
    Request.AddKeyValue(KEY_USERNAME_TO, Name);
    Request.AddKeyValue(KEY_MESSAGE_TEXT, Value);            // Наши ключ и значение

    self.IdTCPClient.IOHandler.WriteLn(Request.ConvertToText);
    Request.Free;
  end;


  //попытка подключиться к серваку
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
      ShowMessage('Связи с сервером нет.');
      exit(false);
    end;

    Self.formChat.UserName:= nick;

    Request := TRequest.Create;                       // Создаём новый запрос
    Request.Name := REQ_NAME_REGISTRATION;
    Request.AddKeyValue(KEY_NAME, nick);              // Включаем в запрос имя
                                                      // пользователя
    Request.AddKeyValue(KEY_TYPE, 'cross');            // и тип клиента
    self.IdTCPClient.IOHandler.WriteLn(Request.ConvertToText);
    Request.Free;

    try
      strResponse := self.IdTCPClient.IOHandler.ReadLn();
    except
      strResponse := '';                              // Когда долго нет ответа
    end;

    if strResponse = '' then
    begin
      self.IdTCPClient.Disconnect;                           // Серв не отвечает
      ShowMessage('Сервер не отвечает.');
      exit(false);
    end;

    Request := TRequest.Create;
    Request.ConvertToKeyValueList(strResponse);       // Переводим ответ сервера
                                                      // в объектный вид
    if Request.Name <> REQ_NAME_OK  then
    begin                                             // Если серв не принял имя,
      self.IdTCPClient.Disconnect;                    // то считаем, что оно не
      Request.Free;                                   // уникально
      ShowMessage('Позывной занят.');
      exit(false);
    end;

    Request.Free;                                     // Не забываем убрать мусор

    //подписываемся на события обработки инфы от сервака
    ResponseListener := TResponseListener.Create(self.IdTCPClient);
    ResponseListener.ResponseEvent := OnResponse;

    exit(true);
  end;

  //попытка отключиться от сервака
  function TTCPClientCross.tryDisconnect():boolean;
  begin
    try
      self.IdTCPClient.Disconnect;

      self.formChat.Label4.Caption := 'Оффлайн';
      self.formChat.Label3.Caption := 'Оффлайн';

      self.formChat.Label4.Font.Color := clRed;
      self.formChat.Label3.Font.Color := clRed;

      self.formChat.LinkedCrossUserName:= '';
      self.formChat.LinkedR414UserName:= '';

    except
      Exit(false);
    end;
    exit(true);
  end;

  //ответы сервера
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
    Request.ConvertToKeyValueList(strMessage);       // Парсим сообщение сервера

    //принимаем текстовое сообщение от сопряженной станции
    if Request.Name = REQ_NAME_MESSAGE then
    begin
      strValue := Request.GetValue(KEY_TEXT);
      self.formChat.Memo1.Lines.Add(Request.GetValue(KEY_USERNAME_FROM) + ': ' + strValue);
    end
    else

    if Request.Name = REQ_NAME_PARAMS then            {TODO: вынести тело в инлайн функцию }
    begin
      strValue := Request.GetValue(KEY_TYPE);

      if strValue = SERVER then
      begin
        strValue := Request.GetValue(KEY_STATUS); // Станция у данного пользователя

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
          if kvRecord.Key = KEY_NAME then             // Если связанная станция
          begin                                       // прислала своё имя, то
                                                      // она отключилась или подключилась
            strValue := Request.GetValue(KEY_CONNECTED);

            if strToBool(strValue) then               // Если connected = true
            begin
                //если есть подключение значит можем писать в чат
                self.formChat.Button1.Enabled := true;
                //выставляем ник
                strValue := Request.GetValue(KEY_NAME);
                self.formChat.Label4.Caption := strValue;
                self.formChat.Label4.Font.Color := clLime;

                self.formChat.LinkedCrossUserName:=  strValue;
                self.formChat.linkedCrossConnected := true;
            end
            else                                      // connected = false
            begin
                self.formChat.Button1.Enabled := false;

                self.formChat.Label4.Caption := 'Оффлайн';
                self.formChat.Label4.Font.Color := clRed;

                self.formChat.LinkedCrossUserName:= '';
                self.formChat.linkedCrossConnected := false;
            end;
            break;
          end;
        except
          on E: Exception do;                   //Залогать, что серв прислал херню
        end;                                    // (Ошибка конвертации strValue);
      end
      else
      if strValue = CLIENT_STATION_R414 then
      begin
        for i := 0 to Request.GetCountKeys - 1 do
        try
          kvRecord := Request.GetKeyValue(i);
          if kvRecord.Key = KEY_NAME then             // Если связанная станция
          begin                                       // прислала своё имя, то
                                                      // она отключилась или подключилась
            strValue := Request.GetValue(KEY_CONNECTED);

            if strToBool(strValue) then               // Если connected = true
            begin
                //если есть подключение значит можем писать в чат
                self.formChat.Button1.Enabled := true;
                //выставляем ник
                strValue := Request.GetValue(KEY_NAME);
                self.formChat.Label3.Caption := strValue;
                self.formChat.Label3.Font.Color := clLime;

                self.formChat.LinkedR414UserName:=  strValue;
                self.formChat.linkedR414Connected := true;
            end
            else                                      // connected = false
            begin
                self.formChat.Button1.Enabled := false;

                self.formChat.Label3.Caption := 'Оффлайн';
                self.formChat.Label3.Font.Color := clRed;

                self.formChat.LinkedR414UserName:= '';
                self.formChat.linkedR414Connected := false;
            end;
            break;
          end;
        except
          on E: Exception do;                   //Залогать, что серв прислал херню
        end;                                    // (Ошибка конвертации strValue);
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
    Request.Free;                                  // Убираем мусор
  end;



  procedure TTCPClientCross.SendTaskParamsR414(Key: string; Value: string);
  var
    Request: TRequest;
  begin
    Request := TRequest.Create;                 // Создаём новый запрос
    Request.Name := REQ_NAME_PARAMS;
    Request.AddKeyValue(KEY_TYPE, CLIENT_STATION_R414_TASK);      // Тип клиента

    Request.AddKeyValue(Key, Value);            // Наши ключ и значение

    IdTCPClient.IOHandler.WriteLn(Request.ConvertToText);
    Request.Free;                               // Чистим мусор
  end;

end.
