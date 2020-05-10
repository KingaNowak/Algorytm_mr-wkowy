function varargout = Bionika_KingaNowak_ArturKrasowski_IiAM2(varargin)
% BIONIKA_KINGANOWAK_ARTURKRASOWSKI_IIAM2 MATLAB code for Bionika_KingaNowak_ArturKrasowski_IiAM2.fig
%      BIONIKA_KINGANOWAK_ARTURKRASOWSKI_IIAM2, by itself, creates a new BIONIKA_KINGANOWAK_ARTURKRASOWSKI_IIAM2 or raises the existing
%      singleton*.
%
%      H = BIONIKA_KINGANOWAK_ARTURKRASOWSKI_IIAM2 returns the handle to a new BIONIKA_KINGANOWAK_ARTURKRASOWSKI_IIAM2 or the handle to
%      the existing singleton*.
%
%      BIONIKA_KINGANOWAK_ARTURKRASOWSKI_IIAM2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BIONIKA_KINGANOWAK_ARTURKRASOWSKI_IIAM2.M with the given input arguments.
%
%      BIONIKA_KINGANOWAK_ARTURKRASOWSKI_IIAM2('Property','Value',...) creates a new BIONIKA_KINGANOWAK_ARTURKRASOWSKI_IIAM2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Bionika_KingaNowak_ArturKrasowski_IiAM2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Bionika_KingaNowak_ArturKrasowski_IiAM2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Bionika_KingaNowak_ArturKrasowski_IiAM2

% Last Modified by GUIDE v2.5 09-May-2020 22:09:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Bionika_KingaNowak_ArturKrasowski_IiAM2_OpeningFcn, ...
                   'gui_OutputFcn',  @Bionika_KingaNowak_ArturKrasowski_IiAM2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Bionika_KingaNowak_ArturKrasowski_IiAM2 is made visible.
function Bionika_KingaNowak_ArturKrasowski_IiAM2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Bionika_KingaNowak_ArturKrasowski_IiAM2 (see VARARGIN)

% Choose default command line output for Bionika_KingaNowak_ArturKrasowski_IiAM2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Bionika_KingaNowak_ArturKrasowski_IiAM2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Bionika_KingaNowak_ArturKrasowski_IiAM2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in losuj_miasta.
function losuj_miasta_Callback(hObject, eventdata, handles)
% hObject    handle to losuj_miasta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global liczba_miast
global punkty
global I
global miasta_polozenie

liczba_miast=get(handles.liczba_miast,'String');
try
liczba_miast=round(str2num(liczba_miast));
if liczba_miast>0
    miasta_polozenie=zeros(liczba_miast,3);
    axes(handles.mapa)
    imshow(I); hold on;
    for i=1:liczba_miast
        c=randi(length(punkty)); 
        miasta_polozenie(i,1)= i;
        miasta_polozenie(i,2)= punkty(c,2);
        miasta_polozenie(i,3)= punkty(c,3);
        plot(punkty(c,3),punkty(c,2),'ob','MarkerFaceColor','blue', 'MarkerSize', 5);
        text(punkty(c,3),punkty(c,2),num2str(i),'Color', 'yellow', 'FontSize',14, 'FontWeight','bold');
    end
    set(handles.rozpocznij,'Visible','on');
else
    warndlg('WprowadŸ dodatni¹ liczbê ca³kowit¹ miast!');
end

catch
    
end
% --- Executes on button press in wybierz_mape.
function wybierz_mape_Callback(hObject, eventdata, handles)
% hObject    handle to wybierz_mape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sciezka
global I
global punkty
try
    sciezka = uigetfile({'.jpg'});
    I=im2double(imread(sciezka));
    I=I(:,:,2);
    I=logical(I);
    I=imresize(I,0.5);
    [row, column]=find(I==0);
    pomocnicza=[1:1:length(row)];
    pomocnicza=pomocnicza';
    punkty=[pomocnicza,row,column];
    if sciezka ~= ' '
        set(handles.mapa,'Visible','on');
    end
    axes(handles.mapa)
    imshow(I);
    if sciezka ~= ' '
        set(handles.losuj_miasta,'Visible','on');
    end
catch
    warndlg('Wybierz poprawny plik!');
end


% --- Executes on button press in rozpocznij.
function rozpocznij_Callback(hObject, eventdata, handles)
% hObject    handle to rozpocznij (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global liczba_miast
global punkty
global I
global miasta_polozenie
global liczba_mrowek
global liczba_iteracji
global liczba_feromonu
global liczba_fer_odp
global feromon_poczatek
liczba_mrowek=get(handles.liczba_mrowek,'String');
liczba_iteracji=get(handles.liczba_iteracji,'String');
liczba_feromonu=get(handles.ilosc_feromonu,'String');
liczba_fer_odp=get(handles.ilosc_fer_odp,'String');
feromon_poczatek=get(handles.poziom_zero_fer,'String');
try
    liczba_mrowek=round(str2num(liczba_mrowek));
    liczba_iteracji=round(str2num(liczba_iteracji));
    liczba_feromonu=str2num(liczba_feromonu);
    liczba_fer_odp=str2num(liczba_fer_odp);
    feromon_poczatek=str2num(feromon_poczatek);
    if liczba_mrowek>0
        if liczba_iteracji>0
            if liczba_feromonu>0
                if liczba_fer_odp>0
                    if feromon_poczatek>0
                        if feromon_poczatek>liczba_fer_odp
                            [best_ant, best_droga, mat_ant, mat_droga, p, suma_feromonu_dostepne_polaczenia]=algorytm_mrowkowy(liczba_miast, liczba_mrowek, liczba_iteracji, liczba_feromonu, liczba_fer_odp, feromon_poczatek, miasta_polozenie);
                            set(handles.wynik,'Visible','on');
                            axes(handles.wynik);
                            imshow(I); hold on;
                            tekst='';
                            for i=1:liczba_miast
                                s=num2str(miasta_polozenie(i,1));
                                tekst=[tekst,' --> ', s];
                            end
                            for i=1:liczba_miast-1
                                peirwsze_m=best_ant(i,1);
                                drugie_m=best_ant(i+1,1);
                                plot(miasta_polozenie(peirwsze_m,3),miasta_polozenie(peirwsze_m,2),'ob','MarkerFaceColor','blue', 'MarkerSize', 5);
                                text(miasta_polozenie(peirwsze_m,3),miasta_polozenie(peirwsze_m,2),num2str(peirwsze_m),'Color', 'yellow', 'FontSize',14, 'FontWeight','bold');
                                hold on
                                plot(miasta_polozenie(drugie_m,3),miasta_polozenie(drugie_m,2),'ob','MarkerFaceColor','blue', 'MarkerSize', 5);
                                text(miasta_polozenie(drugie_m,3),miasta_polozenie(drugie_m,2),num2str(drugie_m),'Color', 'yellow', 'FontSize',14, 'FontWeight','bold');
                                plot([miasta_polozenie(peirwsze_m,3) miasta_polozenie(drugie_m,3)],[miasta_polozenie(peirwsze_m,2) miasta_polozenie(drugie_m,2)],'r');
                                
                            end
                            hold off
                            set(handles.info_wyniki,'Visible','on');
                            set(findobj('Tag','info_wyniki'),'String',['Informajce o wynikach: Powy¿ej znajduje siê mapa z wyznaczon¹ optymaln¹ drog¹. Kolejnoœæ przemieszczania siê miêdzy miastami jest nastêpuj¹ca: ', tekst,'.',' D³ugoœæ tej drogi wynosi ', num2str(best_droga),'.',' Pozosta³y feromon na drodze wynosi ',num2str(suma_feromonu_dostepne_polaczenia),'.' ]);
                        else
                            warndlg('Iloœæ feromonu na pocz¹tku drogi musi byæ wiêksza ni¿ iloœæ feromonu jaka odparowywuje!');
                        end
                        
                    else
                        warndlg('WprowadŸ dodatni¹ liczbê iloœci fermonu jaka jest na pocz¹tku obliczeñ trasy!');
                    end
                    
                else
                    warndlg('WprowadŸ dodatni¹ liczbê iloœci fermonu jaka odparowywuje!');
                end
            else
                warndlg('WprowadŸ dodatni¹ liczbê iloœci fermonu jaka przypada na jedn¹ mrówkê!');
            end
        else
            warndlg('WprowadŸ dodatni¹ liczbê ca³kowit¹ iteracji!');
        end
    else
        warndlg('WprowadŸ dodatni¹ liczbê ca³kowit¹ mrówek!');
    end
catch
    warndlg('WprowadŸ poprawne dane! Liczby musz¹ byæ dodatnie');
end


function liczba_miast_Callback(hObject, eventdata, handles)
% hObject    handle to liczba_miast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of liczba_miast as text
%        str2double(get(hObject,'String')) returns contents of liczba_miast as a double


% --- Executes during object creation, after setting all properties.
function liczba_miast_CreateFcn(hObject, ~, handles)
% hObject    handle to liczba_miast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function liczba_mrowek_Callback(hObject, eventdata, handles)
% hObject    handle to liczba_mrowek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of liczba_mrowek as text
%        str2double(get(hObject,'String')) returns contents of liczba_mrowek as a double


% --- Executes during object creation, after setting all properties.
function liczba_mrowek_CreateFcn(hObject, eventdata, handles)
% hObject    handle to liczba_mrowek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function liczba_iteracji_Callback(hObject, eventdata, handles)
% hObject    handle to liczba_iteracji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of liczba_iteracji as text
%        str2double(get(hObject,'String')) returns contents of liczba_iteracji as a double


% --- Executes during object creation, after setting all properties.
function liczba_iteracji_CreateFcn(hObject, eventdata, handles)
% hObject    handle to liczba_iteracji (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ilosc_feromonu_Callback(hObject, eventdata, handles)
% hObject    handle to ilosc_feromonu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ilosc_feromonu as text
%        str2double(get(hObject,'String')) returns contents of ilosc_feromonu as a double


% --- Executes during object creation, after setting all properties.
function ilosc_feromonu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ilosc_feromonu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ilosc_fer_odp_Callback(hObject, eventdata, handles)
% hObject    handle to ilosc_fer_odp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ilosc_fer_odp as text
%        str2double(get(hObject,'String')) returns contents of ilosc_fer_odp as a double


% --- Executes during object creation, after setting all properties.
function ilosc_fer_odp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ilosc_fer_odp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poziom_zero_fer_Callback(hObject, eventdata, handles)
% hObject    handle to poziom_zero_fer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poziom_zero_fer as text
%        str2double(get(hObject,'String')) returns contents of poziom_zero_fer as a double


% --- Executes during object creation, after setting all properties.
function poziom_zero_fer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poziom_zero_fer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
