unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sButton;

type
  TForm4 = class(TForm)
    sButton1: TsButton;
    sButton2: TsButton;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation
uses Unit1;

{$R *.dfm}



procedure TForm4.sButton1Click(Sender: TObject);
begin
fs:=1;
Form4.Close;
end;

procedure TForm4.sButton2Click(Sender: TObject);
begin
fs:=0;
Form4.Close;
end;

end.
 