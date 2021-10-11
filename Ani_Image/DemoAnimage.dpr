program DemoAnimage;

uses
  Forms,
  Demo01 in 'Demo01.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
