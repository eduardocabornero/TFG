clc;
clear all;
close all,
%%Media movil ponderada
% y=[2,3,4,5];
% Pesos=[0.1,0.2,0.3,0.4]
% tamanoy=length(y)
% valor=0
% yestimado=zeros(1,tamanoy)
% 
% for i=1:tamanoy
%     yestimado(i)= y(i)*Pesos(i)
% end
% % for j=2:(tamanoy+1)
% %     ytotal(j-1)=ytotal(j-1)+yestimado(j-1)
% % end
% % for j=1:tamanoy
% %     ytotal(j)=yestimado(j)+ytotal(j-1)
% % end
% valor=sum(yestimado)
% valorestimadosiguiente=valor/tamanoy

series=[3,10,12,13,12,10,12]
pesos=[0.1,0.2,0.3,0.4]
tamanoseries=length(series);
tamanopesos=length(pesos);
ypronostico=0

for i=tamanopesos:tamanoseries
    ypronostico=ypronostico+pesos(i-3)*series(i)
end;


% ypronostico=series(tamanoseries)
yestimado=[series ypronostico]
figure;
plot(series,'b')
hold on
plot(yestimado,'r')
hold off
xlabel('Tiempo')
ylabel('Valor')
title('Media móvil ponderada')
legend( 'yobservado', 'yestimado')