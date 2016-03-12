program Cross;

uses
  Forms,
  uFormCross in 'uFormCross.pas' {formCross},
  uBaseObject in 'uBaseObject.pas',
  uCross in 'uCross.pas',
  uWireObject in 'uWireObject.pas',
  uLampObject in 'uLampObject.pas',
  uEducation in 'uEducation.pas',
  uFormMain in 'uFormMain.pas' {formMain},
  uFormNavigator in 'uFormNavigator.pas' {formNavigator},
  uFormConsole in 'uFormConsole.pas' {formConsole},
  uFormChat in 'uFormChat.pas' {formChat},
  uTCPClient in 'uTCPClient.pas',
  uFormServer in 'uFormServer.pas' {formConnectToServer},
  uResponseListener in 'uResponseListener.pas',
  uRequestDM in 'uRequestDM.pas',
  uKeyValueDM in 'uKeyValueDM.pas',
  uNetParamsList in 'uNetParamsList.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.HintPause := 0;
  Application.HintHidePause := High(Integer);
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
