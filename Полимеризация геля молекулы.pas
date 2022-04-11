program growmolecule;
uses GraphABC;

const
  lengthx = 800;
  lengthy = 800;{Размер окна}
  l = 2; //Длина половины ребра квадрата
  
var
  point: array [1..800, 1..800] of integer;
  al, x, y, s, k: integer;
  Rs, Rt, Rmax, r: real;
  dx, dy, dx1, dy1: array [1..4] of integer;
   
  //Рисуем частицу около центра
procedure DrawCube(x, y: integer);

  begin
    Rectangle(x-l, y-l, x+l, y+l);
  end;
  
 begin
   setWindowsize(lengthy, lengthx);
   SetBrushColor(clBrown);
   
   //Координаты точки роста
   point[400, 400]:= 1;
   DrawCube (400, 400);
  
   //Массив сдвига блуждающей частицы
   dx[1] := -1;
   dx[2] := 0;
   dx[3] := 1;
   dx[4] := 0;
   dy[1] := 0;
   dy[2] := -1;
   dy[3] := 0;
   dy[4] := 1;
   
   //Массив проверки нахождения частицы с молекулой
   dx1[1] := -2*l;
   dx1[2] := 0;
   dx1[3] := 2*l;
   dx1[4] := 0;
   dy1[1] := 0;
   dy1[2] := -2*l;
   dy1[3] := 0;
   dy1[4] := 2*l;
   
   //Параметры радиусов прилипания
   Rmax:= 0;
   Rs := Rmax+20;
   Rt := Rmax+200;
   SetBrushColor(clBlack);
   
  
   while Rmax<((lengthx+1)/3)
   do begin
        al:= Random(360); // Угловая координата
        x:= round (Rs*cos(al))+400;//выбор новой частицы
        y:= round (Rs*sin(al))+400;
        r:= sqrt(sqr(x-400)+sqr(y-400));
        s:= 0;
        while (s=0) and (r<Rt) do
          begin
            k:= 1+Random (4);//Движение частицы
            x:= x+dx[k];
            y:= y+dy[k];
            r:= sqrt(sqr(x-400)+sqr(y-400));
            if r<Rs then begin
              for k := 1 to 4 do
               begin
                s:= s+point[x+dx1[k], y+dy1[k]];//Проверка наличия частиц кластера
               end;
               if s>0 then
               begin
                 point[x, y] := 1;
                DrawCube(x, y);
                 if r>Rmax then
                   begin
                     Rmax := r;// Находим новые параметры
                     Rs := Rmax+20;
                     Rt := Rmax+300;
                   end;
                end;
             end;
          end;
      end;
 end. 