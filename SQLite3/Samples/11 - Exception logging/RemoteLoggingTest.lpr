program RemoteLoggingTest;

{$MODE Delphi}

uses
  {$I SynDprUses.inc} // use FastMM4 on older Delphi, or set FPC t, Interfaceshreads
  Interfaces,
  Forms,
  RemoteLogMain in 'RemoteLogMain.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
