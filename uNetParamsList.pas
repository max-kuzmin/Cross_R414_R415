unit uNetParamsList;

interface
uses
  uKeyValueDM,
  Generics.Collections;


  type
  TNetParamsList = class
    private
      FKeyValueList: TList<TKeyValue>;
    public
      procedure AddKeyValue (Key: string; Value: string);
      function GetBoolValue(Key: string): Boolean;
      procedure ChangeValue(Key: string; Value: string);
      constructor Create;
  end;

implementation


 constructor TNetParamsList.Create;
  begin
    FKeyValueList := TList<TKeyValue>.Create;
  end;


    procedure TNetParamsList.AddKeyValue(Key: string; Value: string);
  var
    bKeyValue : TKeyValue;
  begin
    bKeyValue := TKeyValue.Create;
    bKeyValue.Key := Key;
    bKeyValue.Value:= Value;
    FKeyValueList.Add(bKeyValue);
  end;


    function TNetParamsList.GetBoolValue(Key: string): Boolean;
  var
    i:Integer;
  begin
    for i := 0 to FKeyValueList.Count - 1 do
    begin
      if Key = FKeyValueList[i].Key then
        if (FKeyValueList[i].Value='True') or (FKeyValueList[i].Value='true') then
          Exit(True)
          else
          Exit(False);
    end;
    Exit(False);
  end;

    procedure TNetParamsList.ChangeValue(Key: string; Value: string);
  var
    i:Integer;
    bKeyValue : TKeyValue;
  begin
    for i := 0 to FKeyValueList.Count - 1 do
    begin
      if Key = FKeyValueList[i].Key then
      begin
      FKeyValueList.Remove(FKeyValueList[i]);
      bKeyValue := TKeyValue.Create;
      bKeyValue.Key := Key;
      bKeyValue.Value:= Value;
      FKeyValueList.Add(bKeyValue);
      Exit;
      end;
    end;
  end;

end.
