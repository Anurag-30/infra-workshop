#! /bin/bash
sed -i 's/localhost:9966/${BACKEND_LB_URL}/g' /root/spring-petclinic-angular/src/environments/environment.ts
cd /root/spring-petclinic-angular
npm uninstall -g angular-cli @angular/cli
npm install -g @angular/cli@latest
npm install
ng serve --host 0.0.0.0 --port 80 --disableHostCheck true
