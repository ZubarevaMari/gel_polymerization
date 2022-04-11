program grow;
uses GraphABC;

const
  lengthx = 600;
  lengthy = 600;{Размер окна}
  
var
  point: array [1..600, 1..600] of integer;
  al, x, y, s, k: integer;
  Rs, Rt, Rmax, r: real;
  dx, dy: array [1..4] of integer;
   
 begin
   setWindowsize(lengthy, lengthx);
   
   //Координаты центра роста
   point[300, 300]:= 1;
   SetPixel (300, 300, clBrown);
   
   //Массив сдвига блуждающей частицы
   dx[1] := -1;
   dx[2] := 0;
   dx[3] := 1;
   dx[4] := 0;
   dy[1] := 0;
   dy[2] := -1;
   dy[3] := 0;
   dy[4] := 1;
   
   //Параметры радиусов прилипания
   Rmax:= 0;
   Rs := Rmax+5;
   Rt := Rmax+100;
   SetBrushColor(clBlack);
   
   while Rmax<(lengthx/3)
   do begin
        al:= Random(360); // Угловая координата
        x:= round (Rs*cos(al))+300;//выбор новой частицы
        y:= round (Rs*sin(al))+300;
        r:= sqrt(sqr(x-300)+sqr(y-300));
        s:= 0;
        while (s=0) and (r<Rt) do
          begin
            k:= 1+Random (4);//Движение частицы
            x:= x+dx[k];
            y:= y+dy[k];
            r:= sqrt(sqr(x-300)+sqr(y-300));
            if r<Rs then begin
              for k := 1 to 4 do
               begin
                s:= s+point[x+dx[k], y+dy[k]];//Проверка наличия частиц кластера
               end;
               if s>0 then
               begin
                 point[x, y] := 1;
                 SetPixel(x, y, clBlack);
                 if r>Rmax then
                   begin
                     Rmax := r;// Находим новые параметры
                     Rs := Rmax+5;
                     Rt := Rmax+100;
                   end;
                end;
             end;
          end;
      end;
 end. 