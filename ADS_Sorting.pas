program ADS_Sorting;

uses Crt,SysUtils;

type
  tabR=Array of real;
  tabC=Array of integer;
  TElement = record
    nastepnik : cardinal;
    dane : real;
  end;

procedure wypelnij(var tabR1:tabR;var tabC1:tabC;czyCalkowite:boolean;n:byte;var wielkosc:integer;czyRecznie:boolean);
var
  i:integer;
  odIlu:integer;
begin
  odIlu:=0;
  if(n = 11) then
  begin
    repeat
      writeln('Podaj wielkosc tablicy: ');
      readln(wielkosc);
    until (wielkosc > 5);
  end;
  if(czyRecznie) then ClrScr;
  writeln('Wypelniam tablice...');
  if(n <> 11) then
  begin
    case n of
    1: wielkosc:=30000;
    2: wielkosc:=50000;
    3: wielkosc:=100000;
    4: wielkosc:=150000;
    5: wielkosc:=200000;
    6: wielkosc:=500000;
    7: wielkosc:=1000000;
    8: wielkosc:=2000000;
    9: wielkosc:=5000000;
    10: wielkosc:=10000000;
    end;
  end;
  if(czyCalkowite) then
  begin
    odIlu:=length(tabC1);
    setLength(tabC1,wielkosc);
  end else
  begin
    odIlu:=length(tabR1);
    setLength(tabR1,wielkosc);
  end;
  i:=0;
  for i:=odIlu to (wielkosc-1) do
  begin
    if(czyCalkowite) then tabC1[i]:=random(wielkosc + 1) else tabR1[i]:=random(wielkosc)+random();
  end;
end;

procedure bombelkowe(tabR1:tabR;tabC1:tabC;czyCalkowite:boolean;wielkosc:integer;tryb:byte);
var
  tabC2:tabC;
  tabR2:tabR;
  tmpR:real;
  i,j,tmpC:integer;
  start,koniec:QWOrd;
  f:textFile;
  s,nazwaPliku:string;
begin
  if(wielkosc > 1000000) then
  begin
    if(tryb = 1) then
    begin
      ClrScr;
      writeln('Wielkosc danych przekracza 1.000.000!');
      writeln('Sortowanie bombelkowe nie zostanie wykonane!');
      writeln();
      writeln('Wcisnij ENTER, aby wrocic...');
      readln();
      exit;
    end;
    if(tryb = 0) then
    begin
      writeln('|     BOMBELKOWE     |          - |');
      writeln('+--------------------+------------+');
      exit;
    end;
  end;
  if(czyCalkowite) then
  begin
    tabC2:=tabC1;
    setLength(tabC2,wielkosc);
  end else
  begin
    tabR2:=tabR1;
    setLength(tabR2,wielkosc);
  end;
  if(tryb > 0) then
  begin
    if(tryb = 1) then ClrScr;
    writeln('Rozpoczynam sortowanie babelkowe (bubble sort)...');
  end;
  start:=GetTickCount64;
  if(czyCalkowite) then
  begin
    for i:=(wielkosc-1) downto 0 do
    begin
      for j:=0 to (i-1) do
      begin
        if(tabC2[j] > tabC2[j+1]) then
        begin
          tmpC:=tabC2[j];
          tabC2[j]:=tabC2[j+1];
          tabC2[j+1]:=tmpC;
        end;
      end;
    end;
  end else
  begin
    for i:=(wielkosc-2) downto 0 do
    begin
      for j:=0 to (i-1) do
      begin
        if(tabR2[j] > tabR2[j+1]) then
        begin
          tmpR:=tabR2[j];
          tabR2[j]:=tabR2[j+1];
          tabR2[j+1]:=tmpR;
        end;
      end;
    end;
  end;
  koniec:=GetTickCount64;
  if(tryb = 1) then ClrScr;
  if(tryb > 0) then
  begin
    writeln('Tablica o rozmiarze: ',wielkosc);
    writeln('Sortowanie trwalo: ',koniec-start,' ms');
    if(tryb = 1) then writeln() else
    begin
      if(czyCalkowite) then nazwaPliku:='calkowite_wynik.txt' else nazwaPliku:='rzeczywiste_wynik.txt';
      assignFile(f,nazwaPliku);
      append(f);
      s:='|      BABELKOWE     | ';
      for i:=1 to 8 do
      begin
        if((8-i) < length(IntToStr(wielkosc))) then
        begin
          s:=s+IntToStr(wielkosc);
          break;
        end else s:=s+' ';
      end;
      s:=s+' | ';
      for i:=1 to 10 do
      begin
        if((10-i) < length(IntToStr(koniec-start))) then
        begin
          s:=s+IntToStr(koniec-start);
          break;
        end else s:=s+' ';
      end;
      s:=s+' |';
      writeln(f,s);
      s:='+--------------------+          +------------+';
      writeln(f,s);
      closeFile(f);
      writeln('-----------------------------------------------------------');
    end;
  end else
  begin
    write('|      BABELKOWE     |');
    write(' ',(koniec-start):10,' |');
    writeln();
    writeln('+--------------------+------------+');
  end;
  if(tryb = 1) then
  begin
    writeln('Wcisnij ENTER, aby wrocic...');
    readln();
  end;
end;

procedure selection(tabR1:tabR;tabC1:tabC;czyCalkowite:boolean;wielkosc:integer;tryb:byte);
var
  tabC2:tabC;
  tabR2:tabR;
  tempR:real;
  i,j,tempC,min:integer;
  start,koniec:QWOrd;
  f:textFile;
  s,nazwaPliku:string;
begin
  if(czyCalkowite) then
  begin
    tabC2:=tabC1;
    setLength(tabC2,wielkosc);
  end else
  begin
    tabR2:=tabR1;
    setLength(tabR2,wielkosc);
  end;
  if(tryb > 0) then
  begin
    if(tryb = 1) then ClrScr;
    writeln('Rozpoczynam sortowanie przez wybor (selection sort)...');
  end;
  start:=GetTickCount64;
  if(czyCalkowite) then
  begin
    for i:=0 to wielkosc-2 do
    begin
      min:=i;
      for j:=i+1 to wielkosc-1 do
      begin
        if(tabC2[j] < tabC2[min]) then min:=j;
      end;
      if(min <> i) then
      begin
        tempC:=tabC2[min];
        tabC2[min]:=tabC2[i];
        tabC2[i]:=tempC;
      end;
    end;
  end else
  begin
    for i:=0 to wielkosc-2 do
    begin
      min:=i;
      for j:=i+1 to wielkosc-1 do
      begin
        if(tabR2[j] < tabR2[min]) then min:=j;
      end;
      if(min <> i) then
      begin
        tempR:=tabR2[min];
        tabR2[min]:=tabR2[i];
        tabR2[i]:=tempR;
      end;
    end;
  end;
  koniec:=GetTickCount64;
  if(tryb = 1) then ClrScr;
  if(tryb > 0) then
  begin
    writeln('Tablica o rozmiarze: ',wielkosc);
    writeln('Sortowanie trwalo: ',koniec-start,' ms');
    if(tryb = 1) then writeln() else
    begin
      if(czyCalkowite) then nazwaPliku:='calkowite_wynik.txt' else nazwaPliku:='rzeczywiste_wynik.txt';
      assignFile(f,nazwaPliku);
      append(f);
      if(wielkosc > 1000000) then
      begin
        s:='|        WYBOR       | ';
        for i:=1 to 8 do
        begin
          if((8-i) < length(IntToStr(wielkosc))) then
          begin
            s:=s+IntToStr(wielkosc);
            break;
          end else s:=s+' ';
        end;
        s:=s+' | ';
      end else s:='|        WYBOR       |          | ';
      for i:=1 to 10 do
      begin
        if((10-i) < length(IntToStr(koniec-start))) then
        begin
          s:=s+IntToStr(koniec-start);
          break;
        end else s:=s+' ';
      end;
      s:=s+' |';
      writeln(f,s);
      s:='+--------------------+          +------------+';
      writeln(f,s);
      closeFile(f);
      writeln('-----------------------------------------------------------');
    end;
  end else
  begin
    write('|        WYBOR       |');
    write(' ',(koniec-start):10,' |');
    writeln();
    writeln('+--------------------+------------+');
  end;
  if(tryb = 1) then
  begin
    writeln('Wcisnij ENTER, aby wrocic...');
    readln();
  end;
end;

procedure insertion(tabR1:tabR;tabC1:tabC;czyCalkowite:boolean;wielkosc:integer;tryb:byte);
var
  tabC2:tabC;
  tabR2:tabR;
  tmpR:real;
  i,j,tmpC:integer;
  start,koniec:QWOrd;
  f:textFile;
  s,nazwaPliku:string;
begin
  if(czyCalkowite) then
  begin
    tabC2:=tabC1;
    setLength(tabC2,wielkosc);
  end else
  begin
    tabR2:=tabR1;
    setLength(tabR2,wielkosc);
  end;
  if(tryb > 0) then
  begin
    if(tryb = 1) then ClrScr;
    writeln('Rozpoczynam sortowanie przez wstawianie (insertion sort)...');
  end;
  start:=GetTickCount64;
  if(czyCalkowite) then
  begin
    for i:=1 to wielkosc-1 do
    begin
      j:=i-1;
      tmpC:=tabC2[i];
      while((j>=0) and (tabC2[j]>tmpC)) do
      begin
        tabC2[j+1]:=tabC2[j];
        dec(j);
      end;
      tabC2[j+1]:=tmpC;
    end;
  end else
  begin
    for i:=1 to wielkosc-1 do
    begin
      j:=i-1;
      tmpR:=tabR2[i];
      while((j>=0) and (tabR2[j]>tmpR)) do
      begin
        tabR2[j+1]:=tabR2[j];
        dec(j);
      end;
      tabR2[j+1]:=tmpR;
    end;
  end;
  koniec:=GetTickCount64;
  if(tryb = 1) then ClrScr;
  if(tryb > 0) then
  begin
    writeln('Tablica o rozmiarze: ',wielkosc);
    writeln('Sortowanie trwalo: ',koniec-start,' ms');
    if(tryb = 1) then writeln() else
    begin
      if(czyCalkowite) then nazwaPliku:='calkowite_wynik.txt' else nazwaPliku:='rzeczywiste_wynik.txt';
      assignFile(f,nazwaPliku);
      append(f);
      s:='|     WSTAWIANIE     |          | ';
      for i:=1 to 10 do
      begin
        if((10-i) < length(IntToStr(koniec-start))) then
        begin
          s:=s+IntToStr(koniec-start);
          break;
        end else s:=s+' ';
      end;
      s:=s+' |';
      writeln(f,s);
      s:='+--------------------+          +------------+';
      writeln(f,s);
      closeFile(f);
      writeln('-----------------------------------------------------------');
    end;
  end else
  begin
    write('|     WSTAWIANIE     |');
    write(' ',(koniec-start):10,' |');
    writeln();
    writeln('+--------------------+------------+');
  end;
  if(tryb = 1) then
  begin
    writeln('Wcisnij ENTER, aby wrocic...');
    readln();
  end;
end;

procedure mechanizmMergeC(p,k:integer;var tabC2,tabC3:tabC);
var
  s,i1,i2,i:integer;
begin
  s:=(p+k+1) div 2;
  if s-p > 1 then mechanizmMergeC(p,s-1,tabC2,tabC3);
  if k-s > 0 then mechanizmMergeC(s,k,tabC2,tabC3);
  i1:=p;
  i2:=s;
  for i:=p to k do
    if((i1 = s) or (i2 <= k) and (tabC2[i1] > tabC2[i2])) then
    begin
      tabC3[i]:=tabC2[i2];
      inc(i2);
    end else
    begin
      tabC3[i]:=tabC2[i1];
      inc(i1);
    end;
  for i:=p to k do tabC2[i]:=tabC3[i];
end;

procedure mechanizmMergeR(p,k:integer;var tabR2,tabR3:tabR);
var
  s,i1,i2,i:integer;
begin
  s:=(p+k+1) div 2;
  if s-p > 1 then mechanizmMergeR(p,s-1,tabR2,tabR3);
  if k-s > 0 then mechanizmMergeR(s,k,tabR2,tabR3);
  i1:=p;
  i2:=s;
  for i:=p to k do
    if((i1 = s) or (i2 <= k) and (tabR2[i1] > tabR2[i2])) then
    begin
      tabR3[i]:=tabR2[i2];
      inc(i2);
    end else
    begin
      tabR3[i]:=tabR2[i1];
      inc(i1);
    end;
  for i:=p to k do tabR2[i]:=tabR3[i];
end;

procedure merge(tabR1:tabR;tabC1:tabC;czyCalkowite:boolean;wielkosc:integer;tryb:byte);
var
  tabC2,tabC3:tabC;
  tabR2,tabR3:tabR;
  start,koniec:QWOrd;
  f:textFile;
  s,nazwaPliku:string;
  i:integer;
begin
  if(czyCalkowite) then
  begin
    tabC2:=tabC1;
    setLength(tabC2,wielkosc);
    setLength(tabC3,wielkosc);
  end else
  begin
    tabR2:=tabR1;
    setLength(tabR2,wielkosc);
    setLength(tabR3,wielkosc);
  end;
  if(tryb > 0) then
  begin
    if(tryb = 1) then ClrScr;
    writeln('Rozpoczynam sortowanie przez scalanie (merge sort)...');
  end;
  start:=GetTickCount64;
  if(czyCalkowite) then
  begin
    mechanizmMergeC(0,wielkosc-1,tabC2,tabC3);
  end else
  begin
    mechanizmMergeR(0,wielkosc-1,tabR2,tabR3);
  end;
  koniec:=GetTickCount64;
  if(tryb = 1) then ClrScr;
  if(tryb > 0) then
  begin
    writeln('Tablica o rozmiarze: ',wielkosc);
    writeln('Sortowanie trwalo: ',koniec-start,' ms');
    if(tryb = 1) then writeln() else
    begin
      if(czyCalkowite) then nazwaPliku:='calkowite_wynik.txt' else nazwaPliku:='rzeczywiste_wynik.txt';
      assignFile(f,nazwaPliku);
      append(f);
      if(wielkosc > 2000000) then
      begin
        s:='|      SCALANIE      | ';
        for i:=1 to 8 do
        begin
          if((8-i) < length(IntToStr(wielkosc))) then
          begin
            s:=s+IntToStr(wielkosc);
            break;
          end else s:=s+' ';
        end;
        s:=s+' | ';
      end else s:='|      SCALANIE      |          | ';
      for i:=1 to 10 do
      begin
        if((10-i) < length(IntToStr(koniec-start))) then
        begin
          s:=s+IntToStr(koniec-start);
          break;
        end else s:=s+' ';
      end;
      s:=s+' |';
      writeln(f,s);
      s:='+--------------------+          +------------+';
      writeln(f,s);
      closeFile(f);
      writeln('-----------------------------------------------------------');
    end;
  end else
  begin
    write('|      SCALANIE      |');
    write(' ',(koniec-start):10,' |');
    writeln();
    writeln('+--------------------+------------+');
  end;
  if(tryb = 1) then
  begin
    writeln('Wcisnij ENTER, aby wrocic...');
    readln();
  end;
end;

procedure counting(tabC1:tabC;czyCalkowite:boolean;wielkosc:integer;tryb:byte);
var
  tabC2,tabC3:tabC;
  i:integer;
  start,koniec:QWOrd;
  f:textFile;
  s,nazwaPliku:string;
begin
  if(czyCalkowite) then
  begin
    setLength(tabC2,wielkosc);
    setLength(tabC3,wielkosc+1);
  end else
  begin
    ClrScr;
    writeln('To sortowanie dziala tylko dla danych calkowitych!');
    writeln();
    writeln('Wcisnij ENTER, aby wrocic...');
    readln();
    exit;
  end;
  if(tryb > 0) then
  begin
    if(tryb = 1) then ClrScr;
    writeln('Rozpoczynam sortowanie przez zliczanie (counting sort)...');
  end;
  start:=GetTickCount64;
  for i:=0 to wielkosc do tabC3[i]:=0; //zerowanie tablicy
  for i:=0 to wielkosc-1 do //liczba wystapien danych liczb
  begin
    tabC3[tabC1[i]]:=tabC3[tabC1[i]]+1;
  end;
  for i:=1 to wielkosc do tabC3[i]:=tabC3[i]+tabC3[i-1];
  for i:=wielkosc-1 downto 0 do //ustawianie na odpowiednia pozycje odpowiednich numerow
  begin
    tabC3[tabC1[i]]:=tabC3[tabC1[i]]-1;
    tabC2[tabC3[tabC1[i]]]:=tabC1[i];
  end;
  koniec:=GetTickCount64;
  if(tryb = 1) then ClrScr;
  if(tryb > 0) then
  begin
    writeln('Tablica o rozmiarze: ',wielkosc);
    writeln('Sortowanie trwalo: ',koniec-start,' ms');
    if(tryb = 1) then writeln() else
    begin
      if(czyCalkowite) then nazwaPliku:='calkowite_wynik.txt' else nazwaPliku:='rzeczywiste_wynik.txt';
      assignFile(f,nazwaPliku);
      append(f);
      s:='|      ZLICZANIE     |          | ';
      for i:=1 to 10 do
      begin
        if((10-i) < length(IntToStr(koniec-start))) then
        begin
          s:=s+IntToStr(koniec-start);
          break;
        end else s:=s+' ';
      end;
      s:=s+' |';
      writeln(f,s);
      s:='+--------------------+          +------------+';
      writeln(f,s);
      closeFile(f);
      writeln('-----------------------------------------------------------');
    end;
  end else
  begin
    write('|      ZLICZANIE     |');
    write(' ',(koniec-start):10,' |');
    writeln();
    writeln('+--------------------+------------+');
  end;
  if(tryb = 1) then
  begin
    writeln('Wcisnij ENTER, aby wrocic...');
    readln();
  end;
end;

procedure heapifyC(var tabC2:tabC;l,p:integer);
var
  i,j,x:integer;
begin
  i:=l;
  j:=2*l;
  x:=tabC2[i];
  while (j<=p) do
  begin
    if(j<p) then if (tabC2[j]>tabC2[j+1]) then j:=j+1;
    if(x<=tabC2[j]) then break;
    tabC2[i]:=tabC2[j];
    i:=j;
    j:=2*i;
  end;
  tabC2[i]:=x;
end;

procedure heapifyR(var tabR2:tabR;l,p:integer);
var
  i,j:integer;
  x:real;
begin
  i:=l;
  j:=2*l;
  x:=tabR2[i];
  while (j<=p) do
  begin
    if(j<p) then if (tabR2[j]>tabR2[j+1]) then j:=j+1;
    if(x<=tabR2[j]) then break;
    tabR2[i]:=tabR2[j];
    i:=j;
    j:=2*i;
  end;
  tabR2[i]:=x;
end;

procedure heap(tabR1:tabR;tabC1:tabC;czyCalkowite:boolean;wielkosc:integer;tryb:byte);
var
  tabC2:tabC;
  tabR2:tabR;
  i,xC:integer;
  xR:real;
  start,koniec:QWOrd;
  f:textFile;
  s,nazwaPliku:string;
begin
  if(czyCalkowite) then
  begin
    setLength(tabC2,wielkosc+1);
    for i:=0 to wielkosc-1 do tabC2[i+1]:=tabC1[i];
  end else
  begin
    setLength(tabR2,wielkosc+1);
    for i:=0 to wielkosc-1 do tabR2[i+1]:=tabR1[i];
  end;
  if(tryb > 0) then
  begin
    if(tryb = 1) then ClrScr;
    writeln('Rozpoczynam sortowanie przez kopcowanie (heap sort)...');
  end;
  start:=GetTickCount64;
  if(czyCalkowite) then
  begin
    for i:=(wielkosc div 2) downto 1 do heapifyC(tabC2,i,wielkosc);
    for i:=wielkosc downto 1 do
    begin
      xC:=tabC2[1];
      tabC2[1]:=tabC2[i];
      tabC2[i]:=xC;
      heapifyC(tabC2,1,i-1);
    end;
  end else
  begin
    for i:=(wielkosc div 2) downto 1 do heapifyR(tabR2,i,wielkosc);
    for i:=wielkosc downto 1 do
    begin
      xR:=tabR2[1];
      tabR2[1]:=tabR2[i];
      tabR2[i]:=xR;
      heapifyR(tabR2,1,i-1);
    end;
  end;
  koniec:=GetTickCount64;
  if(tryb = 1) then ClrScr;
  if(tryb > 0) then
  begin
    writeln('Tablica o rozmiarze: ',wielkosc);
    writeln('Sortowanie trwalo: ',koniec-start,' ms');
    if(tryb = 1) then writeln() else
    begin
      if(czyCalkowite) then nazwaPliku:='calkowite_wynik.txt' else nazwaPliku:='rzeczywiste_wynik.txt';
      assignFile(f,nazwaPliku);
      append(f);
      s:='|     KOPCOWANIE     |          | ';
      for i:=1 to 10 do
      begin
        if((10-i) < length(IntToStr(koniec-start))) then
        begin
          s:=s+IntToStr(koniec-start);
          break;
        end else s:=s+' ';
      end;
      s:=s+' |';
      writeln(f,s);
      s:='+--------------------+          +------------+';
      writeln(f,s);
      closeFile(f);
      writeln('-----------------------------------------------------------');
    end;
  end else
  begin
    write('|     KOPCOWANIE     |');
    write(' ',(koniec-start):10,' |');
    writeln();
    writeln('+--------------------+------------+');
  end;
  if(tryb = 1) then
  begin
    writeln('Wcisnij ENTER, aby wrocic...');
    readln();
  end;
end;

procedure bucket(tabR1:tabR;tabC1:tabC;czyCalkowite:boolean;wielkosc:integer;tryb:byte);
var
  tabC2,kubelek:tabC;
  tabR2:tabR;
  i,j,ikb,ine,ip,ib:integer;
  L:Array of TElement;
  we:real;
  start,koniec:QWOrd;
  f:textFile;
  s,nazwaPliku:string;
begin
  setLength(kubelek,wielkosc+1);
  if(czyCalkowite) then
  begin
    tabC2:=tabC1;
    setLength(tabC2,wielkosc);
  end else
  begin
    tabR2:=tabR1;
    setLength(tabR2,wielkosc);
    setLength(L,wielkosc+1);
  end;
  if(tryb > 0) then
  begin
    if(tryb = 1) then ClrScr;
    writeln('Rozpoczynam sortowanie kubelkowe (bucket sort)...');
  end;
  start:=GetTickCount64;
  if(czyCalkowite) then
  begin
    for i:=0 to wielkosc do kubelek[i]:=0; //zerowanie
    for i:=0 to wielkosc-1 do inc(kubelek[tabC2[i]]); //zliczanie wartosci
    j:=0; // wpisywanie wartosci posortowanych
    for i:=0 to wielkosc do
    begin
      while kubelek[i] > 0 do
      begin
        tabC2[j]:=i;
        inc(j);
        dec(kubelek[i]);
      end;
    end;
  end else
  begin
    for i:=0 to wielkosc do kubelek[i]:=0; //zerowanie
    ine:=0;
    for i:=0 to wielkosc do
    begin
      we:=tabR2[i-1];
      ikb:=round(we);
      L[ine].nastepnik:=0;
      L[ine].dane:=we;
      ip:=0;
      ib:=kubelek[ikb];
      while ((ib > 0) and (L[ib].dane < we)) do
      begin
        ip:=ib;
        ib:=L[ib].nastepnik;
      end;
      if ip = 0 then
      begin
        L[ine].nastepnik := ib;
        kubelek[ikb] := ine;
      end
      else if ib = 0 then L[ip].nastepnik := ine else
      begin
        L[ip].nastepnik := ine;
        L[ine].nastepnik := ib;
      end;
      inc(ine);
    end;
    j:=0;
    for ikb:=0 to wielkosc do
    begin
      i:=kubelek[ikb];
      while i > 0 do
      begin
        tabR2[j]:=L[i].dane;
        inc(j);
        i:=L[i].nastepnik;
      end;
    end;
  end;
  koniec:=GetTickCount64;
  if(tryb = 1) then ClrScr;
  if(tryb > 0) then
  begin
    writeln('Tablica o rozmiarze: ',wielkosc);
    writeln('Sortowanie trwalo: ',koniec-start,' ms');
    if(tryb = 1) then writeln() else
    begin
      if(czyCalkowite) then nazwaPliku:='calkowite_wynik.txt' else nazwaPliku:='rzeczywiste_wynik.txt';
      assignFile(f,nazwaPliku);
      append(f);
      s:='|      KUBELKOWE     |          | ';
      for i:=1 to 10 do
      begin
        if((10-i) < length(IntToStr(koniec-start))) then
        begin
          s:=s+IntToStr(koniec-start);
          break;
        end else s:=s+' ';
      end;
      s:=s+' |';
      writeln(f,s);
      s:='+--------------------+          +------------+';
      writeln(f,s);
      closeFile(f);
      writeln('-----------------------------------------------------------');
    end;
  end else
  begin
    write('|      KUBELKOWE     |');
    write(' ',(koniec-start):10,' |');
    writeln();
    writeln('+--------------------+------------+');
  end;
  if(tryb = 1) then
  begin
    writeln('Wcisnij ENTER, aby wrocic...');
    readln();
  end;
end;

procedure quickSortC(var tabC2:tabC;lewy,prawy:integer);
var
  i,j,piwot,x:integer;
begin
  i:=(lewy + prawy) div 2;
  piwot:=tabC2[i];
  tabC2[i]:=tabC2[prawy];
  j:=lewy;
  for i:=lewy to prawy - 1 do
    if(tabC2[i] < piwot) then
    begin
      x:=tabC2[i];
      tabC2[i]:=tabC2[j];
      tabC2[j]:=x;
      inc(j);
    end;
  tabC2[prawy]:=tabC2[j];
  tabC2[j]:=piwot;
  if(lewy < j - 1) then quickSortC(tabC2,lewy, j - 1);
  if(j + 1 < prawy) then quickSortC(tabC2,j + 1, prawy);
end;

procedure quickSortR(var tabR2:tabR;lewy,prawy:integer);
var
  i,j:integer;
  piwot,x:real;
begin
  i:=(lewy + prawy) div 2;
  piwot:=tabR2[i];
  tabR2[i]:=tabR2[prawy];
  j:=lewy;
  for i:=lewy to prawy - 1 do
    if(tabR2[i] < piwot) then
    begin
      x:=tabR2[i];
      tabR2[i]:=tabR2[j];
      tabR2[j]:=x;
      inc(j);
    end;
  tabR2[prawy]:=tabR2[j];
  tabR2[j]:=piwot;
  if(lewy < j - 1) then quickSortR(tabR2,lewy, j - 1);
  if(j + 1 < prawy) then quickSortR(tabR2,j + 1, prawy);
end;

procedure quick(tabR1:tabR;tabC1:tabC;czyCalkowite:boolean;wielkosc:integer;tryb:byte);
var
  tabC2:tabC;
  tabR2:tabR;
  start,koniec:QWOrd;
  f:textFile;
  s,nazwaPliku:string;
  i:integer;
begin
  if(czyCalkowite) then
  begin
    tabC2:=tabC1;
    setLength(tabC2,wielkosc);
  end else
  begin
    tabR2:=tabR1;
    setLength(tabR2,wielkosc);
  end;
  if(tryb > 0) then
  begin
    if(tryb = 1) then ClrScr;
    writeln('Rozpoczynam sortowanie szybkie (quick sort)...');
  end;
  start:=GetTickCount64;
  if(czyCalkowite) then
  begin
    quickSortC(tabC2,0,wielkosc-1);
  end else
  begin
    quickSortR(tabR2,0,wielkosc-1);
  end;
  koniec:=GetTickCount64;
  if(tryb = 1) then ClrScr;
  if(tryb > 0) then
  begin
    writeln('Tablica o rozmiarze: ',wielkosc);
    writeln('Sortowanie trwalo: ',koniec-start,' ms');
    if(tryb = 1) then writeln() else
    begin
      if(czyCalkowite) then nazwaPliku:='calkowite_wynik.txt' else nazwaPliku:='rzeczywiste_wynik.txt';
      assignFile(f,nazwaPliku);
      append(f);
      s:='|       SZYBKIE      |          | ';
      for i:=1 to 10 do
      begin
        if((10-i) < length(IntToStr(koniec-start))) then
        begin
          s:=s+IntToStr(koniec-start);
          break;
        end else s:=s+' ';
      end;
      s:=s+' |';
      writeln(f,s);
      s:='+--------------------+----------+------------+';
      writeln(f,s);
      closeFile(f);
      writeln('-----------------------------------------------------------');
    end;
  end else
  begin
    write('|       SZYBKIE      |');
    write(' ',(koniec-start):10,' |');
    writeln();
    writeln('+--------------------+------------+');
  end;
  if(tryb = 1) then
  begin
    writeln('Wcisnij ENTER, aby wrocic...');
    readln();
  end;
end;

procedure wszystkieDlaPodanej(tabR1:tabR;tabC1:tabC;czyCalkowite:boolean;wielkosc:integer);
begin
  ClrScr;
  writeln('ROZPOCZYNAM WSZYSTKIE SORTOWANIA DLA TABLICY O ROZMIARZE: ',wielkosc);
  writeln('+-- TYP SORTOWANIA --+---- ms ----+');
  bombelkowe(tabR1,tabC1,czyCalkowite,wielkosc,0);
  selection(tabR1,tabC1,czyCalkowite,wielkosc,0);
  insertion(tabR1,tabC1,czyCalkowite,wielkosc,0);
  merge(tabR1,tabC1,czyCalkowite,wielkosc,0);
  counting(tabC1,czyCalkowite,wielkosc,0);
  heap(tabR1,tabC1,czyCalkowite,wielkosc,0);
  bucket(tabR1,tabC1,czyCalkowite,wielkosc,0);
  quick(tabR1,tabC1,czyCalkowite,wielkosc,0);
  writeln('Wcisnij ENTER, aby wrocic...');
  readln();
end;

procedure kazdyZKazdym(var tabR1:tabR;var tabC1:tabC;czyCalkowite:boolean;var wielkosc:integer);
var
  pocz,kon:QWOrd;
  f:textFile;
  s,nazwaPliku:string;
  i:integer;
begin
  ClrScr;
  pocz:=GetTickCount64;
  write('Rozpoczynam z typem danych: ');
  if(czyCalkowite) then
  begin
    nazwaPliku:='calkowite_wynik.txt';
    writeln('calkowite');
  end else
  begin
    nazwaPliku:='rzeczywiste_wynik.txt';
    writeln('rzeczywiste');
  end;
  assignFile(f,nazwaPliku);
  rewrite(f);
  s:='+--------------------+----------+------------+';
  writeln(f,s);
  s:='|   TYP SORTOWANIA   | ROZMIARY |     ms     |';
  writeln(f,s);
  s:='+--------------------+----------+------------+';
  writeln(f,s);
  closeFile(f);
  writeln();
  for i:=1 to 10 do
  begin
    wypelnij(tabR1,tabC1,czyCalkowite,i,wielkosc,false);
    if(wielkosc <= 1000000) then bombelkowe(tabR1,tabC1,czyCalkowite,wielkosc,2);
    if(wielkosc <= 2000000) then
    begin
      selection(tabR1,tabC1,czyCalkowite,wielkosc,2);
      insertion(tabR1,tabC1,czyCalkowite,wielkosc,2);
    end;
    merge(tabR1,tabC1,czyCalkowite,wielkosc,2);
    if(czyCalkowite) then counting(tabC1,czyCalkowite,wielkosc,2);
    heap(tabR1,tabC1,czyCalkowite,wielkosc,2);
    bucket(tabR1,tabC1,czyCalkowite,wielkosc,2);
    quick(tabR1,tabC1,czyCalkowite,wielkosc,2);
  end;
  writeln();
  kon:=GetTickCount64;
  writeln('Zakonczono!');
  writeln('Caly proces trwal: ',(((kon - pocz)/1000)/60):0:4,' minut');
  write('Wynik zapisano do pliku: ');
  if(czyCalkowite) then write('calkowite') else write('rzeczywiste');
  writeln('_wynik.txt');
  writeln('Wcisnij ENTER, aby wrocic...');
  readln();
end;

var
  n:byte;
  czyCalkowite:boolean;
  tabR1:tabR;
  tabC1:tabC;
  wielkosc:integer;
begin
  Randomize;
  repeat
    setLength(tabR1,0);
    setLength(tabC1,0);
    wielkosc:=0;
    repeat
      ClrScr;
      writeln('Wykorzystaj tablice:');
      writeln('1) Calkowta');
      writeln('2) Rzeczywista');
      writeln();
      writeln('0) Wyjscie');
      readln(n);
    until (n < 3);
    if(n = 1) then czyCalkowite:=true else czyCalkowite:=false;
    while((n <> 0) and (n <> 12)) do
    begin
      ClrScr;
      writeln('Wypelnij tablice iloscia elementow:');
      writeln(' 1) 30.000');
      writeln(' 2) 50.000');
      writeln(' 3) 100.000');
      writeln(' 4) 150.000');
      writeln(' 5) 200.000');
      writeln(' 6) 500.000');
      writeln(' 7) 1.000.000');
      writeln(' 8) 2.000.000');
      writeln(' 9) 5.000.000');
      writeln('10) 10.000.000');
      writeln('11) Wielkosc podana przez uzytkownika');
      writeln();
      writeln('12) Zmien typ danych');
      writeln(' 0) Wyjscie');
      readln(n);
      if((n <> 0) and (n <> 12)) then wypelnij(tabR1,tabC1,czyCalkowite,n,wielkosc,true);
      if(n <> 0) then n:=1;
      while((n <> 0) and (n <> 12) and (n <> 11)) do
      begin
        ClrScr;
        writeln('Wykonaj na wypelnionej tablicy:');
        writeln(' 1) Sortowanie babelkowe (bubble sort)');
        writeln(' 2) Sortowanie przez wybor (selection sort)');
        writeln(' 3) Sortowanie przez wstawianie (insertion sort)');
        writeln(' 4) Sortowanie przez scalanie (merge sort)');
        writeln(' 5) Sortowanie przez zliczanie (counting sort) - TYLKO LICZBY CALKOWITE');
        writeln(' 6) Sortowanie przez kopcowanie (heap sort)');
        writeln(' 7) Sortowanie kubelkowe (bucket sort)');
        writeln(' 8) Sortowanie szybkie (quick sort)');
        writeln(' 9) Wykonaj wszystkie sortowania dla podanej tablicy');
        writeln('10) Wykonaj wszystkie sortowania ze wszystkimi zdefiniowanymi rozmiarami');
        writeln('    tablic + zapisz wyniki do pliku "<typ danych>_wynik.txt"');
        writeln();
        writeln('11) Zmien rozmiar tablicy');
        writeln('12) Zmien typ danych');
        writeln(' 0) Wyjscie');
        readln(n);
        case n of
        1: bombelkowe(tabR1,tabC1,czyCalkowite,wielkosc,1);
        2: selection(tabR1,tabC1,czyCalkowite,wielkosc,1);
        3: insertion(tabR1,tabC1,czyCalkowite,wielkosc,1);
        4: merge(tabR1,tabC1,czyCalkowite,wielkosc,1);
        5: counting(tabC1,czyCalkowite,wielkosc,1);
        6: heap(tabR1,tabC1,czyCalkowite,wielkosc,1);
        7: bucket(tabR1,tabC1,czyCalkowite,wielkosc,1);
        8: quick(tabR1,tabC1,czyCalkowite,wielkosc,1);
        9: wszystkieDlaPodanej(tabR1,tabC1,czyCalkowite,wielkosc);
        10: kazdyZKazdym(tabR1,tabC1,czyCalkowite,wielkosc);
        end;
      end;
    end;
  until (n = 0);
end.

