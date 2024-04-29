# Usa una imagen base con Flutter preinstalado
FROM cirrusci/flutter AS builder

# Establece el directorio de trabajo en /app
WORKDIR /app

# Descarga y descomprime el SDK de Dart
RUN apt-get update && apt-get install -y wget && \
    wget https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip -O dart-sdk.zip && \
    unzip dart-sdk.zip && \
    rm dart-sdk.zip

# Agrega el SDK de Dart al PATH
ENV PATH="${PATH}:/app/dart-sdk/bin"

# Copia el contenido de tu aplicación Flutter al contenedor
COPY . .

# Ejecuta el comando 'flutter build' para compilar tu aplicación
RUN flutter build web --release

# Configura un servidor web simple para servir la aplicación compilada
FROM nginx:alpine

# Copia los archivos compilados de la aplicación Flutter al directorio de nginx
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expon el puerto 80 para que la aplicación sea accesible
EXPOSE 80

# Ejecuta nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
