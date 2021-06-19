clc;
clear all;
close all;

addpath('C:\Users\eduar\Desktop\Programa Holt-Winters Python');
trafico=load('serietemporalJunio.txt');
ataqueDoSAgostoSegundaSemana=load('serietemporalataqueDoSAgosto2Semana.txt');



ventana=30 %%30 minutos
valorventanaseg=30*60
slen=11
numero_periodos=82





y1=load('PrediccionPeriodo0.mat')
y2=load('PrediccionPeriodo1.mat')
y3=load('PrediccionPeriodo2.mat')
y4=load('PrediccionPeriodo3.mat')
y5=load('PrediccionPeriodo4.mat')
y6=load('PrediccionPeriodo5.mat')
y7=load('PrediccionPeriodo6.mat')
y8=load('PrediccionPeriodo7.mat')
y9=load('PrediccionPeriodo8.mat')
y10=load('PrediccionPeriodo9.mat')
y11=load('PrediccionPeriodo10.mat')
y12=load('PrediccionPeriodo11.mat')
y13=load('PrediccionPeriodo12.mat')
y14=load('PrediccionPeriodo13.mat')
y15=load('PrediccionPeriodo14.mat')
y16=load('PrediccionPeriodo15.mat')
y17=load('PrediccionPeriodo16.mat')
y18=load('PrediccionPeriodo17.mat')
y19=load('PrediccionPeriodo18.mat')
y20=load('PrediccionPeriodo19.mat')
y21=load('PrediccionPeriodo20.mat')
y22=load('PrediccionPeriodo21.mat')
y23=load('PrediccionPeriodo22.mat')
y24=load('PrediccionPeriodo23.mat')
y25=load('PrediccionPeriodo24.mat')
y26=load('PrediccionPeriodo25.mat')
y27=load('PrediccionPeriodo26.mat')
y28=load('PrediccionPeriodo27.mat')
y29=load('PrediccionPeriodo28.mat')
y30=load('PrediccionPeriodo29.mat')
y31=load('PrediccionPeriodo30.mat')
y32=load('PrediccionPeriodo31.mat')
y33=load('PrediccionPeriodo32.mat')
y34=load('PrediccionPeriodo33.mat')
y35=load('PrediccionPeriodo34.mat')
y36=load('PrediccionPeriodo35.mat')
y37=load('PrediccionPeriodo36.mat')
y38=load('PrediccionPeriodo37.mat')
y39=load('PrediccionPeriodo38.mat')
y40=load('PrediccionPeriodo39.mat')
y41=load('PrediccionPeriodo40.mat')
y42=load('PrediccionPeriodo41.mat')
y43=load('PrediccionPeriodo42.mat')
y44=load('PrediccionPeriodo43.mat')
y45=load('PrediccionPeriodo44.mat')
y46=load('PrediccionPeriodo45.mat')
y47=load('PrediccionPeriodo46.mat')
y48=load('PrediccionPeriodo47.mat')
y49=load('PrediccionPeriodo48.mat')
y50=load('PrediccionPeriodo49.mat')
y51=load('PrediccionPeriodo50.mat')
y52=load('PrediccionPeriodo51.mat')
y53=load('PrediccionPeriodo52.mat')
y54=load('PrediccionPeriodo53.mat')
y55=load('PrediccionPeriodo54.mat')
y56=load('PrediccionPeriodo55.mat')
y57=load('PrediccionPeriodo56.mat')
y58=load('PrediccionPeriodo57.mat')
y59=load('PrediccionPeriodo58.mat')
y60=load('PrediccionPeriodo59.mat')
y61=load('PrediccionPeriodo60.mat')
y62=load('PrediccionPeriodo61.mat')
y63=load('PrediccionPeriodo62.mat')
y64=load('PrediccionPeriodo63.mat')
y65=load('PrediccionPeriodo64.mat')
y66=load('PrediccionPeriodo65.mat')
y67=load('PrediccionPeriodo66.mat')
y68=load('PrediccionPeriodo67.mat')
y69=load('PrediccionPeriodo68.mat')
y70=load('PrediccionPeriodo69.mat')
y71=load('PrediccionPeriodo70.mat')
y72=load('PrediccionPeriodo71.mat')
y73=load('PrediccionPeriodo72.mat')
y74=load('PrediccionPeriodo73.mat')
y75=load('PrediccionPeriodo74.mat')
y76=load('PrediccionPeriodo75.mat')
y77=load('PrediccionPeriodo76.mat')
y78=load('PrediccionPeriodo77.mat')
y79=load('PrediccionPeriodo78.mat')
y80=load('PrediccionPeriodo79.mat')
y81=load('PrediccionPeriodo80.mat')
y82=load('PrediccionPeriodo81.mat')

prediccion=[y1.prediccion_definitiva y2.prediccion_definitiva y3.prediccion_definitiva y4.prediccion_definitiva y5.prediccion_definitiva y6.prediccion_definitiva y7.prediccion_definitiva y8.prediccion_definitiva y9.prediccion_definitiva y10.prediccion_definitiva y11.prediccion_definitiva y12.prediccion_definitiva y13.prediccion_definitiva y14.prediccion_definitiva y15.prediccion_definitiva y16.prediccion_definitiva y17.prediccion_definitiva y18.prediccion_definitiva y19.prediccion_definitiva y20.prediccion_definitiva y21.prediccion_definitiva y22.prediccion_definitiva y23.prediccion_definitiva y24.prediccion_definitiva y25.prediccion_definitiva y26.prediccion_definitiva y27.prediccion_definitiva y28.prediccion_definitiva y29.prediccion_definitiva y30.prediccion_definitiva y31.prediccion_definitiva y32.prediccion_definitiva y33.prediccion_definitiva y34.prediccion_definitiva y35.prediccion_definitiva y36.prediccion_definitiva y37.prediccion_definitiva y38.prediccion_definitiva y39.prediccion_definitiva y40.prediccion_definitiva y41.prediccion_definitiva y42.prediccion_definitiva y43.prediccion_definitiva y44.prediccion_definitiva y45.prediccion_definitiva y46.prediccion_definitiva y47.prediccion_definitiva y48.prediccion_definitiva y49.prediccion_definitiva y50.prediccion_definitiva y51.prediccion_definitiva y52.prediccion_definitiva y53.prediccion_definitiva y54.prediccion_definitiva y55.prediccion_definitiva y56.prediccion_definitiva y57.prediccion_definitiva y58.prediccion_definitiva y59.prediccion_definitiva y60.prediccion_definitiva y61.prediccion_definitiva y62.prediccion_definitiva y63.prediccion_definitiva y64.prediccion_definitiva y65.prediccion_definitiva y66.prediccion_definitiva y67.prediccion_definitiva y68.prediccion_definitiva y69.prediccion_definitiva y70.prediccion_definitiva y71.prediccion_definitiva y72.prediccion_definitiva y73.prediccion_definitiva y74.prediccion_definitiva y75.prediccion_definitiva y76.prediccion_definitiva y77.prediccion_definitiva y78.prediccion_definitiva y79.prediccion_definitiva y80.prediccion_definitiva y81.prediccion_definitiva y82.prediccion_definitiva];
prediccion=prediccion';
traficobits=trafico((3601:3601+901),2);
error=abs(traficobits-prediccion);
error_medio=mean(error)

figure;
plot(trafico((3601:3601+902),2),'g')
axis([0 inf 0 inf])
hold on;
plot(prediccion,'r')
hold on;
plot(error,'b')
xlabel ('Segundos')
ylabel('Bits por segundo')
str=sprintf('Primeros 15 minutos(%d periodos) de la tercera ventana Slen=%d ventana=30 minutos errormedio=%d',numero_periodos,slen,error_medio)
title(str)
legend( 'realidad+ ataque', 'prediccion con ataque','error')



