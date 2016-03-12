unit uCross;

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
  uEducation,
  uFormConsole;

type
  TWireFinishCross = procedure() of object;

  TCross = class
    private
      objects: TList<TBaseObject>;
      lamps: TList<TLamp>;
      wires: TList<TWire>;

    public
      education: TEducation;
      wireCreation : boolean;
      delWire : boolean;
      wireFinishCross :TWireFinishCross;

      constructor Create();
      procedure addObject(typeObject : TObjectType; imageTmp: TImage; nameTmp : string);
      procedure addLamp(imageTmp: TImage);
      procedure onChange(name : string; noImage : integer; typeObject : TObjectType);
      function getObjectByName(nameTmp : string):TBaseObject;
      procedure addToWire(name : string);
      function deleteWire(name : string):boolean;
      function findBadWire():boolean;
      procedure defaultOrgans();
      procedure createEducation();
      procedure freeEducation();
  end;

implementation

  constructor TCross.Create();
  begin
    objects := TList<TBaseObject>.create();
    lamps := TList<TLamp>.create();
    wires := TList<TWire>.create();

    self.wireCreation := false;
    self.delWire := false;

    self.education := nil;

  end;

  //создает обучение
  procedure TCross.createEducation();
  begin
    self.education := TEducation.Create(self.objects, self.lamps, self.wires);
  end;

  //удаляет обучение
  procedure TCross.freeEducation();
  begin
    self.education.free;
    self.education := nil;

    self.defaultOrgans;
  end;

  //удаляем полупустыей провода
  function TCross.findBadWire():boolean;
  var I:integer;
  begin

    for I := 0 to self.wires.Count - 1 do
    begin
      if (self.wires[I].firstObject.noImage = 0)or(self.wires[I].lastObject.noImage = 0)  then
      begin
        self.wires[I].firstObject.image.Hint := '';
        self.wires[I].lastObject.image.Hint := '';

        self.wires[I].firstObject.changeState(0);
        self.wires[I].lastObject.changeState(0);

        self.wires.Delete(I);
//        ShowMessage(IntToStr(self.wires.Count));
        exit(true);
      end;
    end;

    exit(false);
  end;

  //событие изменения любого параметра кросса
  procedure TCross.onChange(name : string; noImage : integer; typeObject : TObjectType);
  begin
    try
      self.findBadWire();
    except end;

    self.addToWire(name);

    if self.delWire then
      self.deleteWire(name);

    if self.education <> nil then
      self.education.changCrossEducation(name);
  end;

  //создаем новый объект управления
  procedure TCross.addObject(typeObject : TObjectType; imageTmp: TImage; nameTmp : string);
  begin
    self.objects.Add(TBaseObject.create(typeObject, imageTmp, nameTmp));
    self.objects.Last.changeCross := self.onChange;
  end;

  //создаем лампочки
  procedure TCross.addLamp(imageTmp: TImage);
  begin
    self.lamps.Add(TLamp.create(imageTmp));
  end;

  //создает провод
  procedure TCross.addToWire(name : string);
  begin
    if Pos('4ПР.',name) <> 0 then
        if self.wireCreation then
        begin
            if (self.wires.Count = 0) then
            begin
                self.wires.Add(TWire.Create);
                self.wires.Last.wireFinish := self.wireFinishCross;
                self.wires.Last.addObject(self.getObjectByName(name));
            end
            else
            begin
                if(self.wires.Last.finish)then
                begin
                    self.wires.Add(TWire.Create);
                    self.wires.Last.wireFinish := self.wireFinishCross;
                    self.wires.Last.addObject(self.getObjectByName(name));
                end
                else
                begin
                  self.wires.Last.addObject(self.getObjectByName(name));
                end;
            end;
        end;
  end;

  //проверяет нужно ли удалять провод и удаляет
  function TCross.deleteWire(name : string):boolean;
    var I:integer;
  begin
    //ищем провод с таким объектом
    for I := 0 to self.wires.Count - 1 do
    begin
      if (self.wires[I].firstObject.name = name) or (self.wires[I].lastObject.name = name) then
      begin
        getObjectByName(name).image.Hint := '';
        self.wires.Delete(I);
        exit(true);
      end;
    end;

    exit(false);

  end;

  //возвращает объект по его имени
  function TCross.getObjectByName(nameTmp : string):TBaseObject;
    var I:integer;
  begin
    for I := 0 to self.objects.Count - 1 do
    begin
      if self.objects[i].name = nameTmp then
        exit(objects[i]);
    end;

    exit(nil);
  end;

  //выставляет все объекты в состояние по умолчанию
  procedure TCross.defaultOrgans();
    var I:integer;
  begin
    for I := 0 to self.objects.Count - 1 do
    begin
      self.objects[I].changeState(0);
      self.objects[I].ban := false;
    end;

    for I := 0 to self.lamps.Count - 1 do
      self.lamps[I].offLamp;

    for I := 0 to self.wires.Count - 1 do
    begin
      self.wires[I].nahui;
      self.wires.Delete(I);
    end;
  end;
end.
