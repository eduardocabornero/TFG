clc;
clear all;
close all;



% y= [30,21,29,31,40,48,53,47,37,39,31,29,17,9,20,24,27,35,41,38,27,31,27,26,21,13,21,18,33,35,40,36,22,24,21,20,17,14,17,19,26,29,40,31,20,24,18,26,17,9,17,21,28,32,46,33,23,28,22,27,18,8,17,21,31,34,44,38,31,30,26,32]
% resultado=y(1)
addpath('C:\Users\eduar\OneDrive\Documentos\MATLAB\Proyecto_TSM\TFG\eric');
f = [30,21,29,31,40,48,53,47,37,39,31,29,17,9,20,24,27,35,41,38,27,31,27,26,21,13,21,18,33,35,40,36,22,24,21,20,17,14,17,19,26,29,40,31,20,24,18,26,17,9,17,21,28,32,46,33,23,28,22,27,18,8,17,21,31,34,44,38,31,30,26,32]

grafica=load('serietemporalJunio.txt')

%%Primero representamos bits por segundo
f=grafica





%periodo=f_get_period(series)
% f=1;
% t=0:0.01:1;
% y=sin(2*pi*f*t);
% plot(t,y);
% periodo=f_get_period(y)
 %n=length(f)
T0=12%%Estimacion inicial del periodo
t1= 1%%Frecuencia de muestreo
t=1%%Cada segundo
sp=0
nsp=0 
Sf=0


Ni=floor((7/8)*(T0/t1)) 
Nf=ceil((7/6)*(T0/t1)) 

for n=Ni:Nf
for i = 1 : n 
if f(n+i)<=f(i+1) && f(n+i)>=f(i) || f(n+i)>= f(i+1) && f(n+i) <= f(i)                 
    sp=sp + 1           
else
    nsp=nsp + 1           
end;
     Sf(n)=(sp - nsp)/n 
end;
end;
     
if max(Sf)>=0.0         
    m=find(Sf==max(Sf)); %%Te encuentra los indices que cumplen la condición     
    Testimado=(m + 0.5)*t1 
else
     print("Insufficient data") 
end; 
