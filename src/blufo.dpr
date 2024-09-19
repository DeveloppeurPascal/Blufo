/// <summary>
/// ***************************************************************************
///
/// Blufo
///
/// Copyright 2016-2024 Patrick Prémartin under AGPL 3.0 license.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
/// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
/// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
/// ***************************************************************************
///
/// Author(s) :
/// Patrick PREMARTIN
///
/// Site :
/// https://blufo.gamolf.fr/
///
/// Project site :
/// https://github.com/DeveloppeurPascal/Blufo
///
/// ***************************************************************************
/// File last update : 2024-09-19T21:30:56.000+02:00
/// Signature : 6a919bc315c7c701be54280f9226adaa55438036
/// ***************************************************************************
/// </summary>

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
