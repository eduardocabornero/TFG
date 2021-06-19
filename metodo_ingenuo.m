clc;
clear all;
close all,
%%Metodo ingenuo
% y=[2,3,4,5];
% tamanoy=length(y)
% yestimado=y(tamanoy)

series=[3,10,12,13,12,10,12]
tamanoseries=length(series);
ypronostico=series(tamanoseries)
yestimado=[series ypronostico]
figure;
plot(series,'b')
hold on
plot(yestimado,'r')
hold off
xlabel('Tiempo')
ylabel('Valor')
title('Método ingenuo')
legend( 'yobservado', 'yestimado')