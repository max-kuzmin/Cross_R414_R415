unit uRequestDM;

interface
uses
  uKeyValueDM,
  Generics.Collections;

const
  REQ_NAME_OK = 'ok';
  REQ_NAME_ERROR = 'error';
  REQ_NAME_REGISTRATION = 'registration';
  REQ_NAME_PARAMS = 'params';
  REQ_NAME_MESSAGE = 'message';   //�������� ��������� ���������
  REQ_NAME_WAVES = 'wave';        //�������� ���� �������

  REQ_NAME_UST_SVAZI = 'svaz';    //��� ��������� � ������� �����
  REQ_NAME_GEN_ACT = 'gener';
  REQ_NAME_FINISH_ACT = 'finish';

  KEY_NAME = 'username';          // �������� �������
  KEY_TYPE = 'type';              // ��� ������� (cross/r414/r415/server)
  KEY_STATUS = 'status';          // ������� �������� ����-� ��� �������
  KEY_CONNECTED = 'connected';    // ������ ����������� (true / false - ��� �����������)
  KEY_TEXT = 'txt';
  KEY_SVAZ_SET = 'set';
  KEY_GENERATE = 'state';
  KEY_FINISH = 'finish';

  KEY_MESSAGE_TEXT = 'txt';

  KEY_TRANSMITTER_WAVE_A = 'twavea';
  KEY_TRANSMITTER_WAVE_B = 'twaveb';
  KEY_RECEIVER_WAVE_A = 'rwavea';
  KEY_RECEIVER_WAVE_B = 'rwaveb';
  KEY_TASK_ID = 'taskid';

  KEY_USERNAME_TO = 'usernameto';
  KEY_USERNAME_FROM = 'usernamefrom';

   CLIENT_STATION_R414 = 'r414';
    CLIENT_CROSS = 'cross';
    CLIENT_STATION_R415 = 'r415';
    SERVER = 'server';

    CLIENT_STATION_R414_TASK = 'r414_task';
    CLIENT_CROSS_TASK = 'cross_task';

type
  TRequest = class
    private
      FKeyValueList: TList<TKeyValue>;
      FName: string;
    public
      property Name: string read FName write FName;
      function GetCountKeys: Integer;
      procedure AddKeyValue (Key: string; Value: string);
      property Count : Integer read GetCountKeys;
      function ConvertToText: string;
      function GetKeyValue(Index: Integer): TKeyValue;
      procedure ConvertToKeyValueList (Text: string);
      function GetValue(Key: string): string;
      constructor Create;

  end;
implementation

  /// <summary>
  /// ����������� ��������� ������������� ������� � ���������. (������).
  /// </summary>
  /// <param name="Text">�������� ������������� �������.</param>
  procedure TRequest.ConvertToKeyValueList(Text: string);
  var
    len: Integer;
    key: string;
  begin
    len := Pos(':', Text);
    if len > 0 then
    begin
      Name := Copy(Text, 1, len - 1);
      Delete(Text, 1, len);
      while True do
      begin
        if Length(Text) > 0 then
        begin
          len := Pos('=', Text);
          if len > 0 then
          begin
            key := Copy(Text, 1, len - 1);
            if Length(key) > 0 then
            begin
              Delete(Text, 1, len);
              len := Pos(',', Text);
              if len = 0 then
              begin
                AddKeyValue(key, Text);
                Break;
              end
              else
              begin
                AddKeyValue(key, Copy(Text, 1, len - 1));
                Delete(Text, 1, len);
                key := '';
                len := 0;
              end;
            end
            else
            begin
              Break;
            end;
          end;
        end
        else
        begin
          Break;
        end;
      end;
    end;
  end;

  /// <summary>
  /// ���������� �������� �� �����.
  /// </summary>
  /// <param name="Key">��� �����.</param>
  function TRequest.GetValue(Key: string): string;
  var
    i:Integer;
  begin
    for i := 0 to Count - 1 do
    begin
      if Key = GetKeyValue(i).Key then
        Exit(GetKeyValue(i).Value);
    end;
    Exit('');
  end;

  /// <summary>
  /// ���������� ���������� ������.
  /// </summary>
  function TRequest.GetCountKeys: Integer;
  begin
    Exit(FKeyValueList.Count);
  end;

  /// <summary>
  /// ���������� ������ ������ TKeyValue �� ������� � ������.
  /// </summary>
  function TRequest.GetKeyValue(Index: Integer): TKeyValue;
  begin
    if (Index >= 0) and (Index < Count) then
    begin
      Exit(FKeyValueList.Items[Index]);
    end
    else
      Exit(nil);
  end;

  /// <summary>
  /// ����������� ��������� ������������� ������� � ������.
  /// </summary>
  /// <returns>��������� ������������� �������.</returns>
  function TRequest.ConvertToText;
  var
    i: Integer;
    strResult: string;
  begin
    if Length(Name) > 0 then
    begin
      strResult := Name + ':';
      for i := 0 to Count - 1 do
      begin
        if i >= 1 then
        begin
          strResult := strResult + ',';
        end;
        strResult := strResult + FKeyValueList.Items[i].Key + '='
          + FKeyValueList.Items[i].Value;
      end;
      Exit(strResult);
    end;

  end;

  /// <summary>
  /// ����������� ������.
  /// </summary>
  constructor TRequest.Create;
  begin
    FKeyValueList := TList<TKeyValue>.Create;
  end;

  /// <summary>
  /// ��������� ����� ������ ����=�������� � ������.
  /// </summary>
  /// <param name="Key">����.</param>
  /// <param name="Value">��������.</param>
  procedure TRequest.AddKeyValue(Key: string; Value: string);
  var
    bKeyValue : TKeyValue;
  begin
    bKeyValue := TKeyValue.Create;
    bKeyValue.Key := Key;
    bKeyValue.Value:= Value;
    FKeyValueList.Add(bKeyValue);
  end;

end.
