
# Start off with the base docker Image
FROM httpd:latest

# copy the webapplication files to the document root of the Apache Server
COPY ./webapp/ /usr/local/apache2/htdocs/

# Expose port 80 for http traffic
EXPOSE 80
