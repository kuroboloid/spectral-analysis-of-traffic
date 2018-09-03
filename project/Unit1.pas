unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj, sDialogs, StdCtrls, sButton, sSkinManager, Grids, sGauge, Math,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls, sPageControl,
  sLabel, sCheckBox, sGroupBox, sEdit, Buttons, sSpeedButton, sBitBtn,
  Menus, sMemo;

type
  TForm1 = class(TForm)
    sSkinManager1: TsSkinManager;
    sButton1: TsButton;
    sOpenDialog1: TsOpenDialog;
    sGauge1: TsGauge;
    sPageControl1: TsPageControl;
    sLabel1: TsLabel;
    sGauge2: TsGauge;
    sGauge3: TsGauge;
    sCB: TsCheckBox;
    SGt: TStringGrid;
    waveCH: TChart;
    waveSeries1: TLineSeries;
    sPageControl3: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sGroupBox1: TsGroupBox;
    sGroupBox2: TsGroupBox;
    imin: TsEdit;
    nkSG: TStringGrid;
    sLabel2: TsLabel;
    imax: TsEdit;
    sEdit1: TsEdit;
    sGroupBox3: TsGroupBox;
    sEdit2: TsEdit;
    sSpeedButton1: TsSpeedButton;
    sButton3: TsButton;
    sButton4: TsButton;
    sButton2: TsButton;
    sButton6: TsButton;
    sPageControl4: TsPageControl;
    sTabSheet3: TsTabSheet;
    Chart3: TChart;
    corSeries1: TLineSeries;
    sButton7: TsButton;
    SGcor: TStringGrid;
    MainMenu1: TMainMenu;
    A1: TMenuItem;
    SGw: TStringGrid;
    sCheckBox1: TsCheckBox;
    sCheckBox2: TsCheckBox;
    sSpeedButton2: TsSpeedButton;
    c1: TsEdit;
    c2: TsEdit;
    c3: TsEdit;
    c4: TsEdit;
    sSpeedButton3: TsSpeedButton;
    sGroupBox4: TsGroupBox;
    sWebLabel1: TsWebLabel;
    sTabSheet4: TsTabSheet;
    sMemo1: TsMemo;
    SGres: TStringGrid;
    sLabel3: TsLabel;
    GBwave: TsGroupBox;
    sWebLabel3: TsWebLabel;
    sLabel4: TsLabel;
    sWebLabel2: TsWebLabel;
    N4: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    sSaveDialog1: TsSaveDialog;
    procedure sButton1Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton7Click(Sender: TObject);
    procedure c1Change(Sender: TObject);
    procedure c2Change(Sender: TObject);
    procedure c3Change(Sender: TObject);
    procedure c1KeyPress(Sender: TObject; var Key: Char);
    procedure c2KeyPress(Sender: TObject; var Key: Char);
    procedure c3KeyPress(Sender: TObject; var Key: Char);
    procedure c4KeyPress(Sender: TObject; var Key: Char);
    procedure imaxKeyPress(Sender: TObject; var Key: Char);
    procedure sEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure c4Change(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sWebLabel1Click(Sender: TObject);
    procedure sButton8Click(Sender: TObject);
    procedure sWebLabel2Click(Sender: TObject);
    procedure sWebLabel3Click(Sender: TObject);
    procedure sButton6Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Im, Re:real;
  aIm, aRe: array [0..127] of Real;
  SGtraf, SGf, SG: TStringGrid;
  tab1, tab2, tab3, tab4, gtab: TsTabSheet;
  Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Chart2: TChart;
    LineSeries1: TLineSeries;
    LineSeries2: TLineSeries;
    sPageControl2: TsPageControl;
    num, d, bi1, bi2, li, loadwave, numw, loaderr, fs: Integer;
implementation
 uses Unit2, Unit3, Unit4;
{$R *.dfm}
                                      
procedure Xls_Open(XLSFile:string; Grid:TStringGrid);
 const
  xlCellTypeLastCell = $0000000B;
var
  ExlApp, Sheet: OLEVariant;
  i, j, r, c:integer;
begin
  ExlApp := CreateOleObject('Excel.Application');
    ExlApp.Visible := false;     //делаем окно Excel невидимым
    ExlApp.Workbooks.Open(XLSFile);
  //создаем объект Sheet(страница) и указываем номер листа (1)
  //в книге, с которого будем осуществлять чтение
  Sheet := ExlApp.Workbooks[ExtractFileName(XLSFile)].WorkSheets[1];
    //активируем последнюю ячейку на листе
  Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    r := ExlApp.ActiveCell.Row;    // Возвращает номер последней строки
    if loadwave=1 then r:=33;
    if Form1.sCB.Checked=true then c:=2
    else 
    c := ExlApp.ActiveCell.Column;  // Возвращает номер последнего столбца

    Form1.sGauge1.MaxValue:=r;
   //устанавливаем кол-во столбцов и строк в StringGrid
    Grid.RowCount:=r;
    Grid.ColCount:=c;
 //считываем значение из каждой ячейки
     for j:= 1 to r do begin
       for i:= 1 to c do
         Grid.Cells[i-1,j-1]:= sheet.cells[j,i];
         Form1.sGauge1.Progress:=j;
       end;
 //закрываем приложение Excel
 ExlApp.Quit;
  //очищаем выделенную память
 ExlApp := Unassigned;
 Sheet := Unassigned;
end;

procedure Xls_Save(XLSFile:string; Grid:TStringGrid);
const
       xlExcel9795 = $0000002B;
       xlExcel8 = 56;
var
  ExlApp, Sheet: OLEVariant;
  i, j, r, c:integer;
begin
   ExlApp := CreateOleObject('Excel.Application');
  ExlApp.Visible := false;
    //создаем книгу для экспорта
  ExlApp.Workbooks.Add;
  Sheet := ExlApp.Workbooks[1].WorkSheets[1];
  Sheet.name:='Данные_из_Delphi';
    //считываем кол-во столбцов и строк в StringGrid
    r:=Grid.RowCount;
    c:=Grid.ColCount;
     for j:= 1 to r do
       for i:= 1 to c do
         sheet.cells[j,i]:=Grid.Cells[i-1,j-1];
ExlApp.DisplayAlerts := False;       //отключаем все предупреждения Excel
ExlApp.Workbooks[1].saveas(XLSFile);
 ExlApp.Quit;
 ExlApp := Unassigned;
 Sheet := Unassigned;
 end;


procedure LoadST();
var F: File of byte;
begin
with Form1 do begin
If sOpenDialog1.Execute then begin
AssignFile(F, sOpenDialog1.FileName);
Reset(F);
if (FileSize(F) div 1024)>3000 then 
ShowMessage('Размер файла слишком большой!'+#10#13+ 'Загрузка может занять несколько минут.');
CloseFile(F);
sGauge1.Progress:=0;  sGauge2.Progress:=0; sGauge3.Progress:=0;
gtab:=TsTabSheet.Create(Form1);        //создание новой вкладки
    gtab.PageControl:= Form1.sPageControl1;
    gtab.Caption:='Данные трафика #' + IntToStr(num);
    inc(num);
    sPageControl2:= TsPageControl.Create(Form1);
    sPageControl2.Parent:=gtab;
    sPageControl2.Width:=590; sPageControl2.Height:=600;
    sPageControl2.TabPosition:= tpLeft;
    sPageControl2.Font.Name:='MS Sans Serif';
    tab1:=TsTabSheet.Create(Form1);        //создание новой вкладки   (графики)
    tab1.TabVisible:=false;
    tab1.PageControl:= sPageControl2;
    tab1.Caption:='Диаграммы';
    tab2:=TsTabSheet.Create(Form1);        //создание новой вкладки (ст)
    tab2.TabVisible:=false;
    tab2.PageControl:= sPageControl2;
    tab2.Caption:='Сетевой трафик';
    tab3:=TsTabSheet.Create(Form1);        //создание новой вкладки  (интенсивность)
    tab3.TabVisible:=false;
    tab3.PageControl:= sPageControl2;
    tab3.Caption:='Интенсивность';
    tab4:=TsTabSheet.Create(Form1);        //создание новой вкладки  (фурье)
    tab4.TabVisible:=false;
    tab4.PageControl:= sPageControl2;
    tab4.Caption:='Преобразование Фурье';
      SGtraf:= TStringGrid.Create(Form1);       // создание таблиц
      //SGtraf.Visible:=false;
      SGtraf.Parent:=tab2;
      SGtraf.Align:=alNone;
      SGtraf.Top:=9; SGtraf.Left:=8;
      SGtraf.Height:=600; SGtraf.Width:=400;
      SGtraf.RowCount:=2;
      SGtraf.ColCount:=2;
      SGtraf.BiDiMode:=bdRightToLeftReadingOnly;
      SGtraf.FixedCols:=1;
      SGtraf.FixedRows:=1;
      SGtraf.FixedColor:=$90EE90;
      SGtraf.Font.Color:=clBlack;
      Xls_Open (sOpenDialog1.FileName, SGtraf);
      tab2.TabVisible:=true;
      end
      else begin
      loaderr:=1; exit;
      end;
      //SGtraf.Visible:=true;
end;
end;





procedure FoundIntensity();
var i, j, max, summ, x, Mm, m:Integer;  y:Real;
begin
with Form1 do begin
      SG:= TStringGrid.Create(Form1);       // создание таблиц
      //SG.Visible:=false;
      SG.Parent:=tab3;
      SG.Align:=alNone;
      SG.RowCount:=2;
      SG.ColCount:=3;
      SG.BiDiMode:=bdRightToLeftReadingOnly;
      SG.FixedCols:=1;
      SG.FixedRows:=1;
      SG.FixedColor:=$90EE90;
      SG.Font.Color:=clBlack;
      SG.Top:=9; SG.Left:=8;
      SG.Height:=600; SG.Width:=250;
      SG.Cells[0,0]:='Время';
      SG.Cells[1,0]:='Интенсивность';
      SG.Cells[2,0]:='Тренд';
      SG.ColWidths[0]:=50;
      SG.ColWidths[1]:=110;
      //SG.Visible:=false;
       Chart1:= TChart.Create(Form1);       // создание графика
      //SG.Visible:=false;
      Chart1.Parent:=tab1;
      Chart1.Top:=8; Chart1.Left:=0;
      Chart1.Height:=280; Chart1.Width:=570;
      Chart1.Color:=clWhite;
    Series1:=TLineSeries.Create(Chart1);
    Series1.ParentChart:=Chart1;
    Series2:=TLineSeries.Create(Chart1);
    Series2.ParentChart:=Chart1;
    Chart1.View3D:=false;
    Chart1.Legend.Visible:=false;
    Chart1.Title.Visible:=true;
    Chart1.Title.Text.Add('Интенсивность сетевого трафика');
    Chart1.Title.Font.Color:=clBlack;
  DecimalSeparator := ',';
  max:=Round(StrToFloat(SGtraf.Cells[1,SGtraf.RowCount-1]));
  Mm:=1; m:=1;
  //////////
  while Mm<max do begin
  inc(m); Mm:=Round(Power(2,m));
  end;
  m:=m-1;
  Mm:=Round(Power(2,m));
  max:=Mm;
  SG.RowCount:=max+1;
  for i:=1 to max do begin
  SG.Cells[0,i]:=IntToStr(i);
  SG.Cells[1,i]:='0';
  end;
  sGauge2.MaxValue:=2*max-1;
   for j:=1 to max-1 do begin
     for i:=1 to SGtraf.RowCount-1 do begin
      x:= Floor(StrToFloat(SGtraf.Cells[1,i]));
      //SGtraf.Cells[2,i]:=IntToStr(x);
      if x=StrToInt(SG.Cells[0,j]) then
      SG.Cells[1,j]:= IntToStr(StrToInt(SG.Cells[1,j])+1);
      sGauge2.Progress:=j;
    end;
 end;
  for i:=1 to max do begin
    summ:=0;
    for j:=i to i+9 do  begin
    if TryStrToInt(SG.Cells[1,j],x) then
    summ:=summ+x
    else summ:=summ;
    end;
    SG.Cells[2,i]:=FloatToStr(summ/10);
    sGauge2.Progress:=sGauge2.Progress+i;
  end;
  for i:=1 to max do begin
  Series1.AddXY(i, StrToFloat(SG.Cells[1,i]), '', clBlack);
  Series2.AddXY(i, StrToFloat(SG.Cells[2,i]), '', clPurple);
  end;
end;
    tab1.TabVisible:=true;
    sPageControl2.ActivePage:=tab1;
    tab3.TabVisible:=true;
end;

procedure Create_BPFtable(M:integer);
begin
  with Form1 do begin
       SGf:= TStringGrid.Create(Form1);       // создание таблиц
      //SGf.Visible:=false;
      SGf.Parent:=tab4;
      SGf.Align:=alNone;
      SGf.RowCount:=2;
      SGf.ColCount:=2;
      SGf.BiDiMode:=bdRightToLeftReadingOnly;
      SGf.FixedCols:=1;
      SGf.FixedRows:=1;
      SGf.FixedColor:=$90EE90;
      SGf.Font.Color:=clBlack;
      SGf.Top:=9; SGf.Left:=8;
      SGf.Height:=600; SGf.Width:=250;
      SGf.Cells[0,0]:='# гармоники';
      SGf.Cells[1,0]:='Амплитуда спектра';
      SGf.ColWidths[0]:=100;
      SGf.ColWidths[1]:=150;
      SGf.RowCount:=M+1;
      Chart2:= TChart.Create(Form1);       // создание графика
      //SG.Visible:=false;
      Chart2.Parent:=tab1;
      Chart2.Top:=290; Chart2.Left:=0;
      Chart2.Height:=280; Chart2.Width:=570;
      Chart2.Color:=clWhite;
      Chart2.Legend.Visible:=false;
    LineSeries1:=TLineSeries.Create(Chart2);
    LineSeries1.ParentChart:=Chart2;
    Chart2.View3D:=false;
    Chart2.Title.Visible:=true;
    Chart2.Title.Text.Add('Спектр амплитуд сетевого трафика');
    Chart2.Title.Font.Color:=clBlack;
  end;
end;

procedure BPF(q:Char; N:Integer);
var i,j, M:Integer;  f , md:real;  //MN
begin
with Form1 do begin
//N:=256;
//M:=128;
//N:=SG.RowCount-1;
M:=N div 2;
if q='w' then M:=33;
if q='t' then Create_BPFtable(M); //f.RowCount:=M+1; 
DecimalSeparator := ',';
if q='t' then sGauge3.MaxValue:=M-1;
for i:=0 to M-1 do begin
Re := 0;  Im := 0; md:=0;
      for j := 0 to N-1 do begin
              if q='t' then f:= StrToFloat(SG.Cells[1,j+1]);
              if q='w' then  f:= StrToFloat(SGt.Cells[1,j+1]);
              Re := Re + cos((-1)*2*pi*(j*i/N))*f;
              Im := Im + sin((-1)*2*pi*(j*i/N))*f;
              md := sqrt( Re*Re + Im*Im )/N;
             if q='t' then begin
              SGf.Cells[0,i+1]:=IntToStr(i);
              SGf.Cells[1,i+1]:=FormatFloat('0.000000',md);
             end;
             if q='w' then begin
              SGw.Cells[0,i+1]:= IntToStr(i);
              SGw.Cells[1,i+1]:= FormatFloat('0.000',md);
             end;
          end;
            aRe[i]:=Re; aIm[i]:=Im;
          if q='t' then LineSeries1.AddXY(i, StrToFloat(SGf.Cells[1,i+1]), '', clGreen);
          if q='w' then waveSeries1.AddXY(i, StrToFloat(SGw.Cells[1,i+1]), '', clGreen);
          Re := 0;  Im := 0; md:=0;
          if q='t' then sGauge3.Progress:=i;
   end;
  end;
     
end;




procedure TForm1.sButton3Click(Sender: TObject);
begin
sEdit1.Enabled:=true;
sEdit2.Enabled:=true;
imin.Enabled:=true;
imax.Enabled:=true;
sSpeedButton1.Enabled:=true;
sSpeedButton3.Enabled:=true;
sGroupBox4.Enabled:=true;


end;

procedure TForm1.sButton1Click(Sender: TObject);
begin
  LoadST();
  if loaderr=1 then exit;
  FoundIntensity();
  BPF('t', SG.RowCount-1);
  tab4.TabVisible:=true;
  bi2:=1;
  if (bi1=1) and (bi2=1) then begin
  sButton7.Enabled:=true;
  N9.Enabled:=true;
  end;
  sCheckBox2.Checked:=true;
end;

procedure ShowGrid(SGv:TStringGrid);
var i,j:integer;
begin
  Form2.SGbox.RowCount:=SGv.RowCount;
   Form2.SGbox.ColCount:=SGv.ColCount;
   for i:=0 to Form2.SGbox.RowCount-1 do begin
    for j:=0 to Form2.SGbox.ColCount-1 do begin
    Form2.SGbox.Cells[j,i]:=SGv.Cells[j,i];
    end;
   end;
   Form2.Show;
end;

procedure Open_Wave();
var List:TStringList;
    S, chislo : string;
    i,j :Integer;
begin
with Form1 do begin
  loadwave:=1;
  List:=TStringList.Create;
  if sOpenDialog1.Execute=false  then exit
  else begin
  List.LoadFromFile(sOpenDialog1.FileName);
  for i:=0 to 3 do begin
  S:=List[i];
  j:=1; chislo:='';
  while S[j]<>' ' do begin chislo:=chislo+S[j]; inc(j); end;
  nkSG.Cells[0,i+1]:=chislo;
  j:=j+3; chislo:='';
  while S[j]<>' ' do begin chislo:=chislo+S[j]; inc(j); end;
  nkSG.Cells[1,i+1]:=chislo;
  j:=j+3; chislo:='';
  while j<>Length(S)+1 do begin chislo:=chislo+S[j]; inc(j); end;
  nkSG.Cells[2,i+1]:=chislo;
  end;

  for i:=4 to 35 do begin
  S:=List[i];
  j:=1; chislo:='';
  while S[j]<>' ' do begin chislo:=chislo+S[j]; inc(j); end;
  SGw.Cells[0,i-3]:=chislo;
  j:=j+2; chislo:='';
  while j<>Length(S) do begin chislo:=chislo+S[j]; inc(j); end;
  SGw.Cells[1,i-3]:=chislo;
  end;
  loadwave:=0;
  //DecimalSeparator := ',';
  waveSeries1.Clear;
  for i:=1 to 32 do waveSeries1.AddXY(i, StrToFloat(SGw.Cells[1,i]), '', clGreen);
  sWebLabel3.Visible:=true;
  bi1:=1;
if (bi1=1) and (bi2=1) then begin
sButton7.Enabled:=true;
N9.Enabled:=true;
end;
sCheckBox1.Checked:=true;
end;
end;
end;

procedure Save_Wave();
var List:TStringList;
    S, chislo : string;
    i,j :Integer;
begin
with Form1 do begin
   List:=TStringList.Create;
   //List.Count:=32;
   for i:=1 to 4 do  List.Add(nkSG.Cells[0,i]+'   '+nkSG.Cells[1,i]+'   '+nkSG.Cells[2,i]);
   for i:=5 to 36 do    List.Add(SGw.Cells[0,i-4]+'   '+SGw.Cells[1,i-4]);
   sSaveDialog1.FileName:='wave'+IntToStr(numw);
   If sSaveDialog1.Execute then
   List.SaveToFile(sSaveDialog1.FileName+'.ws');
   inc(numw);
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var w, h, m: integer;
begin
num:=1; d:=1;  bi1:=0; bi2:=0; li:=0; loadwave:=0; numw:=1; loaderr:=0;
sCB.Hint:= 'Будут загружены только значимые данные сетевого трафика.' + #13#10 +
'Для загрузки полных данных сетевого трафика уберите галочку с данной панели.' + #13#10 + #13#10 +
'ПРЕДУПРЕЖДЕНИЕ: загрузка полных данных сетевого трафика может занять большее количество времени!';
sLabel3.Hint:='Nk - порядковый номер гармоники' + #13#10 +
'T - период составляющей сигнала атаки' +#13#10 +
'I - интесивность составляющей сигнала атаки'  ;
sLabel3.Font.Color:=$90EE90 ;
nkSG.FixedColor:=$90EE90 ;
SGcor.FixedColor:=$90EE90 ;
SGres.FixedColor:=$90EE90 ;
SGw.FixedColor:=$90EE90 ;
nkSG.Cells[0,0]:='Nk';
nkSG.Cells[1,0]:='T';
nkSG.Cells[2,0]:='I';
nkSG.Cells[0,1]:='4';
nkSG.Cells[0,2]:='8';
nkSG.Cells[0,3]:='16';
nkSG.Cells[0,4]:='32';

SGw.Cells[0,0]:='#';
SGw.Cells[1,0]:='wave';

SGcor.Cells[0,0]:='#';
SGcor.Cells[1,0]:='R';

SGres.Cells[0,0]:='#';
SGres.Cells[1,0]:='R';
{
w:= Floor(Screen.Width/1366);
h:=Floor(Screen.Height/664);
if w>h then m:=h else m:=w;
m:=m*100;
//ShowMessage(IntToStr(Screen.Width));
//ShowMessage(IntToStr(Screen.Height));
ChangeScale(m,100); }
end;

procedure Create_Wave();
var i,j,h,l, Nk, Tob, maxi:integer;  max, u3r:real;
T, A: array of Integer;
wave: array of Real;
M, N, Nmax:Integer;  f , md ,q:real;
cod:string;
begin
with Form1 do begin
Nk:=nkSG.RowCount-1;
Tob:=StrToInt(sEdit2.Text);
SetLength(T, Nk+1);
SetLength(A, Nk+1);
for i:=1 to Nk do begin
T[i]:=StrToInt(nkSG.Cells[1,i]);
A[i]:=StrToInt(nkSG.Cells[2,i]);
end;
SetLength(wave,Tob);
for i:=0 to Tob-1  do wave[i]:=0;
for j:=1 to Nk  do begin
    for i:=1 to Tob do begin
   u3r:= A[j]*sin(6.28*(1/T[j])*(i-1));
   wave[i-1]:=wave[i-1]+u3r;
   end;
end;
SGt.RowCount:=Tob+1;
for i:=0 to Tob-1 do begin
SGt.Cells[0,i+1]:=IntToStr(i);
SGt.Cells[1,i+1]:=FloatToStr(wave[i]);
end;
waveSeries1.Clear;
N:=Tob;
BPF('w',N);
{M:=Tob div 2;
max:=0; maxi:=0;
waveSeries1.Clear;
for i:=0 to M-1 do begin
Re := 0;  Im := 0; md:=0;
      for j := 0 to N-1 do begin
              f:= StrToFloat(SGt.Cells[1,j+1]);
              Re := Re + cos((-1)*2*pi*(j*i/N))*f;
              Im := Im + sin((-1)*2*pi*(j*i/N))*f;
              md := sqrt( Re*Re + Im*Im )/N;
              SGt.Cells[2,i+1]:=FormatFloat('0.000000',md);
          end;
            aRe[i]:=Re; aIm[i]:=Im;
          Re := 0;  Im := 0; md:=0;
          end;
          Nmax:= StrToInt(nkSG.Cells[0,nkSG.RowCount-1]);
          SGw.RowCount:=Nmax+2;
          for i:=1 to Nmax+1 do begin
           SGw.Cells[0,i]:= IntToStr(i-1);
          SGw.Cells[1,i]:= SGt.Cells[2,i];
          if StrToFloat(SGw.Cells[1,i])>max  then begin
          max:=StrToFloat(SGw.Cells[1,i]); maxi:=i-1;
          end;
          waveSeries1.AddXY(i-1, StrToFloat(SGt.Cells[2,i]), '', clGreen);
          end;
     }
max:=0; maxi:=0;
for i:=1 to 32 do begin
   if StrToFloat(SGw.Cells[1,i])>max  then begin
          max:=StrToFloat(SGw.Cells[1,i]); maxi:=i-1;
   end;
end;
    if maxi=4 then cod:=c1.Text;
     if maxi=8 then cod:=c2.Text;
      if maxi= 16 then cod:=c3.Text;
       if maxi=32 then cod:=c4.Text;

    if cod='00' then waveCH.LeftAxis.Maximum:= 4*max ;
    if cod='01' then waveCH.LeftAxis.Maximum:= 2*max;
    if cod='10' then waveCH.LeftAxis.Maximum:= 4*(max/3);
    if cod='11' then waveCH.LeftAxis.Maximum:= max;
    end;
end;

procedure TForm1.sButton5Click(Sender: TObject);
begin
waveSeries1.Clear;
end;


procedure Create_nkSG;
var Nk, I1, I2, I, Tob, T, j: Integer;
code: array[1..4] of string;
begin
  with Form1 do begin
  if (c1.Text='') or  (c2.Text='') or (c3.Text='') or (c4.Text='') or
    (Length(c1.Text)<>2) or  (Length(c2.Text)<>2) or (Length(c3.Text)<>2)or (Length(c4.Text)<>2)
    then begin
    ShowMessage('Необходимо указать код инетенсивности вейвлета!');
    exit;
    end;
  if not TryStrToINT(imin.Text, I1) then exit;
  if not TryStrToINT(imax.Text, I2) then exit;
  if not TryStrToINT(sEdit2.Text, Tob) then exit;
  code[1]:=c1.Text;
  code[2]:=c2.Text;
  code[3]:=c3.Text;
  code[4]:=c4.Text;
   for j:=1 to 4 do begin
   Nk:=StrToInt(nkSG.Cells[0,j]);
  T:= Tob div Nk;
  I:=0;
  if code[j]='00' then I:=I1+((I2-I1) div 4);
  if code[j]='01' then I:=I1+((I2-I1) div 2);
  if code[j]='10' then I:=I1+(3*(I2-I1) div 4);
  if code[j]='11' then I:=I1+(4*(I2-I1) div 4);
  nkSG.Cells[1,j]:= IntToStr(T);
  nkSG.Cells[2,j]:= IntToSTR(I);
  end;
  end;
end;

procedure TForm1.sSpeedButton1Click(Sender: TObject);
begin
   Create_nkSG;
   sButton2.Enabled:=true;
end;

procedure TForm1.sButton2Click(Sender: TObject);
begin
Create_Wave();
sWebLabel3.Visible:=true;
bi1:=1;
if (bi1=1) and (bi2=1) then begin
sButton7.Enabled:=true;
N9.Enabled:=true;
end;
sCheckBox1.Checked:=true;
sButton6.Enabled:=true;
N6.Enabled:= true;
end;

procedure GetResult;
var i,j, n, maxi, l:integer;
max, bas, f1, f2:real;
gar: array of real;
begin
with Form1 do begin
n:= SGcor.RowCount-1;
SetLength(gar,n);
for i:=0 to n-1 do gar[i]:= StrToFloat(SGcor.Cells[1,i+1]);
for i:=0 to n-1 do begin
max:=gar[i]; maxi:=i;
  for j:=i to n-1 do begin;
    if gar[j]>max then begin
    bas:=gar[j];
    gar[j]:=max;
    gar[maxi]:=bas;
    max:=bas; //maxi:=j;
    end;
  end;
end;
SGres.RowCount:=n+1;
for i:=0 to n-1 do begin
  SGres.Cells[1,i+1]:=FloatToStr(gar[i]);
  for j:=0 to n-1 do begin
  if StrToFloat(SGres.Cells[1,i+1])=StrToFloat(SGcor.Cells[1,j+1]) then
  SGres.Cells[0,i+1]:=SGcor.Cells[0,j+1];
  end;
end;

sMemo1.Text:= 'Данный вейвлет сетевой атаки с наибольшей вероятностью соответсвует участку сетевого трафика' +
'на промежутке  '+SGres.Cells[0,1]+'...'+ IntToStr(StrToInt(SGres.Cells[0,1])+31)+'.'+#13#10+#13#10;

l:=StrToInt(SGres.Cells[0,1]);
 LineSeries2:=TLineSeries.Create(Chart2);
 LineSeries2.ParentChart:=Chart2;
 Chart2.Top:=290; Chart2.Left:=0;
 Chart2.Height:=280; Chart2.Width:=570;
 for i:=l to l+31 do
 LineSeries2.AddXY(i, StrToFloat(SGf.Cells[1,i+1]), '', clRed);

 f1:= 100*(l/StrToInt(sEdit2.Text));
 f2:= 100*((l+31)/StrToInt(sEdit2.Text));
 sMemo1.Text:=sMemo1.Text + 'Таким образом, необходимо обратить внимание на состояние сигнала сетевого трафика '+
 'в диапазоне '+FormatFloat('00.00',f1)+'...'+FormatFloat('00.00',f2) + 'мГц.';
end;
end;


procedure Correlation();
var i,j,wl, wt,k:integer;
x1, x2, x, y1, y2, y, r1, r2, r3, r4, r:real;
begin
  with Form1 do begin
    DecimalSeparator := ',';
    //l:=(SGt.RowCount-1) div 2;
    wl:=SGw.RowCount-1;
    wt:= SGf.RowCount-1;
    //wt:=wt-wl;
    SGcor.RowCount:=wt-wl;
    j:=1 ; k:=1;
    corSeries1.Clear;
    while j<wt do begin
    i:=1; j:=k;
    x:=0; y:=0;
    //while i<wl do begin
   // if StrToFloat(SGf.Cells[1,j])<1 then begin r:=StrToFloat(SGf.Cells[1,j])/10; inc(j); end
   // else begin
    for i:=1 to 32 do begin
    x:=x+StrToFloat(SGf.Cells[1,j]);
    inc(j);
    y:=y+StrToFloat(SGw.Cells[1,i]);
    end;
    x:=x/32; y:=y/32;
    j:=k;  r1:=0; r2:=0; r3:=0;
    for i:=1 to 32 do begin
    x1:= StrToFloat(SGf.Cells[1,j]);
    inc(j);
    y1:=StrToFloat(SGw.Cells[1,i]);
    r1:=r1+(x1-x)*(y1-y);
    r2:=r2+ Power((x1-x),2);
    r3:=r3+ Power((y1-y),2);
    end;
    r2:=sqrt(r2); r3:=sqrt(r3);
    {x1:=StrToFloat(SGf.Cells[1,j]);
    x2:=StrToFloat(SGf.Cells[1,j+1]);
    x:=(x1+x2)/2;
    y1:=StrToFloat(SGw.Cells[1,i]);
    y2:=StrToFloat(SGw.Cells[1,i+1]);
    y:=(y1+y2)/2;
    if (x1=x2) or (y1=y2) then r:=0
    else begin
    if (y1<0.05) and (y2<0.05) then r:=0
    else begin
    //r1:= (x1-x)*(x2-x)+(y1-y)*(y2-y);
    r1:=(x1*y1+x1*y2+x2*y1+x2*y2)/2 - (x*y);
    r2:= Power((x1),2)+Power((x2),2);
    r2:=sqrt(r2);
    r3:= Power((y1),2)+Power((y2),2);
    r3:=sqrt(r3); }
    r4:=r2*r3;
    r:= r1/r4;
    //end;
   // end;
    //r:= ((x1-x)*(x2-x)+(y1-y)*(y2-y)) / sqrt(Power((x1-x),2)+Power((x2-x),2))*sqrt(Power((y1-y),2)+Power((y2-y),2));
    if StrToFloat(SGf.Cells[1,k])<1 then r:=StrToFloat(SGf.Cells[1,k])/10;
    SGcor.Cells[0,k]:=IntToStr(k);
    SGcor.Cells[1,k]:= FormatFloat('0.0000',r);
    if r>0.7 then
    corSeries1.AddXY(k, StrToFloat(SGcor.Cells[1,k]), '', clRed)
    else
    corSeries1.AddXY(k, StrToFloat(SGcor.Cells[1,k]), '', clBlack);
    //inc(i); inc(j);
    if (j>wt) or (j=wt) then break;
    //end;
    inc(k);
    end;
end;
 GetResult();
 end;



procedure TForm1.sButton7Click(Sender: TObject);
begin
Correlation();
sTabSheet4.TabVisible:=true;
end;

procedure TForm1.c1Change(Sender: TObject);
begin
if (li<>1) and (Length(c1.Text)=2) then Form1.ActiveControl:=c2;
end;

procedure TForm1.c2Change(Sender: TObject);
begin
if (li<>1) and (Length(c2.Text)=2) then Form1.ActiveControl:=c3;
if (li<>1) and (Length(c2.Text)=0) then Form1.ActiveControl:=c1;
end;

procedure TForm1.c3Change(Sender: TObject);
begin
if (li<>1) and (Length(c3.Text)=2) then Form1.ActiveControl:=c4;
if (li<>1) and (Length(c3.Text)=0) then Form1.ActiveControl:=c2;
end;

procedure TForm1.c1KeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>#08) then  Key:=#0;

end;

procedure TForm1.c2KeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>#08) then  Key:=#0;
end;

procedure TForm1.c3KeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>#08) then  Key:=#0;
 end;

procedure TForm1.c4KeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>#08) then  Key:=#0;
end;

procedure TForm1.imaxKeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08) then
     Key:=#0;
end;

procedure TForm1.sEdit2KeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08)  then
     Key:=#0;
end;

procedure TForm1.sSpeedButton2Click(Sender: TObject);
var i:integer;
begin
c1.Text:=''; c2.Text:=''; c3.Text:=''; c4.Text:='';
  for i:=1 to 4 do begin
  nkSG.Cells[1,i]:='';
  nkSG.Cells[2,i]:='';
  end;
 waveSeries1.Clear;
 sWebLabel3.Visible:=false;
 sCheckBox1.Checked:=false;
end;

procedure TForm1.c4Change(Sender: TObject);
begin
 if (li<>1) and (Length(c4.Text)=0) then Form1.ActiveControl:=c3;
end;

procedure TForm1.sSpeedButton3Click(Sender: TObject);
begin
li:=1;
randomize;
c1.Text:=IntToStr(random(2))+IntToStr(random(2));
c2.Text:=IntToStr(random(2))+IntToStr(random(2));
c3.Text:=IntToStr(random(2))+IntToStr(random(2));
c4.Text:=IntToStr(random(2))+IntToStr(random(2));
li:=0;
end;

procedure TForm1.sWebLabel1Click(Sender: TObject);
begin
Form2.Show;
end;

procedure TForm1.sButton8Click(Sender: TObject);
var i,l:integer;
begin
 l:=StrToInt(SGres.Cells[0,1]);
 LineSeries2:=TLineSeries.Create(Chart2);
 LineSeries2.ParentChart:=Chart2;
 Chart2.Top:=290; Chart2.Left:=0;
 Chart2.Height:=280; Chart2.Width:=570;
 for i:=l to l+31 do
 LineSeries2.AddXY(i, StrToFloat(SGf.Cells[1,i+1]), '', clRed);
end;

procedure TForm1.sWebLabel2Click(Sender: TObject);
begin
GBwave.Visible:=false;
sWebLabel3.Visible:=true;
sWebLabel2.Visible:=false;
end;

procedure TForm1.sWebLabel3Click(Sender: TObject);
begin
GBwave.Visible:=true;
sWebLabel2.Visible:=true;
sWebLabel3.Visible:=false;
end;

procedure TForm1.sButton6Click(Sender: TObject);
begin
//If sSaveDialog1.Execute then Xls_Save(sSaveDialog1.FileName, SGw);
Save_Wave();
end;

procedure TForm1.sButton4Click(Sender: TObject);
begin
Open_Wave();
end;

procedure TForm1.N2Click(Sender: TObject);
begin
sButton1.Click;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
sButton4.Click;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
 sButton6.Click;
end;

procedure TForm1.N20Click(Sender: TObject);
begin
Form2.Show;
end;

procedure TForm1.N18Click(Sender: TObject);
begin
Form1.Close; Form2.Close;
end;

procedure TForm1.N16Click(Sender: TObject);
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + 'Инструкции\Руководство пользователя.doc';
    Word.Documents.Open(name, ReadOnly:=true);

end;

procedure TForm1.N17Click(Sender: TObject);
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + 'Инструкции\Руководство программиста.doc';
    Word.Documents.Open(name, ReadOnly:=true);

end;

procedure TForm1.N13Click(Sender: TObject);
begin
Form3.Show;
end;

end.
