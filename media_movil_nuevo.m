clc;
clear all;
close all;

%%Media móvil

series=[3,10,12,13,12,10,12]
tamanoseries=length(series);
n=3
suma=0
valoresimportantes=tamanoseries-n+1
for i=valoresimportantes:tamanoseries
    suma=suma+series(i);
end;
ypronostico=suma/n

yestimado=[series ypronostico]

figure;
plot(series,'b')
hold on
plot(yestimado,'r')
hold off
xlabel('Tiempo')
ylabel('Valor')
title('Media móvil')
legend( 'yobservado', 'yestimado')