function [best_ant, best_droga, mat_ant, mat_droga, p, suma_feromonu_dostepne_polaczenia]=algorytm_mrowkowy(liczba_miast, liczba_cykli, liczba_iteracji, feromon_na_mrowke, parowanie_feromonu, zerowy_poziom_fer, miasta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autorzy: Kinga Nowak i Artur Krasowski IiAM 2
%
% Opis programu:
%
% Napisany program wyœwietla wylosowan¹ mapê, a nastêpnie drogê, która
% zosta³a wybrana jako najlepsza i jej d³ugoœæ. 
% Zmienne wejœciowe:
% 1) liczba_miast --> zmienna pobierana od u¿ytkownika, mówi¹ca ile miast
%                   ma byæ wylosowanych.
% 2) liczba_cykli --> zmienna pobierana od u¿ytkownika, mówi¹ca o iloœci
%                   mrówek.
% 3) liczba_iteracji --> zmienna pobierana od u¿ytkownika, mówi¹ca o tym ile
%                   cykli, czyli ile razy ma przejœæ dana mrówka przez wszystkie miasta.
% 4) feromon_na_mrowke --> zmienna pobierana od u¿ytkownika, mówi¹ca o
%                   iloœci feromonu jaka przypada na jedn¹ mrówkê.
% 5) parowanie_feromonu --> zmienna pobierana od u¿ytkownika, mówi¹ca o
%                   iloœci fromonu jaka odparowywuje z drogi.
% 6) zerowy_poziom_fer --> zmienna pobierana od u¿ytkownika, mówi¹ca o tym
%                   jaka by³a iloœæ feromonu na pocz¹tku obliczeñ
% 7) miasta --> zapisane s¹ w niej informacje o numerze miasta, czyli jego
%               nazwie i po³o¿eniu. Kolumna 2 to wartoœæ x, a 3 kolumna to wartoœæ y.
% Zmienne wyjœciowe:
% 1) best_ant --> zmienna, w której jest zapisana informacja o najlepszej drodze wybranej przez mrówki.
%              Zapisane s¹ w niej po kolei miasta, czyli jak nale¿y
%              przemieszczaæ siê miêdzy miastami w najlepszy sposób.
% 2) best_droga --> zmienna, w której jest zapisana d³ugoœæ drogi uznaje
%               jako najlepszej, czyli tej ze zmiennej best_ant.
% 3) mat_ant --> zapis wszytskich dróg jakie przeby³y mrówki po kolei. Po
%               kolei w kolumach sa zapisywane jakie miasta zosta³y odwiedzone, a jeden
%               wiersz odpowiada jednej mrówce. W poni¿szych danych zosta³y zapisane:
%               iloœæ mrówwek jako 15 i iloœæ razy jak¹ przejdzie dana mrówka po mapie to
%               4. Tak wiêc w podanje zmiennej uzyskujemy 60 wierszy (15*4). Iloœci te
%               mo¿na dowolnie modyfikowaæ co te¿ spowoduje zmianê iloœci wierszy.
% 4) mat_droga --> w niej s¹ zapisane d³ugoœci wszystkich przebytych dróg
%               przez mrówki, które znajduj¹ siê w zmiennej mat_ant.
% 5) p --> zmienna uzyskiwana/ obliczana w osobnej funkcji
%               GenerowaniePolaczen.m. Znajduj¹ siê w niej informacje o liczbie
%               porz¹dkowej, nazwie (numerze) miasta, nazwie miasta, do którego jest
%               mo¿liwoœæ pójœci przez mrówkê, iloœæ feromonu, d³ugoœæ œcie¿ki z jednego
%               miasta do drugiego oraz kolumna pomocnicza o wartoœciach 0. 
% 6) suma_feromonu_dostepne_polaczenia --> zmienna mówi¹ca ile zosta³o siê
%               feromonu na wybranej drodze po skoñczeniu obliczeñ.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% zmienna potrzebne w dalszych obliczeniach
best_droga=Inf;
mat_best_ant=[];
mat_best_droga=[];
iteracja=[];
f=1;

%% tworzenie wszytskich mo¿liwych polaczeniawo³¹czeñ miêdzy miastami
% liczba polaczeñ miêdzy miastami, je¿eli chodzi o jedn¹ drogê
l=liczba_miast-1;
% liczba wszytskich mo¿liwych po³¹czeñ miêdzy danymi miastami
n=((liczba_miast*(liczba_miast-3))/2)+liczba_miast;
p=GenerowaniePolaczen(l, n, zerowy_poziom_fer, miasta);

%% u¿ycie algorytmu mrówkowego, szukanie po³¹czeñ drogi
% macierz posiadaj¹ca informacjê na temat jak¹ drogê pokona³a konkretna
% mrówka
mat_ant= zeros(liczba_iteracji*liczba_cykli, liczba_miast);
% macierz posiadaj¹ca informacjê na temat d³ugoœci drogi jak¹ pokona³a
% mrówka
mat_droga= zeros(liczba_cykli*liczba_iteracji,1);

for xx=1:liczba_iteracji % okreœla liczbe iteracji
for cycle=1:liczba_cykli % okreœla liczbe mrówek
ant(1,1)=1;
dostepne_miasta=miasta(:,1);
dostepne_miasta(1,:)=[];
size_p=size(p);


for cykl=1:l
size_ant=size(ant);
dostepne_polaczenia(:,2)=dostepne_miasta(:,1); % miasta dostepne ze ostatniego
dostepne_polaczenia(:,1)=ant(size_ant(1,1),1); % ostatnie odwiedzone miasto

size_dostepne_polaczenia=size(dostepne_polaczenia);

for i=1:size_dostepne_polaczenia(1,1) % generowanie dostepnych polaczen
    for k=1:size_p(1,1)
        if (((dostepne_polaczenia(i,1)==p(k,2)) && (dostepne_polaczenia(i,2)==p(k,3))) || ((dostepne_polaczenia(i,2)==p(k,2)) && (dostepne_polaczenia(i,1)==p(k,3))))
            dostepne_polaczenia(i,4)=p(k,4);
            dostepne_polaczenia(i,3)=p(k,1); % indeks polaczenia
   
        end
    end
end

a=0;
%okreslanie progow
suma_feromonu_dostepne_polaczenia=sum(dostepne_polaczenia(:,4));
%normalizacja
dostepne_polaczenia(:,6)=0;
for i=1:size_dostepne_polaczenia(1,1)
    dostepne_polaczenia(i,5)=dostepne_polaczenia(i,4)/suma_feromonu_dostepne_polaczenia;
    dostepne_polaczenia(i,6)=sum(dostepne_polaczenia(:,5));
end
prog_dol=[0 ; dostepne_polaczenia(:,6)];
size_prog_dol=size(prog_dol);
prog_dol(size_prog_dol(1,1))=[];
dostepne_polaczenia(:,5)=prog_dol;
%losowanie sciezki
los=rand();
for i=1:size_dostepne_polaczenia(1,1)
    if (dostepne_polaczenia(i,5)<los) && (los<=dostepne_polaczenia(i,6))
        ostatnie_miasto=dostepne_polaczenia(i,2);
    end
end

ant=[ant; ostatnie_miasto];

size_dostepne_miasta=size(dostepne_miasta);

for ii=1:size_dostepne_miasta(1,1)
    if ostatnie_miasto(1,1)==dostepne_miasta(ii,1)
      
        kill=ii;
    end
end

dostepne_miasta(kill,:)=[];

clear dostepne_polaczenia ii

end

clear dostepne_miasta

%% Okreslanie polaczen mrowki

polaczenia_ant1=ant;
polaczenia_ant2=ant;
size_ant=size(ant);

polaczenia_ant1(size_ant(1,1),:)=[];
polaczenia_ant2(1,:)=[];
polaczenia_ant=[polaczenia_ant1 polaczenia_ant2];

clear polaczenia_ant1 polaczenia_ant2
%% sciagniecie dlugosci sciezki
size_polaczenia_ant=size(polaczenia_ant);
for i=1:size_polaczenia_ant(1,1)
    for k=1:size_p(1,1)
        if ((p(k,2)==polaczenia_ant(i,1)) && (p(k,3)==polaczenia_ant(i,2))) || ((p(k,2)==polaczenia_ant(i,2)) && (p(k,3)==polaczenia_ant(i,1)))
            polaczenia_ant(i,3)=p(k,5);
        end
    end
end
droga=sum(polaczenia_ant(:,3));
feromon=feromon_na_mrowke/droga;

%% uzupelnienie feromonu na sciezce
for i=1:size_polaczenia_ant(1,1)
    for k=1:size_p(1,1)
        if ((p(k,2)==polaczenia_ant(i,1)) && (p(k,3)==polaczenia_ant(i,2))) || ((p(k,2)==polaczenia_ant(i,2)) && (p(k,3)==polaczenia_ant(i,1)))
            p(k,6)=p(k,6)+feromon;
        end
    end
end
%% Zamkniecie mrowki
if droga<best_droga
    best_droga=droga;
    best_ant=ant;
    mat_best_ant=[mat_best_ant best_ant];
    mat_best_droga=[mat_best_droga best_droga];
    iteracja=[iteracja xx];
end
ant=ant';
mat_ant(f,:)=ant;
mat_droga(f,:)=droga;
f=f+1;
p(:,4)=p(:,4)+p(:,6);
p(:,6)=0;
clear ant polaczenia_ant
end % KONIEC MROWKI
%parowanie feromonu
parowanie=parowanie_feromonu;
for iii=1:size_p(1,1)
    if p(iii,4)<parowanie
        p(iii,4)=zerowy_poziom_fer;
       
    else
        p(iii,4)=p(iii,4)-parowanie;
        
    end
end
    
end
