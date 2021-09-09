# Build container:

echo Use Browser address: http://localhost:8787/
echo [+]  Set username to rstudio.
echo [+]  Set username password in browser to 'letmein'.

echo Mount local directory and run container:
docker run --rm -e PASSWORD=letmein -p 8787:8787 -v "PWD:/home/rstudio/" rocker/verse
