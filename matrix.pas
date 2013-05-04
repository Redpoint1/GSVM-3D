unit matrix;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Grids, Dialogs, Math;

const
  sirka : integer = 300;
  vyska : integer = 200;
type

  TSimplePole = array of real;
  TPole = array of array of real;

  { TMatrix }

  TMatrix = class
    Pole: Tpole;
    constructor Create(x, y: integer);
    procedure prirad(m: TMatrix);
    procedure prirad(p: TSimplePole);
  end;

  TMatrixPole = array of TMatrix;
  { TVykreslovanie }

  TVykreslovanie = class
    kamera, light: TMatrix;
    Body: array of TMatrix;
    Polynomy: array of array of integer;
    constructor Create;
    procedure vykresli1(Obr: TCanvas; trans, view: TMatrix; culling, shading, wires : boolean);
    function scale(a: TMatrix; x, y, z: real): TMatrix;
    function nasobenie(a, b: TMatrix): TMatrix;
    function translate(a: TMatrix; x, y, z: real): TMatrix;
    function RotaciaX(a: TMatrix; stupnov: real): TMatrix;
    function RotaciaY(a: TMatrix; stupnov: real): TMatrix;
    function RotaciaZ(a: TMatrix; stupnov: real): TMatrix;
    function normalsurface(a: array of TMatrix; view: TMatrix): TMatrix;
    function middlepoint(view, lights: TMatrix): TMatrixPole;
    function dotproduct(normal, Camera: TMatrix): real;
    function normallize(a: TMatrix): TMatrix;
    function normalvectors(view: TMatrix): TMatrixPole;
    function vektor(a, b: TMatrix): TMatrix;
    procedure loadFromFile(s: string);
  end;

implementation

{ TVykreslovanie }

constructor TVykreslovanie.Create;
begin
  kamera := TMatrix.Create(1, 4);
  setlength(body, 0);
  setlength(polynomy, 0);
  kamera.pole[0][2] := 1;
  light := TMatrix.Create(1, 4);
  light.pole[0][0] := 0;
  light.pole[0][1] := 0;
  light.pole[0][2] := 500;
end;

procedure TVykreslovanie.vykresli1(Obr: TCanvas; trans, view: TMatrix; culling,
  shading, wires: boolean);
var
  pom, viewReport: TMatrix;
  i, j: integer;
  normals, middlepoints: array of TMatrix;
  vertex: array of TPoint;
  r, g, b: byte;
  skalar: real;
begin
  Obr.Pen.Style := psSolid;
  Obr.Pen.Color := clSilver;
  obr.line(0, vyska, obr.Width, vyska);
  obr.line(sirka, 0, sirka, obr.Height);
  Obr.Pen.Color := clBlack;

  viewReport := nasobenie(trans, view);
  normals := normalvectors(viewReport);
  middlepoints := middlepoint(viewReport, light);

  pom := TMatrix.Create(1, 4);
  for i := 0 to length(Polynomy) - 1 do
  begin
    if (not(culling) or (dotproduct(normals[i], kamera) >= 0)) then
    begin
      setlength(vertex, length(polynomy[i]));
      for j := 0 to length(vertex) - 1 do
      begin
        pom := nasobenie(body[Polynomy[i][j] - 1], viewReport);
        vertex[j].X := round(pom.pole[0][0]) + sirka;
        vertex[j].Y := -round(pom.pole[0][1]) + vyska;
      end;
      Obr.Brush.Color := clGray;
      skalar := dotproduct(normals[i], middlepoints[i]);
      if ((skalar > 0) and (shading)) then
      begin
        r := round(red(Obr.Brush.Color) * skalar);
        g := round(green(Obr.Brush.Color) * skalar);
        b := round(blue(Obr.Brush.Color) * skalar);
        Obr.Brush.Color := RGBToColor(r, g, b);
      end
      else if shading then
        Obr.Brush.Color := clBlack;
      //Obr.Brush.Style := bsClear;
      if wires then
        Obr.Pen.Style := psSolid
      else
        Obr.Pen.Style := psClear;
      if culling then
        Obr.Brush.Style := bsSolid
      else
        Obr.Brush.Style := bsClear;
      Obr.Polygon(vertex);
    end;
  end;
  Obr.Brush.Style := bsSolid;
  Obr.Brush.Color := clWhite;
end;

function TVykreslovanie.scale(a: TMatrix; x, y, z: real): TMatrix;
var
  pom: TMatrix;
  i: integer;
begin
  pom := TMatrix.Create(length(a.Pole), length(a.pole[high(a.pole)]));
  for i := 0 to length(pom.pole) - 1 do
    pom.pole[i][i] := 1;
  pom.Pole[0][0] := x;
  pom.Pole[1][1] := y;
  pom.Pole[2][2] := z;
  Result := nasobenie(a, pom);
end;

function TVykreslovanie.nasobenie(a, b: TMatrix): TMatrix;
var
  pom: TMatrix;
  i, j, k: integer;
  sum: real;
  policko: TSimplePole;
begin
  if (length(a.pole[high(a.pole)]) = length(b.pole)) then
  begin
    setlength(policko, 0);
    Pom := TMatrix.Create(length(a.pole), length(b.pole[high(b.pole)]));
    for i := 0 to length(a.pole) - 1 do
    begin
      for j := 0 to length(b.pole[high(b.pole)]) - 1 do
      begin
        sum := 0;
        for k := 0 to length(a.pole[high(a.pole)]) - 1 do
          Sum := Sum + a.pole[i][k] * b.pole[k][j];
        setlength(policko, length(policko) + 1);
        policko[i * length(a.pole) + j] := sum;
      end;
    end;
    Pom.prirad(policko);
    Result := Pom;
  end;
end;

function TVykreslovanie.translate(a: TMatrix; x, y, z: real): TMatrix;
var
  pom: TMatrix;
  i: integer;
begin
  pom := TMatrix.Create(4, 4);
  for i := 0 to length(pom.pole) - 1 do
    pom.pole[i][i] := 1;
  pom.pole[3, 0] := x;
  pom.pole[3, 1] := y;
  pom.pole[3, 2] := z;
  Result := nasobenie(a, pom);
end;

function TVykreslovanie.RotaciaZ(a: TMatrix; stupnov: real): TMatrix;
var
  pom: TMatrix;
  i: integer;
begin
  pom := TMatrix.Create(4, 4);
  for i := 0 to length(pom.pole) - 1 do
    pom.pole[i][i] := 1;
  pom.pole[0, 0] := cos(degtorad(stupnov));
  pom.pole[0, 1] := sin(degtorad(stupnov));
  pom.pole[1, 0] := -sin(degtorad(stupnov));
  pom.pole[1, 1] := cos(degtorad(stupnov));
  Result := nasobenie(a, pom);
end;

function TVykreslovanie.normalsurface(a: array of TMatrix; view: TMatrix): TMatrix;
var
  i: integer;
  pom, current, Next: TMatrix;
begin
  pom := TMatrix.Create(1, 4);
  pom.pole[0][3] := 1;
  for i := 0 to length(a) - 1 do
  begin
    current := nasobenie(a[i], view);
    Next := nasobenie(a[(i + 1) mod length(a)], view);
    pom.pole[0][0] := pom.pole[0][0] + ((current.pole[0][1] - Next.pole[0][1]) *
      (current.pole[0][2] + Next.pole[0][2]));
    pom.pole[0][1] := pom.pole[0][1] + ((current.pole[0][2] - Next.pole[0][2]) *
      (current.pole[0][0] + Next.pole[0][0]));
    pom.pole[0][2] := pom.pole[0][2] + ((current.pole[0][0] - Next.pole[0][0]) *
      (current.pole[0][1] + Next.pole[0][1]));
  end;
  Result := pom;
end;

function TVykreslovanie.middlepoint(view, lights: TMatrix): TMatrixPole;
var
  i, j: integer;
  normals: array of TMatrix;
  pom: TMatrix;
begin
  pom := TMatrix.Create(1, 4);
  pom.pole[0][3] := 1;
  for i := 0 to length(Polynomy) - 1 do
  begin
    pom.pole[0][0] := 0;
    pom.pole[0][1] := 0;
    pom.pole[0][2] := 0;
    for j := 0 to length(Polynomy[i]) - 1 do
    begin
      pom.pole[0][0] := pom.pole[0][0] + body[polynomy[i][j] - 1].pole[0][0];
      pom.pole[0][1] := pom.pole[0][1] + body[polynomy[i][j] - 1].pole[0][1];
      pom.pole[0][2] := pom.pole[0][2] + body[polynomy[i][j] - 1].pole[0][2];
    end;
    pom.pole[0][0] := pom.pole[0][0] / length(Polynomy[i]);
    pom.pole[0][1] := pom.pole[0][1] / length(Polynomy[i]);
    pom.pole[0][2] := pom.pole[0][2] / length(Polynomy[i]);
    setlength(normals, length(normals) + 1);
    pom := nasobenie(pom, view);
    normals[high(normals)] := normallize(vektor(lights, pom));
  end;
  Result := normals;
end;

function TVykreslovanie.dotproduct(normal, Camera: TMatrix): real;
var
  i: integer;
  sum: real;
begin
  sum := 0;
  for i := 0 to high(normal.pole[0]) - 1 do
    sum := sum + normal.pole[0][i] * camera.pole[0][i];
  Result := sum;
end;

function TVykreslovanie.normallize(a: TMatrix): TMatrix;
var
  dlzka: real;
  pom: TMatrix;
  i: integer;
begin
  pom := TMatrix.Create(1, 4);
  for i := 0 to length(a.pole[0]) - 1 do
    pom.pole[0][i] := a.pole[0][i];
  dlzka := sqrt((a.Pole[0][0] * a.Pole[0][0]) + (a.Pole[0][1] * a.Pole[0][1]) +
    (a.Pole[0][2] * a.Pole[0][2]));
  if dlzka = 0 then
    exit;
  pom.Pole[0][0] := a.pole[0][0] / dlzka;
  pom.Pole[0][1] := a.pole[0][1] / dlzka;
  pom.Pole[0][2] := a.pole[0][2] / dlzka;
  Result := pom;
end;

function TVykreslovanie.normalvectors(view: TMatrix): TMatrixPole;
var
  i, j: integer;
  normals, vertices: array of TMatrix;
begin
  for i := 0 to length(Polynomy) - 1 do
  begin
    setlength(vertices, length(Polynomy[i]));
    for j := 0 to length(Polynomy[i]) - 1 do
      vertices[j] := body[polynomy[i][j] - 1];
    setlength(normals, length(normals) + 1);
    normals[high(normals)] := normallize(normalsurface(vertices, view));
  end;
  Result := normals;
end;

function TVykreslovanie.vektor(a, b: TMatrix): TMatrix;
var
  pom: TMatrix;
begin
  pom := TMatrix.Create(1, 4);
  pom.pole[0][0] := a.pole[0][0] - b.pole[0][0];
  pom.pole[0][1] := a.pole[0][1] - b.pole[0][1];
  pom.pole[0][2] := a.pole[0][2] - b.pole[0][2];
  pom.pole[0][3] := 1;
  Result := pom;
end;

function TVykreslovanie.RotaciaY(a: TMatrix; stupnov: real): TMatrix;
var
  pom: TMatrix;
  i: integer;
begin
  pom := TMatrix.Create(4, 4);
  for i := 0 to length(pom.pole) - 1 do
    pom.pole[i][i] := 1;
  pom.pole[0, 0] := cos(degtorad(stupnov));
  pom.pole[0, 2] := -sin(degtorad(stupnov));
  pom.pole[2, 0] := sin(degtorad(stupnov));
  pom.pole[2, 2] := cos(degtorad(stupnov));
  Result := nasobenie(a, pom);
end;

function TVykreslovanie.RotaciaX(a: TMatrix; stupnov: real): TMatrix;
var
  pom: TMatrix;
  i: integer;
begin
  pom := TMatrix.Create(4, 4);
  for i := 0 to length(pom.pole) - 1 do
    pom.pole[i][i] := 1;
  pom.pole[1, 1] := cos(degtorad(stupnov));
  pom.pole[2, 1] := -sin(degtorad(stupnov));
  pom.pole[1, 2] := sin(degtorad(stupnov));
  pom.pole[2, 2] := cos(degtorad(stupnov));
  Result := nasobenie(a, pom);
end;

procedure TVykreslovanie.loadFromFile(S: string);
var
  T: TextFile;
  Text: string;
  pom: TStringList;
  i: integer;
begin
  AssignFile(T, S + '.obj');
  Reset(T);
  Pom := TStringList.Create;
  Pom.Delimiter := ' ';
  repeat
    readln(T, Text);
    if length(Text) > 0 then
    begin
      case Text[1] of
        'v':
        begin
          Pom.DelimitedText := Text;
          setlength(Body, length(Body) + 1);
          Body[high(Body)] := TMatrix.Create(1, 4);
          Body[high(Body)].Pole[0][0] :=
            StrToFloat(StringReplace(pom[1], '.', ',',
            [rfReplaceAll, rfIgnoreCase]));
          Body[high(Body)].Pole[0][1] :=
            StrToFloat(StringReplace(pom[2], '.', ',',
            [rfReplaceAll, rfIgnoreCase]));
          Body[high(Body)].Pole[0][2] :=
            StrToFloat(StringReplace(pom[3], '.', ',',
            [rfReplaceAll, rfIgnoreCase]));
          Body[high(Body)].Pole[0][3] := 1;
          Pom.Clear;
        end;
        'f':
        begin
          Pom.DelimitedText := Text;
          setlength(Polynomy, length(Polynomy) + 1);
          setlength(Polynomy[high(Polynomy)], Pom.Count - 1);
          for i := 0 to Pom.Count - 2 do
            Polynomy[high(Polynomy)][i] := StrToInt(pom[i + 1]);
          Pom.Clear;
        end;
      end;
    end;
  until EOF(T);
  CloseFile(T);
end;

{ TMatrix }

constructor TMatrix.Create(x, y: integer);
var
  i: integer;
begin
  setlength(pole, x);
  for i := 0 to x - 1 do
  begin
    setlength(pole[i], y);
    if (x = y) then
      pole[i][i] := 1;
  end;
  pole[x - 1][y - 1] := 1;
end;

procedure TMatrix.prirad(m: TMatrix);
var
  x, y: integer;
begin
  for y := 0 to length(m.Pole) - 1 do
    for x := 0 to length(m.Pole[y]) - 1 do
      Pole[y][x] := m.Pole[y][x];
end;

procedure TMatrix.prirad(p: TSimplePole);
var
  x, y: integer;
begin
  if (length(p) = (length(pole) * length(pole[high(pole)]))) then
  begin
    for y := 0 to length(pole) - 1 do
      for x := 0 to length(pole[y]) - 1 do
        pole[y][x] := p[y * length(pole) + x];
  end;
end;

end.
