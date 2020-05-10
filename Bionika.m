%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autorzy: Kinga Nowak i Artur Krasowski IiAM 2
%
%
% Opis programu:
% Program nie wizualizuje bardzo szczeg�owo wszytskich etap�w obliczania w
% oknie figure() ze wzgl�du, �e napisany kod zostanie przeniesiony do gui,
% gdzie u�ytkownik b�dzie m�g� zmienia� parametry w sekcji "zmienna algorytmu mr�wkowego" 
%
% Napisany program wy�wietla wylosowan� map�, a nast�pnie drog�, kt�ra
% zosta�a wybrana jako najlepsza i jej d�ugo��. W Workspce zapisane s�
% wszystkie zmienne u�ywane podczas dzia�ania programu. Poni�ej zosta�y
% opisane zmienne, kt�re s� wa�ne pod wzgl�dem dzia�ania algorytmu, czyli
% jego wyniku.
% Zmienne:
% 1) best_ant --> zmienna, w kt�rej jest zapisana informacja o najlepszej drodze wybranej przez mr�wki.
%              Zapisane s� w niej po kolei miasta, czyli jak nale�y
%              przemieszcza� si� mi�dzy miastami w najlepszy spos�b.
% 2) best_droga --> zmienna, w kt�rej jest zapisana d�ugo�� drogi uznanje
%               jako najlepszej, czyli tej ze zmiennej best_ant.
% 3) mat_ant --> zapis wszytskich dr�g jakie przeby�y mr�wki po kolei. Po
%               kolei w kolumach sa zapisywane jakie miasta zosta�y odwiedzone, a jeden
%               wiersz odpowiada jednej mr�wce. W poni�szych danych zosta�y zapisane:
%               ilo�� mr�wwek jako 15 i ilo�� razy jak� przejdzie dana mr�wka po mapie to
%               4. Tak wi�c w podanje zmiennej uzyskujemy 60 wierszy (15*4). Ilo�ci te
%               mo�na dowolnie modyfikowa� co te� spowoduje zmian� ilo�ci wierszy.
% 4) mat_droga --> w niej s� zapisane d�ugo�ci wszystkich przebytych dr�g
%               przez mr�wki, kt�re znajduj� si� w zmiennej mat_ant.
% 5) miasta --> zapisane s� w niej informacje o numerze miasta, czyli jego
%               nazwie i po�o�eniu. Kolumna 2 to warto�� x, a 3 kolumna to warto�� y.
% 6) p --> zmienna uzyskiwana/ obliczana w osobnej funkcji
%               GenerowaniePolaczen.m. Znajduj� si� w niej informacje o liczbie
%               porz�dkowej, nazwie (numerze) miasta, nazwie miasta, do kt�rego jest
%               mo�liwo�� p�j�ci przez mr�wk�, ilo�� feromonu, d�ugo�� �cie�ki z jednego
%               miasta do drugiego oraz kolumna pomocnicza o warto�ciach 0. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% zmienna algorytmu mr�wkowego
% ilo�� miast
liczba_miast=5;
% ilo�� mr�wek
liczba_cykli=10;
% ilo�� iteracji -> ile razy grupolaczeniawa mr�wek polaczeniawrzejdzie polaczeniawo mapolaczeniawie
liczba_iteracji=4;
% ilo�� feromonu na mr�wk� 
feromon_na_mrowke=0.2;
% ilo�� feromonu, kt�ra odparowywuje
parowanie_feromonu=0.1;
% ilo�� feromonu na pocz�tku
zerowy_poziom_fer=5;

%% zmienna potrzebne w dalszych obliczeniach
best_droga=Inf;
mat_best_ant=[];
mat_best_droga=[];
iteracja=[];
f=1;
%% losowanie miast na mapie 2D
% zmienna przechowywuj�ca informacje o wsp�rz�dnych miast na mapie
miasta=zeros(liczba_miast,3);
% losowanie po�o�enia miast i rysowanie ich na mapie 2D
figure();
for i=1:liczba_miast
    x=randi([1 100],1,1);
    y=randi([1 100],1,1);
    %liczba porz�dkowa miasta
    miasta(i,1)=i;
    %wsp�rz�dne miast x i y
    miasta(i,2)=x;
    miasta(i,3)=y;
    plot(x,y,'r*');
    text(x,y,num2str(i));
    xlim([-2 102]);
    ylim([-2 102]);
    title('Wylosowane mapy');
    grid on
    hold on
end

%% tworzenie wszytskich mo�liwych polaczeniawo��cze� mi�dzy miastami
% liczba polacze� mi�dzy miastami, je�eli chodzi o jedn� drog�
l=liczba_miast-1;
% liczba wszytskich mo�liwych po��cze� mi�dzy danymi miastami
n=((liczba_miast*(liczba_miast-3))/2)+liczba_miast;
p=GenerowaniePolaczen(l, n, zerowy_poziom_fer, miasta);

%% u�ycie algorytmu mr�wkowego, szukanie opolaczeniawtymalnej drogi
% macierz polaczeniawosiadaj�ca informacj� na temat jak� drog� polaczeniawokona�a konkretna
% mr�wka
mat_ant= zeros(liczba_iteracji*liczba_cykli, liczba_miast);
% macierz polaczeniawosiadaj�ca informacj� na temat d�ugo�ci rogi jak� polaczeniawrzeby�a
% mr�wka
mat_droga= zeros(liczba_cykli*liczba_iteracji,1);

for xx=1:liczba_iteracji % okrsla liczbe iteracji
for cycle=1:liczba_cykli % okresla liczbe mrowek
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

%% rysowanie najlepszej wybranej przez mr�wki drogi
figure()
for i=1:liczba_miast-1
    peirwsze_m=best_ant(i,1);
    drugie_m=best_ant(i+1,1);
    plot(miasta(peirwsze_m,2),miasta(peirwsze_m,3),'gh');
    text(miasta(peirwsze_m,2),miasta(peirwsze_m,3),num2str(peirwsze_m));
    hold on
    plot(miasta(drugie_m,2),miasta(drugie_m,3),'gh');
    text(miasta(drugie_m,2),miasta(drugie_m,3),num2str(drugie_m));
    plot([miasta(peirwsze_m,2) miasta(drugie_m,2)],[miasta(peirwsze_m,3) miasta(drugie_m,3)],'m');
    xlim([-2 102]);
    ylim([-2 102]);
    grid on
    title(['Trasa mi�dzy miastami jak� wybra�y mr�wki. Jej d�ugo�� wynosi: ',num2str(best_droga)]);
end
hold off