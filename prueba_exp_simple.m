clc;
clear all;
close all;
addpath('C:\Users\eduar\OneDrive\Documentos\MATLAB\Proyecto_TSM\TFG\eric');
y= [3,10,12,13,12,10,12]
tamanoy=length(y);

salidaexpnorm=0
 estimacion=0;
 alpha=0.1;
 %salida1=0;
 %alpha=0.125
 for j=1:tamanoy
     estimacion=alpha*y(j)+(1-alpha)*estimacion;
     salidaexpnorm(j)=estimacion;
 end
 
 figure;
 plot(y,'r');
 hold on;
 plot(salidaexpnorm,'g');
 hold off;
 xlabel('Tiempo')
 ylabel('Valor')
 title('Suavizado exp simple alpha=0.1')
 legend('y','salidaexpnorm(alpha=0.1)');