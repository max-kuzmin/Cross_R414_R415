unit uResponseListener;

interface

uses
  Classes,
  SysUtils,
  IdTCPClient;

type
  TResponseEvent = procedure(strResponse: String) of object; // ����� "������
                                                             // ����� �������"

type
  TResponseListener = class(TThread)
  private
    TCPClient: TIdTCPClient;
    FResponseEvent: TResponseEvent;             // ������ �� ��������������
                                                // ������� ������������ �� �������
                                                // �������
    FResponse: string;
    procedure DoResponseEvent;
    procedure Execute; override;

  public
    constructor Create(TCPClient: TIdTCPClient); reintroduce;
    destructor Destroy; override;
    property ResponseEvent: TResponseEvent read FResponseEvent
                                            write FResponseEvent;
end;

implementation

uses
  IdExceptionCore;

constructor TResponseListener.Create(TCPClient: TIdTCPClient);
begin
  Inherited Create(True);                   // �� ��������� ����� ����� ��������
  Self.TCPClient := TCPClient;
  Self.Priority := tpLower;                 // ��� ���� � �������
  Self.Resume;
  //Self.Start;                               // ��������� �����
end;

destructor TResponseListener.Destroy;
begin
  Self.Terminate;
  Inherited;
end;

/// <summary>
///   ������������ ����� ��� ��������� ������ �������
///   � ���������� ��������������� �������
/// </summary>
procedure TResponseListener.Execute;
var
  strResponse: String;
begin
  while not Terminated do
    if (TCPClient <> nil) and TCPClient.Connected then
    begin
      try
        strResponse := TCPClient.Socket.ReadLn;  // ����� ���������, ���� ��
                                                 // ����� �� ����� ������
        if (strResponse <> '') then
        begin
          FResponse := strResponse;              // ��������� ��������� �����
          Synchronize(DoResponseEvent);          // �������� � ������������ ������
        end;
      except
        on E: EidNotConnected do;                // TCPClient �������������
                                                 // �� �������, ������ �� ������
      end;
    end;
end;

/// <summary>
///   ���������� � ������������ ������ � ���������� �������
/// </summary>
procedure TResponseListener.DoResponseEvent;
begin
  ResponseEvent(FResponse);            // ��������� ����������,
                                       // ��� ������ ����� �������
end;
end.
