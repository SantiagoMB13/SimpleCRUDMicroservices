# CRUD

Este es el comando para crear el contenedor directamente: 

docker run -d -it -v ${PWD}:/build --network=my-network --name flutterapp-container --workdir /build ghcr.io/cirruslabs/flutter:stable

Si lo corro así, crea el contenedor y me deja hacer docker build web, pero cuando abro en el navegador la ip con el puerto en el que debería estar la app, se queda cargando y no muestra nada.

Por otro lado, añadí un Dockerfile (que no funciona) pq dice que mi sdk de dart es 2.9 y tiene que ser minimo 3, pero no he logrado solucionarlo aunque añada los comandos para instalar la ultima versión del sdk en el Dockerfile
