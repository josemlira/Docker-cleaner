@echo off
echo You're going to delete all Docker images, containers and volumes
pause
FOR /f "tokens=*" %%i IN ('docker ps -aq') DO docker rm %%i
FOR /f "tokens=*" %%i IN ('docker images -a --format "{{.ID}}"') DO docker rmi %%i
FOR /f "tokens=*" %%i IN ('docker volume ls --format "{{.Name}}"') DO docker volume rm %%i
echo Finished. If some components couldn't be deleted, they must be forced.
pause