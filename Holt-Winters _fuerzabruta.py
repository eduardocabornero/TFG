import matplotlib.pyplot as plt
import numpy as np
from time import sleep 
from scipy.io import savemat
data = np.loadtxt('serietemporalJunio.txt', delimiter=' ')
print('data')

ventana=15
valorventanaseg=ventana*60

slen=11
n_preds =11

##SEGUNDA VENTANA

##Representamos bits por segundos
#x2=data(valorventanaseg:(2*valorventanaseg),0);
#series=data(valorventanaseg:(2*valorventanaseg),1);
#contador=0
series = np.zeros((valorventanaseg,1))##+11
j=0
##Aplicamos Holt-winters a la segunda ventana de paquetes por segundo
for i in range(valorventanaseg+0*slen,2*valorventanaseg+0*slen) :##Hay que cambiar lo que multiplica po slen 
    series[j,0]=data[i,1]##Pones 1 si te refires a bits por segundo y 2 si te refieres a paquetes por segundo 
    j=j+1
    
    #if i>valorventanaseg  and i<=(2*valorventanaseg):
     #series(i)=data((valorventaseg:2*valorventaseg),1)
    #if i>2*valorventanaseg  and i<=(3*valorventanaseg):
     #series(i)=data((2*valorventaseg:3*valorventaseg),1)
     #if()
    
    


#series = [30,21,29,31,40,48,53,47,37,39,31,29,17,9,20,24,27,35,41,38,
          #27,31,27,26,21,13,21,18,33,35,40,36,22,24,21,20,17,14,17,19,
          #26,29,40,31,20,24,18,26,17,9,17,21,28,32,46,33,23,28,22,27,
          #18,8,17,21,31,34,44,38,31,30,26,32]

def initial_trend(series, slen):
    sum = 0.0
    for i in range(slen):
        sum += float(series[i+slen] - series[i]) / slen
    return sum / slen

# >>> initial_trend(series, 12)
# -0.7847222222222222


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

# >>> initial_seasonal_components(series, 12)
# {0: -7.4305555555555545, 1: -15.097222222222221, 2: -7.263888888888888, 3: -5.097222222222222, 4: 3.402777777777778, 5: 8.069444444444445, 6: 16.569444444444446, 7: 9.736111111111112, 8: -0.7638888888888887, 9: 1.902777777777778, 10: -3.263888888888889, 11: -0.7638888888888887}


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



# # forecast 24 points (i.e. two seasons)
# >>> triple_exponential_smoothing(series, 12, 0.716, 0.029, 0.993, 24)
# [30, 20.34449316666667, 28.410051892109554, 30.438122252647577, 39.466817731253066, ...
#slen=15
#n_preds =15
#minimo=2.7e8
#maximo=2.

#valores=np.array([287408000,276754000,276309000,279535000,310771000,274274000,321670000,331104000,289569000,302762000]) ##Sexto periodo tercera ventana bits por segundo slen=10 VENTANAS 30 MIN 
#valores=np.array([273526000,270298000,275280000,276310000,273946000,313372000,279433000,275711000,286855000,282546000]) ##Quinto periodo tercera ventana bits por segundo slen=10 VENTANAS 30 MIN 
#valores=np.array([234937000,257161000,233721000,240748000,284090000,285074000,292271000,295047000,269324000,275151000]) ##Cuarto periodo tercera ventana bits por segundo slen=10 VENTANAS 30 MIN 
#valores=np.array([299050000,256353000,241719000,244046000,243179000,239334000,227762000,245106000,265420000,242112000]) ##Tercer periodo tercera ventana bits por segundo slen=10 VENTANAS 30 MIN 
#valores=np.array([236792000,232006000,232832000,323419000,232075000,237378000,237675000,232191000,289011000,233228000]) ##Segundo periodo tercera ventana bits por segundo slen=10 VENTANAS 30 MIN 
#valores=np.array([276809000,270737000,249457000,239868000,242088000,235830000,238641000,242214000,249231000,252852000]) ##Primer periodo tercera ventana bits por segundo slen=10 VENTANAS 30 MIN 
#valores=np.array([281820000,265748000,267150000,266212000,276460000,291633000,271550000,270806000,273074000,271002000,276800000]) ##Séptimo periodo tercera ventana bits por segundo slen=11 VENTANAS 30 MIN
#valores=np.array([274274000,321670000,331104000,289569000,302762000,293356000,292643000,291995000,277504000,287262000,282889000]) ##Sexto periodo tercera ventana bits por segundo slen=11 VENTANAS 30 MIN
#valores=np.array([273946000,313372000,279433000,275711000,286855000,282546000,287408000,276754000,276309000,279535000,310771000]) ##Quinto periodo tercera ventana bits por segundo slen=11 VENTANAS 30 MIN 
#valores=np.array([240748000,284090000,285074000,292271000,295047000,269324000,275151000,273526000,270298000,275280000,276310000]) ##Cuarto periodo tercera ventana bits por segundo slen=11 VENTANAS 30 MIN 
#valores=np.array([241719000,244046000,243179000,239334000,227762000,245106000,265420000,242112000,234937000,257161000,233721000]) ##Tercer periodo tercera ventana bits por segundo slen=11 VENTANAS 30 MIN Y4
#valores=np.array([232006000,232832000,323419000,232075000,237378000,237675000,232191000,289011000,233228000,299050000,256353000]) ##Segundo periodo tercera ventana bits por segundo slen=11 VENTANAS 30 MIN
#valores=np.array([276809000,270737000,249457000,239868000,242088000,235830000,238641000,242214000,249231000,252852000,236792000]) ##Primer periodo tercera ventana bits por segundo slen=11 VENTANAS 30 MIN
#valores=np.array([267508000,271232000,299432000,293296000,297699000,296187000,294599000,291459000]) ##Segundo periodo tercera ventana bits por segundo slen=8
#valores=np.array([271232000,299432000,293296000,297699000,296187000,294599000,291459000,284670000,279830000]) ##Segundo periodo tercera ventana bits por segundo slen=9
#valores=np.array([271920000,273409000,266944000,271165000,275679000,269098000,268578000,268308000,321646000,269839000]) ##Cuarto periodo tercera ventana bits por segundo slen=10
#valores=np.array([371134000,320163000,272640000,276729000,269243000,278709000,283665000,263285000,267429000,278897000]) ##Tercer periodo tercera ventana bits por segundo slen=10
#valores=np.array([299432000,293296000,297699000,296187000,294599000,291459000,284670000,279830000,286569000,288743000]) ##Segundo periodo tercera ventana bits por segundo slen=10
#valores=np.array([355596000,346019000,336604000,334458000,328216000,275521000,271214000,272195000,267508000,271232000]) ##Primer periodo tercera ventana bits por segundo slen=10
#valores=np.array([355596000,346019000,336604000,334458000,328216000,275521000,271214000,272195000,267508000,271232000,299432000,293296000,297699000,296187000,294599000]) #Bits por segundo slen=15
#valores=np.array([355596000,346019000,336604000,334458000,328216000,275521000,271214000,272195000,267508000,271232000,299432000,293296000,297699000,296187000]) #Bits por segundo slen=14
#valores=np.array([355596000,346019000,336604000,334458000,328216000,275521000,271214000,272195000,267508000,271232000,299432000,293296000,297699000]) #Bits por segundo slen=13
#valores=np.array([355596000,346019000,336604000,334458000,328216000,275521000,271214000,272195000,267508000,271232000,299432000,293296000])#Bits por segundo slen=12
#valores=np.array([262145000,273902000,262892000,258897000,254787000,260594000,259619000,261297000,261033000,260311000,261514000])##Quinto periodo tercera temporada para slen=11
#valores=np.array([271165000,275679000,269098000,268578000,268308000,321646000,269839000,284185000,273331000,276877000,265295000])##Cuarto periodo tercera temporada para slen=11
#valores=np.array([272640000,276729000,269243000,278709000,283665000,263285000,267429000,278897000,271920000,273409000,266944000])##Tercer periodo tercera temporada para slen=11
#valores=np.array([293296000,297699000,296187000,294599000,291459000,284670000,279830000,286569000,288743000,371134000,320163000])##Segundo periodo tercera temporada para slen=11
valores=np.array([355596000,346019000,336604000,334458000,328216000,275521000,271214000,272195000,267508000,271232000,299432000])##Primer periodo tercera temporada para slen=11
#valores=np.array([355596000,346019000,336604000,334458000,328216000,275521000,271214000,272195000,267508000,271232000,299432000,293296000,297699000,296187000,294599000]) ##Bits por segundo slen=11
#valores=np.array([50379.6000000000,49934.2000000000,48011,47816.4000000000,46662.1000000000,41429.5000000000,40166,40522.1000000000,39445.4000000000,40232.6000000000]) ##Paquetes por segundo
diferencia_minima=3e20
error=0
#for alpha in np.linspace(0,1,100):
    #for beta in np.linspace(0,1,100):
        #for gamma in np.linspace(0,1,100):
alpha=0.15151515151515152
beta=0.7878787878787878788
gamma=0.646464646464646465

   
#alpha=0.1515151515151515152 #slen=11
#beta=0.787878787878788  #slen=11
#gamma=0.6464646464646465  #slen=11
            #result = triple_exponential_smoothing(series, slen, alpha, beta, gamma, n_preds)
#prediccion=np.array(np.array(result[1800:]))###+11
            #diferencia=[0]*slen
            #diferencia=np.array([0,0,0,0,0,0,0,0,0,0])
            #for indice in range(slen):  ###Es 10 porque hemos deducido que el período es 10
                #diferencia+=abs(prediccion[indice]-valores[indice])
                #error+=abs(prediccion[indice]-valores[indice])
                #diferencia[indice]=abs(prediccion[indice]-valores[indice]) ##METODO MAX
            #distancia=max(diferencia)
            
            #auxiliar=result[-1]###Para acceder al último valor
            #if(distancia<diferencia_minima):
                #minimo=auxiliar
            
                #diferencia_minima=distancia
                #alpha_definitivo=alpha
                #beta_definitivo=beta
                #gamma_definitivo=gamma
                #prediccion_definitiva=prediccion
                #error_definitivo=error
                #print("alpha=",alpha_definitivo)
                #print("Error=",error_definitivo)
                #print("beta=",beta_definitivo)
                #print("gamma=",gamma_definitivo)
                #prediccion=result[900:]
                #plt.plot(prediccion)
                #plt.title(["alpha=",alpha_definitivo, "beta=",beta_definitivo , "gamma=",gamma_definitivo ])
                #plt.show()
                #sleep(3)
                #print("Nueva iteracion")
#plt.plot(prediccion_definitiva)
#plt.title(["alpha=",alpha_definitivo, "beta=",beta_definitivo , "gamma=",gamma_definitivo , "Error=" ,error_definitivo ])
#plt.show()
                
result = triple_exponential_smoothing(series, slen, alpha, beta, gamma, n_preds)
prediccion=result[valorventanaseg:]  ##COMENTADO LUEGO

savemat("PrediccionPrimerperiodoSlen11Vent15.mat", {"prediccion":prediccion})
for indice in range(slen): 
    error+=abs(prediccion[indice]-valores[indice])
print ( result) #COMENTADO LUEGO
error_total=error[0]
#La mejor prediccion que me ha salido es para alpha=0.86666666667 beta=0.55 y gamma=0.7878787878787878
plt.plot(prediccion) ##COMENTADO LUEGO
plt.title(["alpha="+str(alpha) + " beta="+str(beta) + " gamma="+str(gamma) + " Error="+str(error_total) ])
plt.show()