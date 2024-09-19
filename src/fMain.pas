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
/// File last update : 2024-09-19T21:37:12.000+02:00
/// Signature : 604e69bc697dcc5d753cac016274a9f5ba511a97
/// ***************************************************************************
/// </summary>

unit fMain;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Styles.Objects,
  FMX.Layouts,
  FMX.Objects,
  FMX.Ani,
  FMX.Colors,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Edit,
  System.Generics.collections,
  FMX.Media;

type
  tsprite = class(TObject)
    x, y: single; // position de l'angle supérieur gauche du sprite
    x_sens, y_sens: single;
    // vecteurs pour calculer le mouvement du sprite à chaque boucle de jeu
    largeur, hauteur: single; // taille du sprite
    image: trectangle;
    x_accelerateur: integer;
  end;

  tjoueur = class(tsprite)
    score: cardinal;
    vies_restantes: cardinal;
    niveau: cardinal;
    num_ligne: integer;
  end;

  tmissile = class(tsprite)
    envoye: boolean; // true si chute en cours, false si tir possible
  end;

  tobstacle = class(tsprite)
    actif: boolean; // true si gênant, false si en cours d'explosion
    a_supprimer: boolean;
  end;

  tobstacles = tobjectlist<tobstacle>;

  TfrmMain = class(TForm)
    sol: trectangle;
    ecran_menu: TLayout;
    ecran_jeu: TLayout;
    ecran_halloffame: TLayout;
    ecran_credits: TLayout;
    ecran_findepartie: TLayout;
    titre_du_jeu: TText;
    FloatAnimation1: TFloatAnimation;
    btnPlay: TCornerButton;
    btnScores: TCornerButton;
    btnCredits: TCornerButton;
    btnRestore: TCornerButton;
    _divers: TLayout;
    ani_ancien_ecran: TFloatAnimation;
    ani_nouvel_ecran: TFloatAnimation;
    ani_premier_affichage: TFloatAnimation;
    btnRetourCredit: TCornerButton;
    btnRetourHalloffame: TCornerButton;
    texteHallOfFame: TText;
    titreHallOfFame: TText;
    liste_scores: TListView;
    titreCredits: TText;
    texteCredits: TText;
    logos_remerciements: TGridPanelLayout;
    memo_remerciements: TLabel;
    VertScrollBox1: TVertScrollBox;
    btnRetourFinDePartie: TCornerButton;
    texteFinDePartie: TText;
    titreFinDePartie: TText;
    logoGamolf: trectangle;
    GridPanelLayout1: TGridPanelLayout;
    lblGameOverScoreTitle: TLabel;
    lblGameOverScoreValue: TLabel;
    zone_saisie_pseudo: TLayout;
    edtGameOverPseudo: TEdit;
    btnGameOverPseudo: TCornerButton;
    imgJoueur: trectangle;
    FloatAnimation2: TFloatAnimation;
    imgMissileBleu: trectangle;
    imgMissileVert: trectangle;
    imgMissileRouge: trectangle;
    imgBloc1: trectangle;
    imgBloc2: trectangle;
    imgBloc3: trectangle;
    imgBloc4: trectangle;
    imgBloc5: trectangle;
    imgBloc6: trectangle;
    ani_explosion: TBitmapListAnimation;
    BoucleDeJeu: TTimer;
    imgExplosion: trectangle;
    logoBuildWithDelphi: trectangle;
    lblJeuViesRestantes: TLabel;
    lblJeuScore: TLabel;
    btnVitesseGauche: trectangle;
    btnVitesseDroite: trectangle;
    Rectangle1: trectangle;
    audioLoop6: TMediaPlayer;
    audioLoop6Check: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnScoresClick(Sender: TObject);
    procedure btnCreditsClick(Sender: TObject);
    procedure ani_ancien_ecranFinish(Sender: TObject);
    procedure btnRetourClick(Sender: TObject);
    procedure logoGamolfClick(Sender: TObject);
    procedure btnGameOverPseudoClick(Sender: TObject);
    procedure BoucleDeJeuTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure logoBuildWithDelphiClick(Sender: TObject);
    procedure btnVitesseGaucheClick(Sender: TObject);
    procedure btnVitesseDroiteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Rectangle1Click(Sender: TObject);
    procedure audioLoop6CheckTimer(Sender: TObject);
    procedure FormSaveState(Sender: TObject);
    procedure ecran_jeuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: single);
  private
    ecran_actuel, ecran_nouveau: TLayout;
    joueur: tjoueur;
    missile: tmissile;
    obstacles: tobstacles;
    jeu_en_cours: boolean;
    taux_reduction: single;
    audioLoop6Enabled: boolean;
    procedure glisse_vers_ecran(ecran: TLayout);
    procedure affiche_menu;
    procedure affiche_jeu(initialise_le_jeu: boolean = true);
    procedure affiche_halloffame;
    procedure affiche_credits;
    procedure affiche_findepartie;
    procedure lancer_missile;
    procedure mise_en_place_obstacles;
    procedure initialisation_niveau(niveau: cardinal);
    procedure initialise_joueur(niveau: cardinal);
    procedure exploser_bloc(obstacle: tobstacle);
    procedure change_nombre_de_vies(nouvelle_valeur: integer);
    procedure change_score(nouvelle_valeur: integer);
    procedure MettreEnPause;
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  u_urlOpen,
  System.Math,
  threading,
  System.DateUtils,
  System.IOUtils,
  u_Scores;

{ Tfond }

procedure TfrmMain.affiche_credits;
begin
  memo_remerciements.text := 'Blufo v1.2' + slinebreak + '(c) 2016-' +
    now.year.tostring + ' Patrick Prémartin' + slinebreak + slinebreak +
    'Sur une idée originelle d''on ne sait plus qui, le Blitz est un classique des jeux d''arcade.'
    + slinebreak + slinebreak +
    'Estimant que bombarder des immeubles n''est que trop d''actualité, cette version reprend le principe, mais change la donne... car rappelons le ici, bombarder des immeubles ou faire crasher des avions dedans, c''est mal !'
    + ' Ca ne se fait pas, ni en jeu, ni dans la vraie vie.' + slinebreak +
    slinebreak +
    'Ce jeu a été développé en août 2016 par Patrick Prémartin sous Delphi 10.1 Berlin avec Firemonkey et mis ensuite à jour en fonction des évolutions de Delphi et des contraintes technologiques liées aux différents systèmes d''exploitation.'
    + slinebreak + slinebreak +
    'Les images proviennent des packs d''assets pour jeux vidéos de Kenney. C''est l''idéal pour les développeurs de jeux n''ayant pas d''infographiste sous la main comme moi ;-)'
    + slinebreak + slinebreak + 'La musique de fond est de Ginny Culp.' +
    slinebreak + slinebreak +
    'Pour plus d''informations sur le jeu consultez le site' + slinebreak +
    ' https://blufo.gamolf.fr/' + slinebreak + slinebreak +
    'Amusez-vous bien et n''hésitez pas à en parler autour de vous ou nous transmettre vos remarques constructives.';
  glisse_vers_ecran(ecran_credits);
end;

procedure TfrmMain.affiche_findepartie;
begin
  lblJeuViesRestantes.Visible := false;
  lblJeuScore.Visible := false;
  lblGameOverScoreValue.text := joueur.score.tostring;
  edtGameOverPseudo.text := '';
  glisse_vers_ecran(ecran_findepartie);
end;

procedure TfrmMain.affiche_halloffame;
var
  ligne: TListViewItem;
  score: tscore;
  score_liste: tScoreListe;
begin
  liste_scores.BeginUpdate;
  liste_scores.Items.Clear;
  score_liste := score_liste_get;
  for score in score_liste do
  begin
    ligne := liste_scores.Items.Add;
    ligne.text := score.pseudo;
    ligne.Detail := score.points.tostring;
  end;
  liste_scores.EndUpdate;
  liste_scores.Transparent := true;
  glisse_vers_ecran(ecran_halloffame);
end;

procedure TfrmMain.affiche_jeu(initialise_le_jeu: boolean = true);
begin
  if (not assigned(joueur)) then
    joueur := tjoueur.Create;
  try
    if (not assigned(missile)) then
      missile := tmissile.Create;
    try
      if not assigned(obstacles) then
        obstacles := tobstacles.Create;
      try
        if initialise_le_jeu then
        begin
          // initialisation du joueur
          change_score(0);
          change_nombre_de_vies(3);
          joueur.niveau := 1;
          initialisation_niveau(joueur.niveau);
        end
        else
        begin
          // reprend le jeu où il en était
          // TODO : faire le retour de pause si ça vient d'un fichier de sauvegarde et non d'une partie en cours
          // change_score(0);
          // change_nombre_de_vies(3);
          // joueur.niveau := 1;
          // => initialisation_niveau(joueur.niveau);
        end;
      except
        obstacles.Free;
        raise;
      end;
    except
      missile.Free;
      raise;
    end;
  except
    joueur.Free;
    raise;
  end;
  jeu_en_cours := true;
  BoucleDeJeu.Enabled := true;
  lblJeuViesRestantes.Visible := true;
  lblJeuScore.Visible := true;
  glisse_vers_ecran(ecran_jeu);
end;

procedure TfrmMain.affiche_menu;
begin
  glisse_vers_ecran(ecran_menu);
end;

procedure TfrmMain.ani_ancien_ecranFinish(Sender: TObject);
begin
  ecran_actuel.Visible := false;
  ecran_actuel.Enabled := false;
  ecran_actuel := ecran_nouveau;
end;

procedure TfrmMain.audioLoop6CheckTimer(Sender: TObject);
begin
  // TODO : pouvoir mettre le musique en pause => la désactiver
  if audioLoop6Enabled then
    if (audioLoop6.State in [TMediaState.Stopped]) then
    begin
      audioLoop6.CurrentTime := 0;
      audioLoop6.play;
    end
    else if (audioLoop6.State in [TMediaState.Playing]) and
      (audioLoop6.CurrentTime >= audioLoop6.Duration) then
      audioLoop6.CurrentTime := 0;
end;

procedure TfrmMain.BoucleDeJeuTimer(Sender: TObject);
var
  obstacle: tobstacle;
  obstacle_rect, joueur_rect, missile_rect: trect;
  sens: integer;
begin
  if (jeu_en_cours) then
  begin
    // déplacement du joueur
    joueur.x := joueur.x + joueur.x_sens * taux_reduction +
      ifthen((joueur.x_sens >= 0), joueur.x_accelerateur,
      -joueur.x_accelerateur);
    joueur.y := joueur.y + joueur.y_sens * taux_reduction;
    if (joueur.y + joueur.hauteur > ecran_jeu.AbsoluteHeight) then
      joueur.y := ecran_jeu.AbsoluteHeight - joueur.hauteur;
    joueur.image.Position.x := joueur.x;
    joueur.image.Position.y := joueur.y;
    // ralentissement de la descente lorsqu'il y en a une
    if (joueur.y_sens > 0) then
      joueur.y_sens := joueur.y_sens - 1;
    // déclenchement de la descente lorsqu'on atteint les bords gauche et droite de l'écran
    if ((joueur.x < 1) and (joueur.x_sens < 0)) or
      ((joueur.x + joueur.largeur > ecran_jeu.AbsoluteWidth) and
      (joueur.x_sens > 0)) then
    begin
      inc(joueur.num_ligne);
      if (joueur.x_sens < 0) then
        sens := -1
      else
        sens := 1;
      joueur.x_sens := abs(joueur.x_sens + sens * joueur.num_ligne / 3);
      if joueur.x_sens > imgBloc1.AbsoluteWidth / 8 then
        joueur.x_sens := imgBloc1.AbsoluteWidth / 8;
      joueur.x_sens := -sens * joueur.x_sens;
      joueur.y_sens := joueur.num_ligne;
      if (joueur.y_sens < 8) then
        joueur.y_sens := 8;
    end;
    joueur_rect := rect(floor(joueur.x), floor(joueur.y),
      ceil(joueur.x + joueur.largeur - 1), ceil(joueur.y + joueur.hauteur - 1));
    // déplacement du missile
    if (missile.envoye) then
    begin
      missile.x := missile.x + missile.x_sens * taux_reduction;
      missile.y := missile.y + missile.y_sens * taux_reduction;
      missile.image.Position.x := missile.x;
      missile.image.Position.y := missile.y;
      // le missile est sorti de l'écran sur l'un des côtés  ou a touché le sol
      if (missile.x > ecran_jeu.AbsoluteWidth) or
        (missile.x + missile.largeur < 1) or
        (missile.y + missile.hauteur > ecran_jeu.AbsoluteHeight) then
      begin
        missile.envoye := false;
        missile.image.Visible := false;
      end;
      missile_rect := rect(floor(missile.x), floor(missile.y),
        ceil(missile.x + missile.largeur - 1),
        ceil(missile.y + missile.hauteur - 1));
    end;
    // tester les collisions avec le joueur et le missile s'il est lancé
    if (obstacles.Count < 1) then
    begin
      // plus d'obstacles, on passe au niveau suivant
      // TODO : à compléter par une animation de victoire
      change_score(joueur.score + 100 * joueur.niveau);
      initialisation_niveau(joueur.niveau + 1);
    end
    else
    begin
      for obstacle in obstacles do
      begin
        if obstacle.a_supprimer then
        begin
          obstacles.Remove(obstacle);
        end
        else if obstacle.actif then
        begin
          obstacle_rect := rect(floor(obstacle.x), floor(obstacle.y),
            ceil(obstacle.x + obstacle.largeur - 1),
            ceil(obstacle.y + obstacle.hauteur - 1));
          // collision avec le missile
          if (missile.envoye) and (IntersectRect(missile_rect, obstacle_rect))
          then
          begin
            exploser_bloc(obstacle);
          end;
          // collision avec le joueur
          if (IntersectRect(joueur_rect, obstacle_rect)) then
          begin
            if (joueur.vies_restantes > 1) then
            begin
              change_nombre_de_vies(joueur.vies_restantes - 1);
              exploser_bloc(obstacle);
              initialise_joueur(joueur.niveau);
            end
            else
            begin
              jeu_en_cours := false;
              BoucleDeJeu.Enabled := false;
              affiche_findepartie;
              exit;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.btnCreditsClick(Sender: TObject);
begin
  affiche_credits;
end;

procedure TfrmMain.btnGameOverPseudoClick(Sender: TObject);
begin
  edtGameOverPseudo.text := edtGameOverPseudo.text.Trim;
  if (edtGameOverPseudo.text.Length < 1) then
    ShowMessage('Veuillez saisir votre nom pour enregistrer ce score.')
  else
  begin
    score_add(edtGameOverPseudo.text, joueur.score, joueur.niveau);
    affiche_halloffame;
  end;
end;

procedure TfrmMain.btnPlayClick(Sender: TObject);
begin
  affiche_jeu;
end;

procedure TfrmMain.btnRestoreClick(Sender: TObject);
begin
  btnRestore.Visible := false;
  affiche_jeu(false);
end;

procedure TfrmMain.btnRetourClick(Sender: TObject);
begin
  affiche_menu;
end;

procedure TfrmMain.btnScoresClick(Sender: TObject);
begin
  affiche_halloffame;
end;

procedure TfrmMain.btnVitesseGaucheClick(Sender: TObject);
begin
  if (joueur.x_sens < 0) and (joueur.x_accelerateur < 10) then
    inc(joueur.x_accelerateur)
  else if (joueur.x_sens > 0) and (joueur.x_accelerateur > 0) then
    dec(joueur.x_accelerateur);
end;

procedure TfrmMain.btnVitesseDroiteClick(Sender: TObject);
begin
  if (joueur.x_sens > 0) and (joueur.x_accelerateur < 10) then
    inc(joueur.x_accelerateur)
  else if (joueur.x_sens < 0) and (joueur.x_accelerateur > 0) then
    dec(joueur.x_accelerateur);
end;

procedure TfrmMain.change_nombre_de_vies(nouvelle_valeur: integer);
begin
  joueur.vies_restantes := nouvelle_valeur;
  lblJeuViesRestantes.text := 'Vies restantes : ' +
    Format('%d', [joueur.vies_restantes]);
end;

procedure TfrmMain.change_score(nouvelle_valeur: integer);
begin
  joueur.score := nouvelle_valeur;
  lblJeuScore.text := 'Votre score : ' + Format('%d', [joueur.score]);
end;

procedure TfrmMain.ecran_jeuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: single);
begin
  if jeu_en_cours then
    lancer_missile;
end;

procedure TfrmMain.exploser_bloc(obstacle: tobstacle);
var
  anim: TBitmapListAnimation;
begin
  if (joueur.niveau < 1) then
    joueur.niveau := 1;
  change_score(joueur.score + joueur.niveau);
  obstacle.actif := false;
  anim := TBitmapListAnimation.Create(obstacle.image);
  anim.Parent := obstacle.image;
  anim.AnimationBitmap.Assign(imgExplosion.Fill.Bitmap.Bitmap);
  anim.AnimationCount := 9;
  anim.AnimationRowCount := 3;
  anim.Duration := 0.4;
  anim.Loop := false;
  anim.PropertyName := 'Fill.Bitmap.Bitmap';
  anim.Start;
  ttask.Run(
    procedure
    var
      i: integer;
    begin
      i := 0;
      repeat
        sleep(100);
        inc(i);
      until (i > 3) or (not anim.running);
      tthread.Queue(tthread.CurrentThread,
        procedure
        begin
          obstacle.image.Visible := false;
          obstacle.a_supprimer := true;
          anim.Free;
        end);
    end);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  taille_initiale, taille_apres_calcul: single;
  FichierAudioLoop6: string;
begin
  _divers.Visible := false;
  // initialisation du programme et des différents écrans
  ecran_menu.Visible := false;
  ecran_menu.Enabled := false;
  (* affichage, puis masquage de l'écran de jeu obligatoire pour qu'il calcule sa surface d'affichage. *)
  taille_initiale := ecran_jeu.AbsoluteHeight;
  ecran_jeu.Visible := true;
  ecran_jeu.Visible := false;
  taille_apres_calcul := ecran_jeu.AbsoluteHeight;
  if (taille_apres_calcul < taille_initiale) then
    taux_reduction := taille_apres_calcul / taille_initiale
  else
    taux_reduction := 1;
  imgJoueur.Scale.x := taux_reduction;
  imgJoueur.Scale.y := taux_reduction;
  imgMissileBleu.Scale.x := taux_reduction;
  imgMissileBleu.Scale.y := taux_reduction;
  imgMissileVert.Scale.x := taux_reduction;
  imgMissileVert.Scale.y := taux_reduction;
  imgMissileRouge.Scale.x := taux_reduction;
  imgMissileRouge.Scale.y := taux_reduction;
  imgBloc1.Scale.x := taux_reduction;
  imgBloc1.Scale.y := taux_reduction;
  imgBloc2.Scale.x := taux_reduction;
  imgBloc2.Scale.y := taux_reduction;
  imgBloc3.Scale.x := taux_reduction;
  imgBloc3.Scale.y := taux_reduction;
  imgBloc4.Scale.x := taux_reduction;
  imgBloc4.Scale.y := taux_reduction;
  imgBloc5.Scale.x := taux_reduction;
  imgBloc5.Scale.y := taux_reduction;
  imgBloc6.Scale.x := taux_reduction;
  imgBloc6.Scale.y := taux_reduction;
  imgExplosion.Scale.x := taux_reduction;
  imgExplosion.Scale.y := taux_reduction;
  (* l'écran de jeu et le placement des blocs dépend en effet de ce calcul initial (sinon la zone garde la taille définie dans l'EDI à la conception du programme) *)
  ecran_jeu.Enabled := false;
  ecran_halloffame.Visible := false;
  ecran_halloffame.Enabled := false;
  ecran_credits.Visible := false;
  ecran_credits.Enabled := false;
  ecran_findepartie.Visible := false;
  ecran_findepartie.Enabled := false;
  BoucleDeJeu.Enabled := false;
  jeu_en_cours := false;
  lblJeuViesRestantes.Visible := false;
  lblJeuScore.Visible := false;
  // lancement du jeu
  btnRestore.Visible := false;
  // TODO : activer btnRestore si une sauvegarde du jeu existe
  ecran_actuel := ecran_menu;
  affiche_menu;
  // initialisation boucle sonore
{$IF defined(ANDROID)}
  // deploy in .\assets\internal\
  FichierAudioLoop6 := tpath.GetDocumentsPath;
{$ELSEIF defined(MSWINDOWS)}
{$IFDEF DEBUG}
  FichierAudioLoop6 := '..\..\..\_PRIVATE\assets\music\GinnyCulp';
{$ELSE}
  // deploy in ;\
  FichierAudioLoop6 := extractfilepath(paramstr(0));
{$ENDIF}
{$ELSEIF defined(IOS)}
  // deploy in .\
  FichierAudioLoop6 := extractfilepath(paramstr(0));
{$ELSEIF defined(MACOS)}
  // deploy in Contents\MacOS
  FichierAudioLoop6 := extractfilepath(paramstr(0));
{$ELSEIF Defined(LINUX)}
  FichierAudioLoop6 := extractfilepath(paramstr(0));
{$ELSE}
{$MESSAGE FATAL 'OS non supporté'}
{$ENDIF}
  audioLoop6Enabled := false;
  FichierAudioLoop6 := tpath.combine(FichierAudioLoop6, 'Loop6.mp3');
  if tfile.Exists(FichierAudioLoop6) then
  begin
    try
      audioLoop6.FileName := FichierAudioLoop6;
      audioLoop6.play;
      audioLoop6Enabled := true;
      audioLoop6Check.Enabled := true;
    except

    end;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  jeu_en_cours := false;
  BoucleDeJeu.Enabled := false;
  joueur.Free;
  missile.Free;
  obstacles.Free;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
begin
  if jeu_en_cours then
  begin
    if (KeyChar = ' ') then
      lancer_missile
    else if (Key = vkLeft) then
    begin
      btnVitesseGauche.OnClick(Sender);
      Key := 0;
    end
    else if (Key = vkRight) then
    begin
      btnVitesseDroite.OnClick(Sender);
      Key := 0;
    end
    else if (Key in [vkEscape, vkHardwareBack]) then
    begin
      MettreEnPause;
      Key := 0;
    end;
  end
  else if ecran_actuel = ecran_credits then
  begin
    if (Key in [vkEscape, vkHardwareBack]) then
    begin
      btnRetourCredit.OnClick(Sender);
      Key := 0;
    end;
  end
  else if ecran_actuel = ecran_halloffame then
  begin
    if (Key in [vkEscape, vkHardwareBack]) then
    begin
      btnRetourHalloffame.OnClick(Sender);
      Key := 0;
    end;
  end
  else if ecran_actuel = ecran_findepartie then
  begin
    case Key of
      vkEscape, vkHardwareBack:
        begin
          btnRetourFinDePartie.OnClick(Sender);
          Key := 0;
        end;
      vkReturn:
        begin
          btnGameOverPseudo.OnClick(Sender);
          Key := 0;
        end;
    end;
  end
  else if ecran_actuel = ecran_menu then
  begin
    if (Key = vkEscape) then // vkHardwareBack géré par l'OS
    begin
      close;
      Key := 0;
    end;
  end;
end;

procedure TfrmMain.FormSaveState(Sender: TObject);
begin
  // TODO : mettre le jeu en pause s'il était actif et sauvegarder la partie en cours
end;

procedure TfrmMain.glisse_vers_ecran(ecran: TLayout);
begin
  if (ecran_actuel <> ecran) then
  begin
    ecran_nouveau := ecran;
    ecran_nouveau.Visible := true;
    ecran_nouveau.Enabled := true;
    ani_nouvel_ecran.Parent := ecran_nouveau;
    ani_nouvel_ecran.StartValue := ecran_actuel.AbsoluteWidth;
    ani_nouvel_ecran.StopValue := 0;
    ani_nouvel_ecran.Start;
    ani_ancien_ecran.Parent := ecran_actuel;
    ani_ancien_ecran.StartValue := 0;
    ani_ancien_ecran.StopValue := -ecran_actuel.AbsoluteWidth;
    ani_ancien_ecran.Start;
  end
  else if (not ecran.Visible) or (not ecran.Enabled) then
  begin
    ecran.Opacity := 0;
    ecran.Enabled := true;
    ecran.Visible := true;
    ani_premier_affichage.Start;
  end;
end;

procedure TfrmMain.initialisation_niveau(niveau: cardinal);
begin
  // paramètres du joueur liés à chaque écran de jeu
  initialise_joueur(niveau);
  // initialisation du missile
  missile.envoye := false;
  if assigned(missile.image) then
    missile.image.Visible := false;
  // dépôt des nouveaux obstacles
  mise_en_place_obstacles;
end;

procedure TfrmMain.initialise_joueur(niveau: cardinal);
begin
  joueur.x := 0;
  joueur.y := 0;
  joueur.x_accelerateur := 0;
  joueur.x_sens := niveau;
  if (joueur.x_sens > imgBloc1.AbsoluteWidth / 8) then
    joueur.x_sens := imgBloc1.AbsoluteWidth / 8;
  joueur.y_sens := 0;
  joueur.image := imgJoueur;
  joueur.image.Parent := ecran_jeu;
  joueur.image.Visible := true;
  joueur.image.Enabled := true;
  joueur.largeur := joueur.image.AbsoluteWidth;
  joueur.hauteur := joueur.image.AbsoluteHeight;
  joueur.num_ligne := 0;
  joueur.niveau := niveau;
end;

procedure TfrmMain.lancer_missile;
begin
  if (jeu_en_cours and assigned(missile) and (not missile.envoye)) then
  begin
    missile.x := joueur.x + ((joueur.largeur + missile.largeur) / 2);
    missile.x_sens := 0;
    missile.y := joueur.y + joueur.hauteur;
    // on lance le missile à la même vitesse que bouge le joueur
    missile.y_sens := abs(joueur.x_sens);
    if (missile.y_sens < 2) then
      missile.y_sens := 2;
    case (Random(3)) of
      0:
        missile.image := imgMissileBleu;
      1:
        missile.image := imgMissileRouge;
    else
      missile.image := imgMissileVert;
    end;
    missile.image.Parent := ecran_jeu;
    missile.image.Visible := true;
    missile.image.Enabled := true;
    missile.largeur := missile.image.AbsoluteWidth;
    missile.hauteur := missile.image.AbsoluteHeight;
    missile.envoye := true;
  end;
end;

procedure TfrmMain.logoBuildWithDelphiClick(Sender: TObject);
begin
  url_Open_In_Browser('https://vasur.fr/blufoembarcadero');
end;

procedure TfrmMain.logoGamolfClick(Sender: TObject);
begin
  url_Open_In_Browser('https://gamolf.fr');
end;

procedure TfrmMain.MettreEnPause;
begin
  jeu_en_cours := false;
  btnRestore.Visible := true;
  affiche_menu;
end;

procedure TfrmMain.mise_en_place_obstacles;
var
  i, j: integer;
  nb_blocs: integer;
  obstacle: tobstacle;
  hauteur_ecran, largeur_ecran: integer;
  largeur_bloc, hauteur_bloc: single;
  x_mini: single;
begin
  largeur_bloc := imgBloc1.AbsoluteWidth;
  hauteur_bloc := imgBloc1.AbsoluteHeight;
  // nb de blocs rengeables en largeur
  largeur_ecran := floor(ecran_jeu.AbsoluteWidth / largeur_bloc) - 1;
  // on retire un bloc pour ne pas rester bloqué sur un bord de l'écran
  x_mini := (ecran_jeu.AbsoluteWidth - largeur_ecran * largeur_bloc) / 2;
  // nb de blocs rangeables en hauteur
  hauteur_ecran := floor((ecran_jeu.AbsoluteHeight - imgJoueur.AbsoluteHeight -
    imgMissileBleu.AbsoluteHeight) / hauteur_bloc);
  // plaçage des blocs sur la largeur de l'écran, avec une hauteur aléatoire
  for i := 0 to largeur_ecran - 1 do
  begin
    nb_blocs := Random(hauteur_ecran);
    for j := 0 to nb_blocs - 1 do
    begin
      obstacle := tobstacle.Create;
      try
        obstacle.x := x_mini + i * largeur_bloc;
        obstacle.y := ecran_jeu.AbsoluteHeight - hauteur_bloc * (j + 1);
        obstacle.largeur := largeur_bloc;
        obstacle.hauteur := hauteur_bloc;
        case Random(8) of
          0:
            obstacle.image := imgBloc1.Clone(ecran_jeu) as trectangle;
          1:
            obstacle.image := imgBloc2.Clone(ecran_jeu) as trectangle;
          2:
            obstacle.image := imgBloc3.Clone(ecran_jeu) as trectangle;
          3:
            obstacle.image := imgBloc4.Clone(ecran_jeu) as trectangle;
          4:
            obstacle.image := imgBloc5.Clone(ecran_jeu) as trectangle;
        else
          obstacle.image := imgBloc6.Clone(ecran_jeu) as trectangle;
        end;
        obstacle.image.Position.x := obstacle.x;
        obstacle.image.Position.y := obstacle.y;
        obstacle.image.Parent := ecran_jeu;
        obstacle.image.Visible := true;
        obstacle.image.Enabled := true;
        obstacle.actif := true;
        obstacle.a_supprimer := false;
        obstacles.Add(obstacle);
      except
        obstacle.Free;
        raise;
      end;
    end;
  end;
  if (obstacles.Count < 1) then
    raise exception.Create
      ('Génération du terrain impossible. Votre écran est trop petit pour ce jeu.');
  btnVitesseGauche.BringToFront;
  btnVitesseDroite.BringToFront;
end;

procedure TfrmMain.Rectangle1Click(Sender: TObject);
begin
  MettreEnPause;
end;

initialization

score_init('Gamolf', 'Blufo');

{$IFDEF DEBUG}
reportmemoryleaksonshutdown := true;
{$ENDIF}

end.
