unit uLampObject;

interface

uses
  Generics.Collections,
  ExtCtrls;

type
  TLamp = class
    private
      image: TImage;
      imagesAnimation: TList<TImage>;
    public
      constructor create(imageTmp: TImage);
      procedure LoadImageFiles();
      procedure  onRedLamp();
      procedure  onGreenLamp();
      procedure  offLamp();

  end;

implementation

  constructor TLamp.create(imageTmp: TImage);
  begin
    self.image := imageTmp;

    self.imagesAnimation :=  TList<TImage>.create();

    self.LoadImageFiles();
  end;

   //грузим картинки для анимации
  procedure TLamp.LoadImageFiles();
  var
    bufImage, bufImage1, bufImage2: TImage;
  begin
        bufImage := TImage.Create(nil);
        bufImage.Picture.LoadFromFile('data/images/lamp0.png');
        self.imagesAnimation.Add(bufImage);

        bufImage1 := TImage.Create(nil);
        bufImage1.Picture.LoadFromFile('data/images/lampG.png');
        self.imagesAnimation.Add(bufImage1);

        bufImage2 := TImage.Create(nil);
        bufImage2.Picture.LoadFromFile('data/images/lampR.png');
        self.imagesAnimation.Add(bufImage2);

        self.offLamp;
  end;
  //выставляем лампочку зеленым цветом
  procedure TLamp.onGreenLamp();
  begin
    self.image.Picture := self.imagesAnimation[1].Picture;
  end;
    //выставляем лампочку красным цветом
  procedure TLamp.onRedLamp();
  begin
    self.image.Picture := self.imagesAnimation[2].Picture;
  end;
  //выставляем лампочку в исходное положение
  procedure TLamp.offLamp();
  begin
    self.image.Picture := self.imagesAnimation[0].Picture;
  end;
end.
