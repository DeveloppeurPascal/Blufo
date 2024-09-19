program blufo;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {frmMain},
  Gamolf.RTL.Scores in '..\lib-externes\Delphi-Game-Engine\src\Gamolf.RTL.Scores.pas',
  u_urlOpen in '..\lib-externes\librairies\src\u_urlOpen.pas',
  u_scores in '..\lib-externes\Delphi-Game-Engine\src\u_scores.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait, TFormOrientation.InvertedPortrait, TFormOrientation.Landscape, TFormOrientation.InvertedLandscape];
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
