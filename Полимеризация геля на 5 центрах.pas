program growPAAG;
uses GraphABC;

const
  lengthx = 600;
  lengthy = 600;{Размер окна}
  
var
  point: array [1..1000, 1..1000] of integer;
  Rs, Rt,Rmax, r: array [1..5] of real;
  al, x, y, s, k, i: integer;
  dx, dy: array [1..4] of integer;
  
 begin
   setWindowsize(lengthy, lengthx);
   
   //Координаты центров роста
   point[200, 200]:= 1;
   point[400, 200]:= 1;
   point[200, 400]:= 1; 
   point[400, 400]:= 1;
   point[300, 300]:= 1;
   SetPixel (200, 200, clBrown);
   SetPixel (400, 200, clBrown);
   SetPixel (200, 400, clBrown);
   SetPixel (400, 400, clBrown);
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
   Rmax[1]:= 0;
   Rs[1] := Rmax[1]+4;
   Rt[1] := Rmax[1]+80;
   
   Rmax[2]:= 0;
   Rs[2] := Rmax[2]+4;
   Rt[2] := Rmax[2]+80;
   
   Rmax[3]:= 0;
   Rs[3] := Rmax[3]+4;
   Rt[3] := Rmax[3]+80;
   
   Rmax[4]:= 0;
   Rs[4] := Rmax[4]+4;
   Rt[4] := Rmax[4]+80;
   
   Rmax[5]:= 0;
   Rs[5] := Rmax[5]+4;
   Rt[5] := Rmax[5]+80;
   
   SetBrushColor(clBlack);
   
   while (Rmax[1]<(lengthx/3)) and (Rmax[2]<(lengthx/3)) and (Rmax[3]<(lengthx/3)) and (Rmax[4]<(lengthx/3)) and (Rmax[5]<(lengthx/3))
   do begin
        k:= 1+Random (5);
        al:= Random(360); // Угловая координата
        case k of
          1: begin
             x:= round (Rs[1]*cos(al))+200;//выбор новой частицы
             y:= round (Rs[1]*sin(al))+200;
             r[1]:= sqrt(sqr(x-200)+sqr(y-200));
             end;
          
          2: begin
             x:= round (Rs[2]*cos(al))+400;//выбор новой частицы
             y:= round (Rs[2]*sin(al))+200;
             r[2]:= sqrt(sqr(x-400)+sqr(y-200));
             end;
             
          3: begin
             x:= round (Rs[3]*cos(al))+200;//выбор новой частицы
             y:= round (Rs[3]*sin(al))+400;
             r[3]:= sqrt(sqr(x-200)+sqr(y-400));
             end;  
             
          4: begin
             x:= round (Rs[4]*cos(al))+400;//выбор новой частицы
             y:= round (Rs[4]*sin(al))+400;
             r[4]:= sqrt(sqr(x-400)+sqr(y-400));
             end;
             
           5: begin
             x:= round (Rs[5]*cos(al))+300;//выбор новой частицы
             y:= round (Rs[5]*sin(al))+300;
             r[5]:= sqrt(sqr(x-300)+sqr(y-300));
             end;  
        end;
        
        s:= 0;
        while (s=0) and ((r[1]<Rt[1]) or (r[2]<Rt[2]) or (r[3]<Rt[3]) or (r[4]<Rt[4]) or (r[5]<Rt[5])) do
          begin
            k:= 1+Random (4);//Движение частицы
            x:= x+dx[k];
            y:= y+dy[k];
            r[1]:= sqrt(sqr(x-200)+sqr(y-200));
            r[2]:= sqrt(sqr(x-400)+sqr(y-200));
            r[3]:= sqrt(sqr(x-200)+sqr(y-400));
            r[4]:= sqrt(sqr(x-400)+sqr(y-400));
            r[5]:= sqrt(sqr(x-300)+sqr(y-300));
            if (r[1]<Rs[1]) or (r[2]<Rs[2]) or (r[3]<Rs[3]) or (r[4]<Rs[4]) or (r[5]<Rs[5]) then 
              begin
              for k := 1 to 4 do
               begin
                s:= s+point[x+dx[k], y+dy[k]];//Проверка наличия частиц кластера
               end;
               if s>0 then
               begin
                 point[x, y] := 1;
                 SetPixel(x, y, clBlack);
                 
                 // Находим новые параметры для центров роста
                 for i:=1 to 5 do
                   begin
                 if (r[i]>Rmax[i]) and ((r[i]-Rmax[i])<=1) then
                     begin
                       Rmax[i] := r[i];// Находим новые параметры
                       Rs[i] := Rmax[i]+4;
                       Rt[i] := Rmax[i]+80;
                     end;
                   end;
                end;
             end;
          end;
      end;
 end. 