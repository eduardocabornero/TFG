#!/bin/bash
#echo -e "Empieza el script.\n"
gawk -F, 'BEGIN{
		#delimitador para separar cada linea por el
		FS=",";
	}
	#NR>1
{
	#Lectura del fichero CSV
	#fecha=$1
	#hora=$2
	duracion=$2;
	ip_origen=$3
	ip_destino=$4
	source_port=$5
	destination_port=$6
	protocol=$7
	flags=$8
	fwd=$9
	stops=$10
	paquetes=$11
	numero_bytes=$12;

 
    split($1,fecha_global," ");
	split(fecha_global[1],fecha,"-");
	split(fecha_global[2],hora,":");
	
	#print fecha_global[1];
	#print fecha_global[2]"";


	#print("Hola");
	#print fecha[1];
	#print fecha[2];
	#print fecha[3];
	

	segundo = hora[3]
	minuto = hora[2]
    
        tiempo_final=mktime(fecha[1]" "fecha[2]" "fecha[3]" "hora[1]" "hora[2]" "hora[3]);
        
  

	bits = numero_bytes*8;
	
	if( duracion<0.001){
		SEGUNDOS[tiempo_final]+=bits
		PAQUETES[tiempo_final]+=paquetes
	}
	else{
		bitsSegundo = bits/duracion
	    paquetesSegundo = paquetes/duracion

		bitsUltimoSegundo = bitsSegundo*(duracion - int(duracion))
        paquetesUltimoSegundo = paquetesSegundo*(duracion - int(duracion))

		#segundo duracion bits bitsSegundo bitsUltimoSegundo

		for (i=0;i<int(duracion)-1;i++){
			aux = int(tiempo_final)+i
			
			
			SEGUNDOS[aux] += bitsSegundo
			PAQUETES[aux]+= paquetesSegundo
		}
		
		aux = int(tiempo_final)+i

		SEGUNDOS[aux]+=bitsUltimoSegundo
		PAQUETES[aux]+=paquetesUltimoSegundo
	}
	
}
END { 
	for ( i in SEGUNDOS) {
		print i,SEGUNDOS[i],PAQUETES[i];
	}
		

    #print ("Terminan los bitsporsegundo");

    #for (i in SEGUNDOS){
        #print"paquetesSegundo",i,PAQUETES[i]
    #}


}' june.week2.csv.uniqblacklistremoved | sort -nk1,1
 
