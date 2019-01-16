@echo off
color f1
echo #############################################################
echo #                                                           #
echo #                 Welcome to Docker Cleaner                 #
echo #                                                           #
echo #############################################################
pause
echo Let's remove images:
echo    [a] All images
echo    [u] Unused images
echo    [n] None
SET /p images=
echo Let's remove containers:
echo    [a] All containers
echo    [u] Unused containers
echo    [n] None
SET /p containers=
echo Let's remove volumes:
echo    [a] All volumes
echo    [u] Unused volumes
echo    [n] None
SET /p volumes=
echo Let's remove networks:
echo    [a] All networks
echo    [u] Unused networks
echo    [n] None
SET /p networks=

IF %images%==a (
	echo Removing all images
	FOR /f "tokens=*" %%i IN ('docker images -a --format "{{.ID}}"') DO docker rmi %%i
)
IF %images%==u (
	echo Removing unused images
	docker image prune -f
)
IF %containers%==a (
	echo Removing all containers
	FOR /f "tokens=*" %%i IN ('docker ps -aq') DO docker rm %%i
)
IF %containers%==u (
	echo Removing unused containers
	docker container prune -f
)
IF %volumes%==a (
	echo Removing all volumes
	FOR /f "tokens=*" %%i IN ('docker volume ls --format "{{.Name}}"') DO docker volume rm %%i
)
IF %volumes%==u (
	echo Removing unused volumes
	docker volume prune -f
)
IF %networks%==a (
	echo Removing all networks
	FOR /f "tokens=*" %%i IN ('docker network ls --format "{{.ID}}"') DO docker network rm %%i
)
IF %networks%==u (
	echo Removing unused networks
	docker network prune -f
)

echo Finished. If some components couldn't be deleted, they must be forced.
pause