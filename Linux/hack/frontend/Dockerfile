FROM debian

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt-get update && \
    apt-get install -y apache2

RUN rm /var/www/html/index.html

COPY . /var/www/html

RUN chown www-data:www-data /var/www/html && chown -R www-data:www-data /var/www/html/*

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
