# springboot-shell

## Modo de usar

### Java
Para empacotar o programa usando o [Maven](http://maven.apache.org/):
```bash
mvn clean package
```
Para iniciar o programa:
```bash
java -Dspring.profiles.active=demo -jar demo-1.0.0-SNAPSHOT.jar
```

### Bash
```bash
standalone.sh {start|stop|status|pid}
```

### Systemd
Para instalar o serviço:
```bash
sudo cp ./demo.service /etc/systemd/system/
sudo chmod 664 /etc/systemd/system/demo.service
sudo systemctl daemon-reload
```
Para controlar o serviço manualmente:
```bash
sudo systemctl {start|stop} demo
```
Para controlar o serviço com a inicialização do Sistema Operacional:
```bash
sudo systemctl {enable|disable} demo
```
