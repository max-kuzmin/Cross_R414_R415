unit uBaseObject;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Controls,
  Forms,
  Dialogs,
  Generics.Collections,
  ExtCtrls,
  pngimage,
  Graphics;


type

  TObjectType = (EJACK2,EJACK4, EBUTTON, ESWITCH_2PV, ESWITCH_2PG, ESWITCH_3P, ESWITCH_6P,
    EPOWER);

  TChangeCross = procedure(name : string; noImage : integer; typeObject : TObjectType) of object;

  TBaseObject = class

    private
      imagesAnimation: TList<TImage>;
      typeObject : TObjectType;


    public
      noImage : integer;
      ban : bool;   //���� ����� ��������� ���������
      image: TImage;
      name : string;
      changeCross: TChangeCross;

      //������ �������� ��� ����� ��������� �� ���
      proverkaSoedLiniiR414 : boolean;  // �������� � R414 �� ����, �������� �� �������� ���� �������������� �����
      instrumProverkaR414 : boolean;    // �������� � R414 �� ����, ��������� �� ���������������� �������� ���� �����
      sdachaKanalovR414 : boolean;      // �������� � R414 �� ����, ��������� �� ����� ����� ������

      constructor create(typeObjectTmp : TObjectType; imageTmp: TImage; nameTmp : string);
      procedure LoadImageFiles();
      //�������
      procedure ImageClick(Sender: TObject);
      procedure ImageMouseDown(Sender: TObject;
        Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      procedure ImageMouseUp(Sender: TObject;
        Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      //
      procedure changeObject();

      procedure changeState(no : integer);

  end;

implementation

  constructor   TBaseObject.create(typeObjectTmp : TObjectType; imageTmp: TImage; nameTmp : string);
  begin
    //��������� ������ �� ��������
    self.image := imageTmp;
    //������������� ������� �����

    if (typeObjectTmp = EJACK4)or(typeObjectTmp = ESWITCH_2PV)or(typeObjectTmp = ESWITCH_2PG)
    or(typeObjectTmp = ESWITCH_3P) or(typeObjectTmp = ESWITCH_6P)or(typeObjectTmp = EPOWER) then
      self.image.OnClick := ImageClick;
    //
    self.typeObject := typeObjectTmp;

    if typeObjectTmp = EBUTTON then
    begin
      self.image.OnMouseDown := self.ImageMouseDown;
      self.image.OnMouseUp := self.ImageMouseUp;
    end;
    //����� ��������� ��������
    noImage := 0;
    //
    self.imagesAnimation :=  TList<TImage>.create();
    self.LoadImageFiles();

    self.ban := false;

    self.name := nameTmp;

    //��� ������ �� ���� ���������� ��� � �-414
    self.proverkaSoedLiniiR414 := true;
    self.instrumProverkaR414 := true;
    self.sdachaKanalovR414 := true;
  end;

  {$REGION '������ �������� ��� ��������'}
    procedure TBaseObject.LoadImageFiles();
      var
        bufImage, bufImage1, bufImage2, bufImage3, bufImage4, bufImage5: TImage;
      begin
          //4�� ������
          if self.typeObject = EJACK4 then
          begin
            bufImage := TImage.Create(nil);
            bufImage1 := TImage.Create(nil);

            bufImage1.Picture.LoadFromFile('data/images/4PR0.png');
            self.imagesAnimation.Add(bufImage1);

            bufImage.Picture.LoadFromFile('data/images/4PR1.png');
            self.imagesAnimation.Add(bufImage);
          end;

          if self.typeObject = EBUTTON then
          begin
            bufImage := TImage.Create(nil);
            bufImage1 := TImage.Create(nil);

            bufImage1.Picture.LoadFromFile('data/images/but0.png');
            self.imagesAnimation.Add(bufImage1);

            bufImage.Picture.LoadFromFile('data/images/but1.png');
            self.imagesAnimation.Add(bufImage);

            self.image.Picture := self.imagesAnimation[self.noImage].Picture;
          end;

          if self.typeObject = ESWITCH_2PV then
          begin
            bufImage := TImage.Create(nil);
            bufImage1 := TImage.Create(nil);

            bufImage1.Picture.LoadFromFile('data/images/switch2pV1.png');
            self.imagesAnimation.Add(bufImage1);

            bufImage.Picture.LoadFromFile('data/images/switch2pV0.png');
            self.imagesAnimation.Add(bufImage);

            self.image.Picture := self.imagesAnimation[self.noImage].Picture;
          end;

          if self.typeObject = ESWITCH_2PG then
          begin
            bufImage := TImage.Create(nil);
            bufImage1 := TImage.Create(nil);

            bufImage1.Picture.LoadFromFile('data/images/switch2pG1.png');
            self.imagesAnimation.Add(bufImage1);

            bufImage.Picture.LoadFromFile('data/images/switch2pG0.png');
            self.imagesAnimation.Add(bufImage);

            self.image.Picture := self.imagesAnimation[self.noImage].Picture;
          end;

          if self.typeObject = ESWITCH_3P then
          begin
            bufImage := TImage.Create(nil);
            bufImage1 := TImage.Create(nil);
            bufImage2 := TImage.Create(nil);

            bufImage1.Picture.LoadFromFile('data/images/switch3p1.png');
            self.imagesAnimation.Add(bufImage1);

            bufImage.Picture.LoadFromFile('data/images/switch3p0.png');
            self.imagesAnimation.Add(bufImage);

            bufImage2.Picture.LoadFromFile('data/images/switch3p2.png');
            self.imagesAnimation.Add(bufImage2);

            self.image.Picture := self.imagesAnimation[self.noImage].Picture;
          end;

          if self.typeObject = ESWITCH_6P then
          begin
            bufImage := TImage.Create(nil);
            bufImage1 := TImage.Create(nil);
            bufImage2 := TImage.Create(nil);
            bufImage3 := TImage.Create(nil);
            bufImage4 := TImage.Create(nil);
            bufImage5 := TImage.Create(nil);

            bufImage.Picture.LoadFromFile('data/images/switch6p0.png');
            self.imagesAnimation.Add(bufImage);

            bufImage1.Picture.LoadFromFile('data/images/switch6p1.png');
            self.imagesAnimation.Add(bufImage1);

            bufImage2.Picture.LoadFromFile('data/images/switch6p2.png');
            self.imagesAnimation.Add(bufImage2);

            bufImage3.Picture.LoadFromFile('data/images/switch6p3.png');
            self.imagesAnimation.Add(bufImage3);

            bufImage4.Picture.LoadFromFile('data/images/switch6p4.png');
            self.imagesAnimation.Add(bufImage4);

            bufImage5.Picture.LoadFromFile('data/images/switch6p5.png');
            self.imagesAnimation.Add(bufImage5);

            self.image.Picture := self.imagesAnimation[self.noImage].Picture;
          end;

          if self.typeObject = EPOWER then
          begin
            bufImage1 := TImage.Create(nil);
            bufImage1.Picture.LoadFromFile('data/images/switchPower0.png');
            self.imagesAnimation.Add(bufImage1);

            bufImage := TImage.Create(nil);
            bufImage.Picture.LoadFromFile('data/images/switchPower1.png');
            self.imagesAnimation.Add(bufImage);

            self.image.Picture := self.imagesAnimation[self.noImage].Picture;
          end;

      end;

  {$ENDREGION}

  //���� ��������� ���� ��������� �����(��� 4�� �������)
  procedure TBaseObject.changeState(no : integer);
  begin
    self.noImage := no;
    self.image.Picture := imagesAnimation[noImage].Picture;
  end;
  //��������� �������
  procedure TBaseObject.changeObject();
  begin
    if self.ban = false then
    begin
      if noImage < imagesAnimation.Count - 1 then
      begin
        noImage := noImage + 1;
      end
      else
        noImage := 0;

      self.image.Picture := imagesAnimation[noImage].Picture;

//      ShowMessage(IntToStr(noImage));

      if Assigned(changeCross) then
        changeCross(name,noImage,typeObject);
    end
    else
      ShowMessage('�������� �����������.');
  end;

  //������� �����
  procedure TBaseObject.ImageClick(Sender: TObject);
  begin

      self.changeObject();
  end;
  //������� ������� �����
  procedure TBaseObject.ImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
      self.changeObject();
  end;
  //������� ��� ���������� ������ ����
  procedure TBaseObject.ImageMouseUp(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
      self.changeObject();
  end;

end.
