# CRUD

Proyecto de app en Flutter para hacer un CRUD a una base de datos de MongoDB utilizando microservicios con NodeJs y desplegando en Docker.

Para desplegar la app:

Abrir cmd dentro de la carpeta FlutterApp y ejecutar los comandos:
- docker build -t appimage .
- docker run -d -p 1200:80 --network=my-network --name app-container appimage


Para desplegar los microservicios:

Abrir cmd dentro de la carpeta de cada microservicio y ejecutar el comando:
- docker build -t nombreimagen . 

Donde nombreimagen es el nombre de la operación del microservicio seguido de la palabra image. Ej: readimage para Read.

Luego, ejecutar el comando correspondiente al microservicio. Ej: Para ReadLog se ejecuta el primer comando:
- docker run -d -p 3400:3400 --network=my-network --name readlog-container readlogimage
- docker run -d -p 3300:3300 --network=my-network --name read-container readimage
- docker run -d -p 3200:3200 --network=my-network --name update-container updateimage
- docker run -d -p 3100:3100 --network=my-network --name delete-container deleteimage
- docker run -d -p 3400:3400 --network=my-network --name create-container createimage

Para desplegar la base de datos:
- docker run -d -p 27017:27017 --network=my-network --name mongodb-container mongo:latest
