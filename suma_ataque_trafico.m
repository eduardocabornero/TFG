clc;
clear all;
close all;

addpath('C:\Users\eduar\Desktop\Programa Holt-Winters Python');
trafico=load('serietemporalJunio.txt');

figure;
plot(trafico((3601:4205),2))
hold on;


ataqueDoSAgostoSegundaSemana=load('serietemporalataqueDoSAgosto2Semana.txt');
trafico((3601:4205),2)= trafico((3601:4205),2)+200*ataqueDoSAgostoSegundaSemana((1:605),2);


plot(trafico((3601:4205),2))


f = fopen('traficoconataque.txt','w');
for i = 1:length(trafico)
   fwrite(f,num2str(trafico(i,1)));
   fwrite(f,32);
   fwrite(f,num2str(trafico(i,2)));
   fwrite(f,32);
   fwrite(f,num2str(trafico(i,3)));
   fwrite(f,13);
end


