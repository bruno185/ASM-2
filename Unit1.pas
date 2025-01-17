unit Unit1;

{ Convertit une cha�ne en transformant les accentu�s en majuscule
  non accentu�s. Utilise l'assembleur int�gr�

  Modif : String ==> AnsiString
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
         { D�clarations priv�es }
  public
        { D�clarations publiques }
  end;


var
  Form1: TForm1;
  strTempo : ansistring;
  somevar: byte;
  start, stop, loop : longint;

implementation

{$R *.DFM}

procedure Convert (str2Convert : Ansistring);
var
   nLenStr : word;
begin
     nLenStr := length(str2Convert);
     asm
     push ebx   { sauve ebx et edi (pour Delphi) }
     push edi
     jmp @debut { au travail ! }
@table :
     {DB '�E�E�E�E�A�A�A�C�I�I�O�O�U�U�U�Y', 0,0 ancienne table}
     DB '�A�A�A�A�A�A�A�E�E�E�E�E�E�I�I�I�I�I�I�O�O�O�O�O�O�O�U�U�U�U�U�U�Y�Y�C�N�N�S�S',0,0
     {DB '�E',0,0}
@debut :
     //xor eax,eax
     mov ax, nLenStr
     //shl eax,1
     or ax,ax              { mise � jour du flag Z }
     jz @fin               { longueur nulle -> fin }
@loop_principale:          { sur les car. de la cha�ne � traiter }
     mov edi, OFFSET @table  { adr. de la table de corres. dans edi}
     mov ecx, str2Convert  { adr. de la cha�ne � conv. ds ecx }
     add cx, nLenStr       { on commence par la fin }
     dec ecx               { ajustement }
     mov al, byte [ecx]    { caract�re de la cha�ne ds AL }
@loop_compar:
     cmp al, byte [edi]    { Comparaison }
     jnz @car_accentue_suivant { c'est pas �a, suite de la table }
     mov bl, byte [edi + 1]{ bingo! : corection }
     mov byte [ecx], bl   { Correction }
     jmp @testfin         { fin de cha�ne atteinte ? }
@car_accentue_suivant:    { on passe � l'entr�e suivant de la table }
     inc edi
     inc edi              { 2 octets plus loin }
     mov bl, byte [edi]   { r�cup�re entr�e suiv. de la table }
     or bl,bl             { mise � jour du flag Z }
     jnz  @loop_compar    { on est en fin de table ?}
     mov edi, OFFSET @table   { oui : retour en d�but de table }

@testfin:
     dec nLenStr   { car. pr�c�dent }
     push ax
     mov ax, nLenStr
     mov somevar, al
     pop ax
     jnz @loop_principale { on n'a pas fini ! }
@fin:
     pop edi
     pop ebx              { r�tablissement de ebx/edi pour Delphi }
     end ;                { job's done ! }

end;

procedure TForm1.Button1Click(Sender: TObject);
var
   code : integer;
   savstrTempo : ansistring;
   i,k : longint;

begin
     loop := StrToInt(Edit2.Text);
     strTempo := AnsiString(Edit1.Text);
     start := gettickCount;
     for k := 1 to loop do Convert(strTempo);
     stop := gettickCount;
     Memo1.Lines.Add('Temps Assembleur = ' + IntToStr(stop-start));
     Edit1.Text := Uppercase(strTempo);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i,j,k : integer;
  s : string;
  ss : string;
  match : boolean;
begin
  s := '�A�A�A�A�A�A�A�E�E�E�E�E�E�I�I�I�I�I�I�O�O�O�O�O�O�O�U�U�U�U�U�U�Y�Y�C�N�N�S�S';
  ss := Edit1.Text;
  loop := StrToInt(Edit2.Text);
  start := gettickCount;
  for k := 1 to loop do
  begin
    for i := 1 to length(ss) do
    begin
      j := 1;
      repeat
          if ss[i] = s[j] then ss[i] := s[j+1];
          j := j +2;
      until (match) or (j>= length(s));
    end;
  end;
  stop := gettickCount;
  Memo1.Lines.Add('Temps Pascal = ' + IntToStr(stop-start));
  Edit1.Text := Uppercase(strTempo);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Edit1.Text := '���';
end;

end.
