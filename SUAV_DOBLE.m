clc;
clear all;
close all;
addpath('C:\Users\eduar\OneDrive\Documentos\MATLAB\Proyecto_TSM\TFG\eric');
y= [3,10,12,13,12,10,12];
tamanoy=length(y);

alpha=0.5;
beta=0.3;
nivel(1)=y(1);
b(1)=y(2)-y(1);
for j=2:tamanoy
     %salidanivelantiguo=salidanivel;
     nivel(j)=alpha*y(j)+(1-alpha)*(nivel(j-1)+ b(j-1));
     %nivel(j)=salidanivel
     
     b(j)=beta*(nivel(j)-nivel(j-1))+ (1-beta)* b(j-1);
     %b(j)=salidab
     
    salida1(j+1)=nivel(j)+b(j);
end
pronostico=[salida1(3) salida1(4) salida1(5) salida1(6) salida1(7) salida1(8)]
 salidafinal=[y(1) pronostico]
figure;
plot(y,'r');
 hold on;
 plot(salidafinal,'g');
 hold off;
 xlabel('Tiempo')
 ylabel('Valor')
 title('Suavizado exp doble alpha=0.5 beta=0.3')
 legend('y','salidasuavexpdoble(alpha=0.5,beta=0.3)');