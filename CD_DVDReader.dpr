program CD_DVDReader;

uses
  Vcl.Forms,
  u_main in 'u_main.pas' {Form1},
  u_drive_utils in 'u_drive_utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
