unit zaklad;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Grids, StdCtrls, Menus, matrix;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ColorButton1: TColorButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
    procedure Edit3EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  view, BasicView, translate: TMatrix;
  z: integer;
  vykres: Tvykreslovanie;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button2Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.RotaciaX(translate, 5);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.translate(translate, -0.1, 0, 0);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.translate(translate, 0, -0.1, 0);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.translate(translate, 0, 0, -0.1);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.RotaciaX(translate, -5);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.RotaciaY(translate, -5);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.RotaciaZ(translate, -5);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.RotaciaY(translate, 5);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.RotaciaZ(translate, 5);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.translate(translate, 0.1, 0, 0);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.translate(translate, 0, 0.1, 0);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  translate := vykres.translate(translate, 0, 0, 0.1);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  view := vykres.Scale(view, 1.1, 1.1, 1.1);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  view := vykres.Scale(view, 0.9, 0.9, 0.9);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  Image1.Canvas.FillRect(Form1.Clientrect);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
begin
  if (checkbox2.Checked) then
  begin
    checkbox1.Enabled := True;
    checkbox3.Enabled := True;
  end
  else
  begin
    checkbox1.Checked := True;
    checkbox3.Checked := False;
    checkbox1.Enabled := False;
    checkbox3.Enabled := False;
  end;
  Image1.Canvas.FillRect(Form1.Clientrect);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.CheckBox3Change(Sender: TObject);
begin
  if checkbox3.Checked then
  begin
    checkbox1.Enabled := True;
  end
  else
  begin
    checkbox1.Checked := True;
    checkbox1.Enabled := False;
  end;
  Image1.Canvas.FillRect(Form1.Clientrect);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.ColorButton1ColorChanged(Sender: TObject);
begin
  Vykres.farba:= ColorButton1.ButtonColor;
   Image1.Canvas.FillRect(Form1.Clientrect);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Edit1EditingDone(Sender: TObject);
var
  cislo: real;
begin
  if TryStrToFloat(edit1.Text, cislo) then
    Vykres.light.Pole[0][0] := cislo*100
  else
  begin
    edit1.Text := '0';
    Vykres.light.Pole[0][0] := 0;
    ShowMessage('Neplatný real');
  end;
  Image1.Canvas.FillRect(Form1.Clientrect);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Edit2EditingDone(Sender: TObject);
var
  cislo: real;
begin
  if TryStrToFloat(edit2.Text, cislo) then
    Vykres.light.Pole[0][1] := cislo*100
  else
  begin
    edit2.Text := '0';
    Vykres.light.Pole[0][1] := 0;
    ShowMessage('Neplatný real');
  end;
  Image1.Canvas.FillRect(Form1.Clientrect);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.Edit3EditingDone(Sender: TObject);
var
  cislo: real;
begin
  if TryStrToFloat(edit3.Text, cislo) then
    Vykres.light.Pole[0][2] := cislo*100
  else
  begin
    edit3.Text := '10';
    Vykres.light.Pole[0][2] := 1000;
    ShowMessage('Neplatný real');
  end;
  Image1.Canvas.FillRect(Form1.Clientrect);
  vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
    CheckBox3.Checked, CheckBox1.Checked);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Vykres := TVykreslovanie.Create;
  BasicView := TMatrix.Create(4, 4);
  for i := 0 to length(BasicView.pole) - 1 do
    BasicView.pole[i][i] := 1;
  Image1.Canvas.FillRect(Form1.Clientrect);
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
var
  userstring: string;
begin
  if InputQuery('Zadajte názov súboru',
    'Zadajte názov súboru (*.obj, bez koncovky). Súbor musí byť v adresári s programom!',
    userstring) then
  begin
    if (fileexists(userstring + '.obj')) then
    begin
      GroupBox1.Enabled := True;
      Image1.Canvas.FillRect(Form1.Clientrect);
      if (Vykres <> nil) then
      begin
        FreeAndNil(Vykres);
        Vykres := TVykreslovanie.Create;
      end;
      vykres.loadFromFile(userstring);
      view := vykres.scale(BasicView, 100, 100, 100);
      translate := BasicView;
      vykres.farba:= ColorButton1.ButtonColor;
      vykres.light.pole[0][0] := StrToFloat(Edit1.Text)*100;
      vykres.light.pole[0][1] := StrToFloat(Edit2.Text)*100;
      vykres.light.pole[0][2] := StrToFloat(Edit3.Text)*100;
      Image1.Canvas.FillRect(Form1.Clientrect);
      vykres.vykresli1(Image1.Canvas, translate, view, CheckBox2.Checked,
        CheckBox3.Checked, CheckBox1.Checked);
    end
    else
      ShowMessage('Súbor neexistuje!');
  end;
end;

end.
