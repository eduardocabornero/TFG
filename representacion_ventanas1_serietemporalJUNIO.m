clc;
clear all;
close all;
%addpath('C:\Users\eduar\OneDrive\Documentos\MATLAB\Proyecto_TSM\TFG\eric');
addpath('C:\Users\eduar\Desktop\Holt-Winters-TFG');
grafica=load('serietemporalJunio.txt')

PrediccionPrimerperiodoSlen10Vent30=load('PrediccionPrimerperiodoSlen10Vent30.mat')
PrediccionPrimerperiodoSlen11Vent30=load('PrediccionPrimerperiodoSlen11Vent30.mat')
PrediccionPrimerperiodoSlen10Vent15=load('PrediccionPrimerperiodoSlen10Vent15.mat')
PrediccionPrimerperiodoSlen11Vent15=load('PrediccionPrimerperiodoSlen11Vent15.mat')

PrediccionSegundoperiodoSlen10Vent30=load('PrediccionSegundoperiodoSlen10Vent30.mat')
PrediccionSegundoperiodoSlen11Vent30=load('PrediccionSegundoperiodoSlen11Vent30.mat')
PrediccionSegundoperiodoSlen10Vent15=load('PrediccionSegundoperiodoSlen10Vent15.mat')
PrediccionSegundoperiodoSlen11Vent15=load('PrediccionSegundoperiodoSlen11Vent15.mat')

PrediccionTercerperiodoSlen10Vent30=load('PrediccionTercerperiodoSlen10Vent30.mat')
PrediccionTercerperiodoSlen11Vent30=load('PrediccionTercerperiodoSlen11Vent30.mat')
PrediccionTercerperiodoSlen10Vent15=load('PrediccionTercerperiodoSlen10Vent15.mat')
PrediccionTercerperiodoSlen11Vent15=load('PrediccionTercerperiodoSlen11Vent15.mat')


PrediccionCuartoperiodoSlen10Vent30=load('PrediccionCuartoperiodoSlen10Vent30.mat')
PrediccionCuartoperiodoSlen11Vent30=load('PrediccionCuartoperiodoSlen11Vent30.mat')
PrediccionCuartoperiodoSlen10Vent15=load('PrediccionCuartoperiodoSlen10Vent15.mat')
PrediccionCuartoperiodoSlen11Vent15=load('PrediccionCuartoperiodoSlen11Vent15.mat')

PrediccionQuintoperiodoSlen10Vent30=load('PrediccionQuintoperiodoSlen10Vent30.mat')
PrediccionQuintoperiodoSlen11Vent30=load('PrediccionQuintoperiodoSlen11Vent30.mat')
PrediccionQuintoperiodoSlen11Vent15=load('PrediccionQuintoperiodoSlen11Vent15.mat')


PrediccionSextoperiodoSlen10Vent30=load('PrediccionSextoperiodoSlen10Vent30.mat')
PrediccionSextoperiodoSlen11Vent30=load('PrediccionSextoperiodoSlen11Vent30.mat')



PrediccionSeptimoperiodoSlen11Vent30=load('PrediccionSeptimoperiodoSlen11Vent30.mat')




%%PRIMERA VENTANA
%%Primero representamos bits por segundo
ventana=5
slen=10
valorventanaseg=ventana*60

x=grafica(1:valorventanaseg,1);
y=grafica(1:valorventanaseg,3);
figure;
plot(y);
xlabel('Tiempo')
ylabel('Paquetesporsegundo')
title('Primera ventana paquetes por segundo')
%%SEGUNDA VENTANA
x2=grafica(valorventanaseg+1:(2*valorventanaseg),1);
y2=grafica(valorventanaseg+1:(2*valorventanaseg),3);
figure;
plot(y2);
xlabel('Tiempo')
ylabel('Paquetesporsegundo')
title('Segunda ventana paquetes por segundo con ventanas de 5 minutos')


%%SLEN=10 VENTANA=15min


y3=grafica(2*valorventanaseg+0*slen+1:(2*valorventanaseg+1*slen),2);
y4=PrediccionPrimerperiodoSlen10Vent15
figure
plot(y3,'g')
axis([0 inf 0 inf])
hold on;
plot(y4.prediccion,'r')
hold on;
plot(abs(y3-y4.prediccion),'b')
axis([0 inf 0 inf])
xlabel ('Segundos')
ylabel('Valor')
title('Primer periodo tercera temporada ventana=15 slen=10')
legend( 'realidad', 'prediccion','error')

y5=grafica(2*valorventanaseg+1*slen+1:(2*valorventanaseg+2*slen),2);
y6=PrediccionSegundoperiodoSlen10Vent15

figure
plot(y5,'g')
axis([0 inf 0 inf])
hold on;
plot(y6.prediccion,'r')
hold on;
plot(abs(y5-y6.prediccion),'b')
axis([0 inf 0 inf])
xlabel ('Segundos')
ylabel('Valor')
title('Segundo periodo tercera temporada ventana=15 slen=10')
legend( 'realidad', 'prediccion','error')

y7=grafica(2*valorventanaseg+2*slen+1:(2*valorventanaseg+3*slen),2);
y8=PrediccionTercerperiodoSlen10Vent15
figure
plot(y7,'g')
axis([0 inf 0 inf])
hold on;
plot(y8.prediccion,'r')
hold on;
plot(abs(y7-y8.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Tercer periodo tercera temporada ventana=15 slen=10')
legend( 'realidad', 'prediccion','error')

y9=grafica(2*valorventanaseg+3*slen+1:(2*valorventanaseg+4*slen),2);
y10=PrediccionCuartoperiodoSlen10Vent15
figure
plot(y9,'g')
axis([0 inf 0 inf])
hold on;
plot(y10.prediccion,'r')
hold on;
plot(abs(y9-y10.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Cuarto periodo tercera temporada ventana=15 slen=10')
legend( 'realidad', 'prediccion','error')

%%REPRESENTACION ENTERA SLEN=10 VENTANA=15
completa_prediccion=[y4.prediccion' y6.prediccion' y8.prediccion' y10.prediccion']
completa_prediccion=completa_prediccion'
completa=grafica(2*valorventanaseg+0*slen+1:(2*valorventanaseg+4*slen),2);

figure;
plot(completa,'g')
axis([0 inf 0 inf])
hold on;
plot(completa_prediccion,'r')
hold on;
plot(abs(completa-completa_prediccion),'b')
xlabel ('Segundos')
ylabel('Bits por segundo')
title('Primeros 4 periodos tercera ventana usando ventanas de 15 minutos y período 10  ')
legend( 'realidad', 'prediccion','error')






%%%SLEN=11 VENTANA=15
slen=11

y11=grafica(2*valorventanaseg+0*slen+1:(2*valorventanaseg+1*slen),2);
y12=PrediccionPrimerperiodoSlen11Vent15
figure
plot(y11,'g')
%axis([0 inf 0 inf])
hold on;
plot(y12.prediccion,'r')
hold on;
plot(abs(y11-y12.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Primer periodo tercera temporada ventana=15 slen=11')
legend( 'realidad', 'prediccion','error')

y13=grafica(2*valorventanaseg+1*slen+1:(2*valorventanaseg+2*slen),2);
y14=PrediccionSegundoperiodoSlen11Vent15
figure
plot(y13,'g')
axis([0 inf 0 inf])
hold on;
plot(y14.prediccion,'r')
hold on;
plot(abs(y13-y14.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Segundo periodo tercera temporada ventana=15 slen=11')
legend( 'realidad', 'prediccion','error')

y15=grafica(2*valorventanaseg+2*slen+1:(2*valorventanaseg+3*slen),2);
y16=PrediccionTercerperiodoSlen11Vent15
figure
plot(y15,'g')
axis([0 inf 0 inf])
hold on;
plot(y16.prediccion,'r')
hold on;
plot(abs(y15-y16.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Tercer periodo tercera temporada ventana=15 slen=11')
legend( 'realidad', 'prediccion','error')

y17=grafica(2*valorventanaseg+3*slen+1:(2*valorventanaseg+4*slen),2);
y18=PrediccionCuartoperiodoSlen11Vent15
figure
plot(y17,'g')
axis([0 inf 0 inf])
hold on;
plot(y18.prediccion,'r')
hold on;
plot(abs(y17-y18.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Cuarto periodo tercera temporada ventana=15 slen=11')
legend( 'realidad', 'prediccion','error')


y19=grafica(2*valorventanaseg+4*slen+1:(2*valorventanaseg+5*slen),2);
y20=PrediccionQuintoperiodoSlen11Vent15
figure
plot(y19,'g')
axis([0 inf 0 inf])
hold on;
plot(y20.prediccion,'r')
hold on;
plot(abs(y19-y20.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Quinto periodo tercera temporada ventana=15 slen=11')
legend( 'realidad', 'prediccion','error')


%%REPRESENTACION ENTERA SLEN=11 VENTANA=15
completa_prediccion=[y12.prediccion' y14.prediccion' y16.prediccion' y18.prediccion' y20.prediccion']
completa_prediccion=completa_prediccion'
completa=grafica(2*valorventanaseg+0*slen+1:(2*valorventanaseg+5*slen),2);

figure;
plot(completa,'g')
axis([0 inf 0 inf])
hold on;
plot(completa_prediccion,'r')
hold on;
plot(abs(completa-completa_prediccion),'b')
xlabel ('Segundos')
ylabel('Bits por segundo')
title('Primeros 5 periodos tercera usando ventanas de 15 minutos y período 11 ')
legend( 'realidad', 'prediccion','error')




%%SLEN=10 VENTANA=30MIN
slen=10
ventana=30
valorventanaseg=ventana*60

y21=grafica(2*valorventanaseg+0*slen+1:(2*valorventanaseg+1*slen),2);
y22=PrediccionPrimerperiodoSlen10Vent30
figure
plot(y21,'g')
axis([0 inf 0 inf])
hold on;
plot(y22.prediccion,'r')
hold on;
plot(abs(y21-y22.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Primer periodo tercera temporada ventana=30 slen=10')
legend( 'realidad', 'prediccion','error')


y23=grafica(2*valorventanaseg+1*slen+1:(2*valorventanaseg+2*slen),2);
y24=PrediccionSegundoperiodoSlen10Vent30
figure
plot(y23,'g')
axis([0 inf 0 inf])
hold on;
plot(y24.prediccion,'r')
hold on;
plot(abs(y23-y24.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Segundo periodo tercera temporada ventana=30 slen=10')
legend( 'realidad', 'prediccion','error')

y25=grafica(2*valorventanaseg+2*slen+1:(2*valorventanaseg+3*slen),2);
y26=PrediccionTercerperiodoSlen10Vent30
figure
plot(y25,'g')
axis([0 inf 0 inf])
hold on;
plot(y26.prediccion,'r')
hold on;
plot(abs(y25-y26.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Tercer periodo tercera temporada ventana=30 slen=10')
legend( 'realidad', 'prediccion','error')


y27=grafica(2*valorventanaseg+3*slen+1:(2*valorventanaseg+4*slen),2);
y28=PrediccionCuartoperiodoSlen10Vent30
figure
plot(y27,'g')
axis([0 inf 0 inf])
hold on;
plot(y28.prediccion,'r')
hold on;
plot(abs(y27-y28.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Cuarto periodo tercera temporada ventana=30 slen=10')
legend( 'realidad', 'prediccion','error')

y29=grafica(2*valorventanaseg+4*slen+1:(2*valorventanaseg+5*slen),2);
y30=PrediccionQuintoperiodoSlen10Vent30
figure
plot(y29,'g')
axis([0 inf 0 inf])
hold on;
plot(y30.prediccion,'r')
hold on;
plot(abs(y29-y30.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Quinto periodo tercera temporada ventana=30 slen=10')
legend( 'realidad', 'prediccion','error')

y31=grafica(2*valorventanaseg+5*slen+1:(2*valorventanaseg+6*slen),2);
y32=PrediccionSextoperiodoSlen10Vent30
figure
plot(y31,'g')
axis([0 inf 0 inf])
hold on;
plot(y32.prediccion,'r')
hold on;
plot(abs(y31-y32.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Sexto periodo tercera temporada ventana=30 slen=10')
legend( 'realidad', 'prediccion','error')


%%REPRESENTACION ENTERA SLEN=10 VENTANA=30
completa_prediccion=[y22.prediccion' y24.prediccion' y26.prediccion' y28.prediccion' y30.prediccion' y32.prediccion']
completa_prediccion=completa_prediccion'
completa=grafica(2*valorventanaseg+0*slen+1:(2*valorventanaseg+6*slen),2);

figure;
plot(completa,'g')
axis([0 inf 0 inf])
hold on;
plot(completa_prediccion,'r')
hold on;
plot(abs(completa-completa_prediccion),'b')
xlabel ('Segundos')
ylabel('Bits por segundo')
title('Primeros 6 periodos tercera ventana usando ventanas de 30 minutos y período 10 ')
legend( 'realidad', 'prediccion','error')



















%%SLEN=11 VENTANA=30MIN

slen=11 

y33=grafica(2*valorventanaseg+0*slen+1:(2*valorventanaseg+1*slen),2);
y34=PrediccionPrimerperiodoSlen11Vent30
figure
plot(y33,'g')
axis([0 inf 0 inf])
hold on;
plot(y34.prediccion,'r')
hold on;
plot(abs(y33-y34.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Primer periodo tercera temporada ventana=30 slen=11')
legend( 'realidad', 'prediccion','error')

y35=grafica(2*valorventanaseg+1*slen+1:(2*valorventanaseg+2*slen),2);
y36=PrediccionSegundoperiodoSlen11Vent30
figure
plot(y35,'g')
axis([0 inf 0 inf])
hold on;
plot(y36.prediccion,'r')
hold on;
plot(abs(y35-y36.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Segundo periodo tercera temporada ventana=30 slen=11')
legend( 'realidad', 'prediccion','error')

y37=grafica(2*valorventanaseg+2*slen+1:(2*valorventanaseg+3*slen),2);
y38=PrediccionTercerperiodoSlen11Vent30
figure
plot(y37,'g')
axis([0 inf 0 inf])
hold on;
plot(y38.prediccion,'r')
hold on;
plot(abs(y37-y38.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Tercer periodo tercera temporada ventana=30 slen=11')
legend( 'realidad', 'prediccion','error')

y39=grafica(2*valorventanaseg+3*slen+1:(2*valorventanaseg+4*slen),2);
y40=PrediccionCuartoperiodoSlen11Vent30
figure
plot(y39,'g')
axis([0 inf 0 inf])
hold on;
plot(y40.prediccion,'r')
hold on;
plot(abs(y39-y40.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Cuarto periodo tercera temporada ventana=30 slen=11')
legend( 'realidad', 'prediccion','error')

y41=grafica(2*valorventanaseg+4*slen+1:(2*valorventanaseg+5*slen),2);
y42=PrediccionQuintoperiodoSlen11Vent30
figure
plot(y41,'g')
axis([0 inf 0 inf])
hold on;
plot(y42.prediccion,'r')
hold on;
plot(abs(y41-y42.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Quinto periodo tercera temporada ventana=30 slen=11')
legend( 'realidad', 'prediccion','error')

y43=grafica(2*valorventanaseg+5*slen+1:(2*valorventanaseg+6*slen),2);
y44=PrediccionSextoperiodoSlen11Vent30
figure
plot(y43,'g')
axis([0 inf 0 inf])
hold on;
plot(y44.prediccion,'r')
hold on;
plot(abs(y43-y44.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Sexto periodo tercera temporada ventana=30 slen=11')
legend( 'realidad', 'prediccion','error')

y45=grafica(2*valorventanaseg+6*slen+1:(2*valorventanaseg+7*slen),2);
y46=PrediccionSeptimoperiodoSlen11Vent30
figure
plot(y45,'g')
axis([0 inf 0 inf])
hold on;
plot(y46.prediccion,'r')
hold on;
plot(abs(y45-y46.prediccion),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Septimo periodo tercera temporada ventana=30 slen=11')
legend( 'realidad', 'prediccion','error')



%%REPRESENTACION ENTERA SLEN=11 VENTANA=30
completa_prediccion=[y34.prediccion' y36.prediccion' y38.prediccion' y40.prediccion' y42.prediccion' y44.prediccion' y46.prediccion']
completa_prediccion=completa_prediccion'
completa=grafica(2*valorventanaseg+0*slen+1:(2*valorventanaseg+7*slen),2);

figure;
plot(completa,'g')
axis([0 inf 0 inf])
hold on;
plot(completa_prediccion,'r')
hold on;
plot(abs(completa-completa_prediccion),'b')
xlabel ('Segundos')
ylabel('Bits por segundo')
title('Primeros 7 periodos tercera ventana usando ventanas de 30 minutos y período 11 ')
legend( 'realidad', 'prediccion','error')



%%% Octavo período tercera ventana
y47=grafica(2*valorventanaseg+7*slen+1:(2*valorventanaseg+8*slen),2);
PrediccionOctavoperiodoSlen11Vent30=load('PrediccionOctavoperiodoSlen11Vent30.mat')
y48=PrediccionOctavoperiodoSlen11Vent30
figure
plot(y47,'g')
axis([0 inf 0 inf])
hold on;
plot(y48.prediccion_definitiva,'r')
hold on;
plot(abs(y47-y48.prediccion_definitiva),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Octavo periodo tercera temporada ventana=30 slen=11')
legend( 'realidad', 'prediccion','error')



%%% Noveno período tercera ventana
y49=grafica(2*valorventanaseg+8*slen+1:(2*valorventanaseg+9*slen),2);
PrediccionNovenoperiodoSlen11Vent30=load('PrediccionNovenoperiodoSlen11Vent30.mat')
y50=PrediccionOctavoperiodoSlen11Vent30
figure
plot(y49,'g')
axis([0 inf 0 inf])
hold on;
plot(y50.prediccion_definitiva,'r')
hold on;
plot(abs(y49-y50.prediccion_definitiva),'b')
xlabel ('Segundos')
ylabel('Valor')
title('Noveno periodo tercera temporada ventana=30 slen=11')
legend( 'realidad', 'prediccion','error')
