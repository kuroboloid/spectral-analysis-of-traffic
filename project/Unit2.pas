unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids;

type
  TForm2 = class(TForm)
    SGbox: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var i, j, k, d:integer;
begin
  SGbox.FixedColor:= $90EE90;
  SGbox.Cells[0,0]:='#';
  SGbox.Cells[1,0]:='A1';
  SGbox.Cells[2,0]:='A2';
  SGbox.Cells[3,0]:='B1';
  SGbox.Cells[4,0]:='B2';
  SGbox.Cells[5,0]:='C1';
  SGbox.Cells[6,0]:='C2';
  SGbox.Cells[7,0]:='D1';
  SGbox.Cells[8,0]:='D2';
  d:=256;
  for i:=1 to 256 do  SGbox.Cells[0,i]:=IntToStr(i);
  for j:=1 to 8 do begin
  i:=1;
    while i<>257 do begin
    k:=1;
    while k<>(d div 2)+1 do begin
    SGbox.Cells[j,i]:='0';
    inc(k);
    inc(i)
    end;
    k:=1;
    while k<>(d div 2)+1 do begin
    SGbox.Cells[j,i]:='1';
    inc(k);
    inc(i);
    end;
    end;
    d:=d div 2;
  end;
end;

end.
