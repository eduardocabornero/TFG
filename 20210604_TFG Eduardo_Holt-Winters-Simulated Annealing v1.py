import numpy as np
from math import *
from scipy.io import savemat
from random import *
import time
from datetime import datetime, timedelta

NO = 0
SI = 1

def initial_trend(series, slen):
    sum = 0.0
    for i in range(slen):
        sum += float(series[i+slen] - series[i]) / slen
    return sum / slen



def initial_seasonal_components(series, slen):
    seasonals = {}
    season_averages = []
    n_seasons = int(len(series)/slen)
    # compute season averages
    for j in range(n_seasons):
        season_averages.append(sum(series[slen*j:slen*j+slen])/float(slen))
    # compute initial values
    for i in range(slen):
        sum_of_vals_over_avg = 0.0
        for j in range(n_seasons):
            sum_of_vals_over_avg += series[slen*j+i]-season_averages[j]
        seasonals[i] = sum_of_vals_over_avg/n_seasons
    return seasonals



def triple_exponential_smoothing(series, slen, alpha, beta, gamma, n_preds):
    result = []
    seasonals = initial_seasonal_components(series, slen)
    for i in range(len(series)+n_preds):
        if i == 0: # initial values
            smooth = series[0]
            trend = initial_trend(series, slen)
            result.append(series[0])
            continue
        if i >= len(series): # we are forecasting
            m = i - len(series) + 1
            result.append((smooth + m*trend) + seasonals[i%slen])
        else:
            val = series[i]
            last_smooth, smooth = smooth, alpha*(val-seasonals[i%slen]) + (1-alpha)*(smooth+trend)
            trend = beta * (smooth-last_smooth) + (1-beta)*trend
            seasonals[i%slen] = gamma*(val-smooth) + (1-gamma)*seasonals[i%slen]
            result.append(smooth+trend+seasonals[i%slen])
    return result


#------------------------------------------------------------------------------------------------------------
#
#  Holt-Winters: El algoritmo Holt-Winters también conocido como suavizado exponencial triple es um método
#                para pronosticar un número de puntos de una serie estacional teniendo en cuenta la duración 
#                de la temporada, la tendencia y el nivel. Su mayor ventaja frente al suavizado exponencial
#                simple y doble es que este método nos permite pronosticar muchos más puntos que estos dos 
#                métodos.
#
#------------------------------------------------------------------------------------------------------------                                               


bits_por_segundo=1
paquetes_por_segundo=2
data = np.loadtxt('traficoconataque.txt', delimiter=' ')

#Definición de parámetros para la predicción
ventana=30   ##Duracion de la ventana en minutos
valorventanaseg=ventana*60   ##Duracion de la ventana en segundos
slen=11
n_preds =11 ##Para predecir 10 minutos
numero_de_periodos=82
diferencia_minima=3e8
precision=int(1e2)

debug = NO

t0 = time.time()

for periodo in range(0,numero_de_periodos):
    if debug == SI : print("Periodo: ",periodo)      
    ###Creamos un array del tamaño de la serie que queremos pasar para calcular la predicción
    series = np.zeros((valorventanaseg))
    j=0 ##Índice auxiliar
    ##Carga de los datos para la predicción: La predicción se hace a partir del principio de la segunda ventana
    #Es necesario desplazar el inicio de la ventana en funcion del periodo que estamos calculando
    for i in range(valorventanaseg+periodo*slen,2*valorventanaseg+periodo*slen) :##Hay que cambiar lo que multiplica po slen 
        series[j]=data[i,bits_por_segundo]
        j=j+1
    valores=np.zeros(slen)    
    k=0 #Indice auxiliar        
    for i in range(2*valorventanaseg+periodo*slen,2*valorventanaseg+periodo*slen+slen):
        valores[k]=data[i,bits_por_segundo]
        k=k+1
    ##Busqueda de los valores optimos de alpha beta y gamma
    diferencia_actual = diferencia_minima
    menor_diferencia = diferencia_actual
    for T in np.linspace(1000,0,precision):
                #Generación de un punto aleatorio 
                alpha = random()
                beta = random()
                gamma = random()
                result = triple_exponential_smoothing(series, slen, alpha, beta, gamma, n_preds)

                #Nos quedamos  con los datos del período predicho
                prediccion=np.array(np.array(result[valorventanaseg:]))
                diferencia=[0]*n_preds
           
                #Calculo del error que se comente en la prediccion
                diferencia=[0]*n_preds
                for indice in range(n_preds):  
                    diferencia[indice]=abs(prediccion[indice]-valores[indice]) ##METODO MAX
                distancia=max(diferencia)
                
           
                # Si el error es menor, nos quedamos con el nuevo punto
                if( (distancia<diferencia_actual) or
                  # Si el error es mayor con probabilidad cada vez menor se elige el nuevo punto para
                  # evitar mínimos locales
                  ( (distancia>diferencia_actual)and (exp((T-1000)/100) > random()) )   ):
                    diferencia_actual=distancia
                    alpha_actual=alpha
                    beta_actual=beta
                    gamma_actual=gamma
                    prediccion_definitiva=prediccion
                    if diferencia_actual < menor_diferencia :
                        menor_diferencia = diferencia_actual
                        alpha_definitivo = alpha_actual
                        beta_definitivo = beta_actual
                        gamma_definitivo = gamma_actual 
                    if debug == SI : print ("T = %2d D = %.3E"% (T, diferencia_actual))
                    
         
    print ("Periodo %d -  Alfa= %2.5f Beta= %2.5f Gamma= %2.5f, Distancia = %.3E"%
                           (periodo, alpha_definitivo, beta_definitivo, gamma_definitivo, menor_diferencia))
    nombrefichero="PrediccionPeriodo"+str(periodo)+".mat"
    savemat(nombrefichero, {"prediccion_definitiva":prediccion_definitiva})

    
t1 = time.time()
print("Tiempo ejecucion %5.2f segundos" % (t1-t0))


