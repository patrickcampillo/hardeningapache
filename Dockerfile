#Indicar la imagen de DockerHub a utilizar, en este caso Debian
FROM debian

#Establecer variables de zona y para que no nos salgan errores de frontend
ENV TZ=Europe/Madrid
ENV DEBIAN_FRONTEND=noninteractive

#Instalación de modsecurity, apache y php
RUN apt-get update -qq >/dev/null && apt-get install -y libapache2-mod-security2 apache2 php7.3 >/dev/null 2>/dev/null

#Directorio por defecto
WORKDIR /var/www/html

#Copia de los archivos de la página, el entrypoint, el fichero de configuración de apache y el fichero de configuración de modsecurity
COPY public_html /var/www/html/public_html/
COPY entrypoint.sh /var/www/html/
COPY apache2.conf /etc/apache2/apache2.conf
COPY modsecurity.conf-recommened /etc/modsecurity/modsecurity.conf-recommended

#Deshabilitar el módulo que indexa los directorios
RUN a2dismod -f autoindex.load && service apache2 restart 2>/dev/null

#Indicar el entrypoint
ENTRYPOINT ["./entrypoint.sh"]
