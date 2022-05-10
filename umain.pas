unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, Process, LazFileUtils;

type

  { TFrmtrj }

  TFrmtrj = class(TForm)
    btnok: TButton;
    CbbSrv: TComboBox;
    Label1: TLabel;
    PB1: TProgressBar;
    Tm1: TTimer;
    procedure btnokClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Tm1Timer(Sender: TObject);
  private

  public

  end;

var
  Frmtrj: TFrmtrj;

implementation

{$R *.lfm}

{ TFrmtrj }

procedure TFrmtrj.btnokClick(Sender: TObject);
begin
   Cbbsrv.Enabled:=False;
   btnok.Enabled:=False;
   showMessage('El proceso puede durar unos minutos');
   Tm1.Enabled:=True;
end;

procedure TFrmtrj.FormActivate(Sender: TObject);
var
  p: TProcess;
  Ruta : utf8String;

begin
  Ruta := TrimFilename(ExtractFilePath(Application.ExeName) + PathDelim);
  writeln(Ruta + 'prasomlpr');
  p := TProcess.Create(nil);
  try
      p.ShowWindow := swoHIDE; // To hide your console app
      //p.ShowWindow := swoShowNormal; // To show your console app
      p.Options := [poWaitOnExit];
      p.Executable := Ruta + 'prasomlpr'; // Change to your app name
      p.Parameters.Add('-p');
      p.Parameters.Add('-l');
      p.Parameters.Add(Ruta);
      p.Execute;
      Writeln('Programm launched.');
  finally
      p.Free;
  end;
end;

procedure TFrmtrj.Tm1Timer(Sender: TObject);
begin
   writeln(PB1.Position);
   if PB1.Position <  PB1.Max then
   begin
      PB1.StepIt;
   end
   else
   begin
      showMessage('Error');
      showMessage('Se ha ejecutado en el escritorio?');
      Tm1.Enabled:=False;
   end;
end;

end.

