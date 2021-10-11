unit Animage;
{
               Composant Image animée   PAR DEBIARS  Août 2007
}
interface

uses
  Windows, ExtCtrls, Controls, Classes, jpeg, SysUtils, Graphics, Forms,
  StdCtrls, Dialogs;

type
  TAnimage = class(TImage)
    private
      fNbima   : integer;           // nbre d'images
      fTempo   : Integer;           // temporisation
      fImaStrm : TMemoryStream;     // stocke les images
      fImaSize : integer;           // taille d'une image
      fActive  : boolean;           // Contrôle l'animation
      fBima    : TBitmap;
      procedure SetTempo(Valeur : Integer);
      procedure SetActive(Valeur : boolean);
    public
      constructor Create(AOwner:TComponent); override;
      destructor  Destroy; override;
      procedure ChargerGraphic(UneImage: TGraphic);
      procedure AfficheUneImage(Index : integer);
    published
      property  Tempo  : Integer read fTempo write SetTempo;
      property  Active : boolean read fActive write SetActive;
  end;

  procedure Register;
  
implementation

constructor TAnimage.Create(AOwner:TComponent);
begin
  inherited;
  fActive  := false;
  fImaStrm := TMemoryStream.Create;
  fImaSize := 0;
  fNbima   := 0;
  fBima := TBitmap.Create;
  self.AutoSize := true;
end;

destructor TAnimage.Destroy;
begin
  fImaStrm.Free;
  fBima.Free;
  Inherited;
end;

procedure TAnimage.SetTempo(Valeur : Integer);
begin
  fTempo := Valeur;
end;
     
procedure TAnimage.SetActive(Valeur : boolean);
var
  no : integer;
begin
  fActive := Valeur;
  while fActive do
    for no := 0 to fNbima-1 do
    begin
      if not fActive then exit;
      AfficheUneImage(no);
      Sleep(fTempo);
      Application.ProcessMessages;
    end;
end;

procedure TAnimage.ChargerGraphic(UneImage: TGraphic);
begin
  if fNbima = 0 then
  begin
    fBima.Height := UneImage.Height;
    fBima.Width  := UneImage.Width;
  end;
  fbima.Canvas.Draw(0,0,UneImage);
  fBima.SaveToStream(fImaStrm);
  if fNbima = 0 then
    fImaSize := fImaStrm.Size;
  inc(fNbima);
end;

procedure TAnimage.AfficheUneImage(Index : integer);
begin
  fImaStrm.Position := fImaSize * Index;  
  fBima.LoadFromStream(fImaStrm);
  self.Picture.Bitmap.Assign(fBima);
  self.Refresh;
end;

procedure Register;
begin
  RegisterComponents('Exemples', [TAnimage]);
end;

end.

