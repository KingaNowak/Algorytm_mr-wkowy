%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autorzy: Kinga Nowak i Artur Krasowski IiAM 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function polaczenia=GenerowaniePolaczen(liczba_pozotsalych_punktow, liczba_wszytskich_polaczen, poziom_zero_feromon, mapa )

    polaczenia=zeros(liczba_wszytskich_polaczen,6);
    feromon=poziom_zero_feromon;
    zmienna_pomocnicza=1;
    for i=1:liczba_pozotsalych_punktow
        for j=1:(liczba_pozotsalych_punktow+1-i)
            polaczenia(zmienna_pomocnicza,1)=zmienna_pomocnicza;
            polaczenia(zmienna_pomocnicza,2)=i;
            polaczenia(zmienna_pomocnicza,3)=j+i;
            polaczenia(zmienna_pomocnicza,4)=feromon;
            polaczenia(zmienna_pomocnicza,5)=sqrt((mapa(polaczenia(zmienna_pomocnicza,2),2)-mapa(polaczenia(zmienna_pomocnicza,3),2))^2+(mapa(polaczenia(zmienna_pomocnicza,2),3)-mapa(polaczenia(zmienna_pomocnicza,3),3))^2);
            polaczenia(zmienna_pomocnicza,6)=0;
            zmienna_pomocnicza=zmienna_pomocnicza+1;
        end
    end
    clear zmienna_pomocnicza
end