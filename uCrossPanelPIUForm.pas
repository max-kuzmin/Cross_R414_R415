unit uCrossPanelPIUForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  pngimage,
  uRequestDM,
  uPortHandlerDM;

type
  TCrossPanelPIU = class(TForm)
    imgCrossPanelPIU: TImage;
    procedure FormCreate(Sender: TObject);
  private
    PortHandler: TPortHandler;
  public

  end;

var
  CrossPanelPIU: TCrossPanelPIU;

implementation

{$R *.dfm}
 {$I+}
  procedure TCrossPanelPIU.FormCreate(Sender: TObject);
  var
    png: TImage;
  begin
    imgCrossPanelPIU.Picture.LoadFromFile('data/images/CrossPanelPIU.png');
    png := TImage.Create(Self);
    png.Picture.LoadFromFile('data/images/Connector.png');
    PortHandler := TPortHandler.Create(Self, Self, png, 26, 13,
      'data/configCrossPanelPIU.txt');
  end;

end.
