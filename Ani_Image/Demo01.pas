unit Demo01;

interface

uses
  Windows, SysUtils, Classes, ExtCtrls, ComCtrls, Forms, Controls, StdCtrls,
  Graphics, Dialogs, ImgList, Animage;

type
  TMainForm = class(TForm)
    BQuitter: TButton;
    Listima: TImageList;
    Bt_Deplacer: TButton;
    Animage1: TAnimage;
    procedure FormCreate(Sender: TObject);
    procedure Initialiser;
    procedure BQuitterClick(Sender: TObject);
    procedure Bt_DeplacerClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Animage1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

var
  dima: TBitmap;
  bdep: boolean;          // autorise le déplacement de l'image
  sns,                    // direction et vitesse de déplacement
  px: integer;            // position

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
  Randomize;
  dima := TBitmap.Create;
  bdep := false;
  sns := 3;
  px := 10;
  Initialiser;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  Animage1.Active := true;
end;

procedure TMainForm.Initialiser;
var
  index : Integer;
begin
  Animage1.Tempo  := 70;
  for index := 0 to 7 do
   begin
    Listima.GetBitmap(index,dima);
    Animage1.ChargerGraphic(dima);
   end;
end;

procedure TMainForm.BQuitterClick(Sender: TObject);
begin
  Close;
end;
 
procedure TMainForm.Animage1Click(Sender: TObject);
begin
  Animage1.Active := not Animage1.Active;
end;

procedure TMainForm.Bt_DeplacerClick(Sender: TObject);
var
  no : integer;
begin
  no := 0;
  if bdep
  then
   begin
    bdep := false;
    Bt_Deplacer.Caption := 'Move';
   end
  else
   begin
         bdep := true;
         Bt_Deplacer.Caption := 'Stop';
         while bdep do
          begin
           if (px+32 > ClientWidth-10)
           or (px < 10) then sns := -sns;
           px := px + sns;
           Animage1.Left := px;
           if Animage1.Active
           then Animage1.AfficheUneImage(no);
           sleep(50);
           inc(no);
           if no > 7
           then no := 0;
           Application.ProcessMessages;
          end;
   end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bdep:=false;
  if Animage1<>nil
  then Animage1.Active:=false;
  dima.Free;
  Animage1.Free;
end;

end.






