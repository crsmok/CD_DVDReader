unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  u_drive_utils;

procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenCD('G');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  CloseCD('G');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  x: integer;
begin
    x := DiskInDrive('g');
  case x of
    0: ShowMessage('Disk is there !');
    1: ShowMessage('Disk is empty !');
    2: ShowMessage('No disk in drive !');
  else
       ShowMessage('Disk not formatted !');
  end; //case
end;

end.
