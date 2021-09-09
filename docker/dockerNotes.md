
## build
sudo docker run --rm -e PASSWORD=letmein -p 8787:8787 -v $PWD:/home/rstudio/rocker/verse

docker run --rm -p 8787:8787 -e PASSWORD=yourpasswordhere rocker/rstudio
docker run --rm -p 8787:8787 -e PASSWORD=letmein rocker/rstudio

## remove a container
sudo docker image rm rocker/rstudio



## Linux, Mac; Build, mount local drive and run container:
 - docker run --rm -p 8787:8787 -e PASSWORD=letmein rocker/rstudio
## Windows; Build, mount local drive and run container:
 - old not working docker run --rm -e PASSWORD=letmein -p 8787:8787 -v $PWD:/home/rstudio/ rocker/rstudio
 - docker run --rm -e PASSWORD=letmein -p 8787:8787 -v PWD:/home/rstudio/ rocker/verse
 - docker run --rm -e PASSWORD=letmein -p 8787:8787 -v "PWD:/home/rstudio/" rocker/verse

## Browser:
 - URL: Use Browser address: http://localhost:8787/
