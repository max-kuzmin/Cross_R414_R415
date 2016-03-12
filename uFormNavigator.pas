unit uFormNavigator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, pngimage, uFormCross;

type
  TformNavigator = class(TForm)
    Image1: TImage;
    border: TImage;

    procedure borderMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure borderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure borderMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
      mouseDown : Boolean;
      dH: byte;
      formCross: TformCross;

  public
    procedure PaintBorder(X:Integer;Y:integer);
    procedure addCrossForm(formCross: TformCross);
  end;

var
  formNavigator: TformNavigator;

implementation
{$R *.dfm}

procedure TformNavigator.addCrossForm(formCross: TformCross);
begin
  self.formCross := formCross;
end;

procedure TformNavigator.PaintBorder(X:Integer;Y:integer);
begin
    border.Repaint;
    Self.Canvas.Pen.Width := 2;
    Self.Canvas.Pen.Color := clRed;
    Self.Canvas.MoveTo(0,Y);
    Self.Canvas.LineTo(Self.ClientWidth-5,Y);
    Self.Canvas.LineTo(Self.ClientWidth-5,Y + Round(formCross .ClientHeight/(formCross.VertScrollBar.Range/self.ClientHeight)));
    Self.Canvas.LineTo(0,Y + Round(formCross.ClientHeight/(formCross.VertScrollBar.Range/self.ClientHeight)));
    Self.Canvas.LineTo(0,Y);
    formCross.VertScrollBar.Position := Round(Y *   formCross.VertScrollBar.Range/self.ClientHeight) ;

end;

procedure TformNavigator.borderMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mouseDown := True;
  PaintBorder(X,Y);
end;

procedure TformNavigator.borderMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if mouseDown = true then
  begin
    PaintBorder(X,Y);
  end;
end;

procedure TformNavigator.borderMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mouseDown := false;
end;

procedure TformNavigator.FormCreate(Sender: TObject);
begin
  dH := 20;
end;




end.
