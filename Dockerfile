#Indicar la imagen de DockerHub a utilizar, en este caso Debian
FROM debian

#Establecer variables de zona y para que no nos salgan errores de frontend
ENV TZ=Europe/Madrid
ENV DEBIAN_FRONTEND=noninteractive

#Instalación de modsecurity, apache y php
RUN apt-get update -y -qq >/dev/null \
    && apt-get install -y libapache2-mod-security2 apache2 php7.3 >/dev/null \
    && apt-get purge --auto-remove \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/* 

#Directorio por defecto
WORKDIR /var/www/html

#Copia de los archivos de la página, el entrypoint, el fichero de configuración de apache y el fichero de configuración de modsecurity
COPY public_html /var/www/html/public_html/
COPY entrypoint.sh /var/www/html/
COPY apache2.conf /etc/apache2/apache2.conf
COPY modsecurity.conf-recommened /etc/modsecurity/modsecurity.conf-recommended
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

#Deshabilitar el módulo que indexa los directorios
RUN mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf \
    && a2dismod -f autoindex \
    && a2enmod ssl \
    && a2enmod headers \
    && service apache2 restart 

#Indicar el entrypoint
CMD ["./entrypoint.sh"]
