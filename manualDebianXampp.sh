#Instalar Xampp en debian 11

    #actualizar paquetes 
        sudo apt update

    #descargar instalador de Xampp y aplicar permisos para la instalación
        wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.1.25/xampp-linux-x64-8.1.25-0-installer.run
        sudo chmod 755 xampp-linux-x64-8.1.25-0-installer.run

    #ejecutar scrip de instalación
        sudo ./xampp-linux-x64-8.1.25-0-installer.run

    #configurar xampp para que cualquiera pueda acceder al servidor
        sudo vi /opt/lampp/etc/extra/httpd-xampp.conf

        #comentar la opcion de "require local" y añadir "require all granted"
            <Directory "/opt/lampp/phpmyadmin">
                AllowOverride AuthConfig Limit
                #require local
                Require all granted
                ErrorDocument 403 /error/XAMPP_FORBIDDEN.html.var
            </Directory>

    #reiniciar xampp
        /opt/lampp/lampp restart

#configurar Xampp como Systemd daemon

    #agg xampp como un servicio en la carpeta de systemd
        sudo vi /etc/systemd/system/xampp.service

    #agg los siguientes parametros dentro del archivo xampp.service
        [Unit]
        Description=XAMPP

        [Service]
        Type=forking
        ExecStart=/opt/lampp/lampp start
        ExecStop=/opt/lampp/lampp stop
        User=root

        [Install]
        WantedBy=multi-user.target
        #Descripción: Este archivo define un servicio llamado XAMPP.
        #Type=forking: Es importante usar este tipo, ya que XAMPP inicia varios procesos en segundo plano y 
        #no permanece en primer plano, lo que podría causar que systemd lo considere 
        #como fallido si no se especifica correctamente
    
    #recargar los servicios de systemd para que reconozca el nuevo xampp.service
        sudo systemctl daemon-reload
    
    #habilitar el nuevo servicio para que inicie con el SO
        sudo systemctl enable xampp.service

    #iniciar servicio manualmente para comprobar funcionamiento
        sudo systemctl start xampp.service

    #comprobar estatus del servicio
        sudo systemctl status xampp.service