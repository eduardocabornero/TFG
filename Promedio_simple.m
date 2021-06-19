clc;
clear all;
close all,
%%Promedio simple
series=[3,10,12,13,12,10,12]
tamanoseries=length(series);
suma=0;
% x=0

% i=0

% for i=0:tamanoy
%     {
%     x=y(i+1)
%     suma=suma+x;
%     }
%  end
%  suma
suma=sum(series)
ypronostico=suma/tamanoseries
yestimado=[series ypronostico]

figure;
plot(series,'b')
hold on
plot(yestimado,'r')
hold off
xlabel('Tiempo')
ylabel('Valor')
title('Promedio simple')
legend( 'yobservado', 'yestimado')