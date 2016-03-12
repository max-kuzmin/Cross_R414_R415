unit uWireObject;

interface

uses
  Generics.Collections,
  ExtCtrls,
  uBaseObject,
  SysUtils,
  Dialogs;

type
  TWireFinish = procedure() of object;

  TWire = class
    private


    public
      wireFinish: TWireFinish;
      firstObject, lastObject :TBaseObject;
      finish : boolean;
      constructor Create();
      destructor nahui;
      procedure addObject(objectBase:TBaseObject);

  end;

implementation

  constructor TWire.Create;
  begin
    finish := false;
  end;

  destructor TWire.nahui;
  begin
    self.firstObject.changeState(0);
    self.lastObject.changeState(0);

    self.firstObject.image.Hint := '';
    self.lastObject.image.Hint := '';
  end;

  procedure TWire.addObject(objectBase:TBaseObject);
  begin

      if self.firstObject = nil then
      begin
          self.firstObject := objectBase;
          self.firstObject.changeState(1);
  //      self.firstObject.ban := true
      end
      else
      begin
          self.lastObject := objectBase;
          self.lastObject.changeState(1);
  //      self.lastObject.ban := true;
      end;

      if (self.firstObject <> nil)and(self.lastObject <> nil) then
      begin
        self.finish := true;
        self.firstObject.image.Hint := self.lastObject.name;
        self.lastObject.image.Hint := self.firstObject.name;
        ShowMessage('Коммутация ' + firstObject.name + ' и ' +lastObject.name + ' произведена.' );

        if Assigned(wireFinish) then
          wireFinish();
      end;
  end;

end.
