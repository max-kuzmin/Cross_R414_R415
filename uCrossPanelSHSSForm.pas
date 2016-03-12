unit uCrossPanelSHSSForm;

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
  pngimage,
  ExtCtrls,
  uPortHandlerDM;

type
  TCrossPanelSHSS = class(TForm)
    imgCross: TImage;
  private
    PortHandler: TPortHandler;
  public



  end;

var
  CrossPanelSHSS: TCrossPanelSHSS;

implementation

{$R *.dfm}

end.
