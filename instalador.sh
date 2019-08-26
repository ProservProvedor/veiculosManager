
#!/bin/bash

#Atencão as porta 80 , 8080 , 3306 do seu sevidor deve está livre

#fase 1
echo Criando rede privada
	if ! docker network create veiculosnet -d bridge --subnet 100.64.64.0/24
		then 
			echo Falha ao criar rede privada
			exit 1
	fi
echo Rede privada criada com sucesso 

#fase 2
echo Instalando banco de dados
	if ! docker run -p 3306:3306 -d --name veiculosDB -eMYSQL_ROOT_PASSWORD=131282 --network veiculosnet mysql
		then 
			echo Falha ao instalar banco de dados
			exit 1
	fi 
echo Banco de dados instalado com sucesso

#fase 3
echo Instalando aplicacao
	if ! docker run -p 80:80 -p 8080:8080 -it -d --name veiculosApp --network veiculosnet proserv/veiculos
		then 
			echo Falha ao instalar aplicacao
			exit 1
	fi 
echo Aplicacao instalada com sucesso
echo Saido
