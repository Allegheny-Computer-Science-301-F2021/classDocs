# MacOS and Ubuntu container builder and executer
# Formatting
GREEN='\033[0;32m'        # Green
BIGreen='\033[1;92m'      # Green
NC='\033[0m' # No Colour

# Say something nice to the user. Note, $USER, is login account credential.
printf "\n [+] ${BIGreen} Hello ${USER}! Setting up your working container for rStudio.${NC}\n [+]  ${BIGreen}You may be asked to enter your password.${NC}\n"


# Build container:

printf "\n [+] ${BIGreen} Use Browser address: http://localhost:8787/\n ${NC}[+]  ${BIGreen}Set username to rstudio.\n ${NC}[+]  ${BIGreen}Set username password in browser to 'letmein'.${NC}\n"

# Mount local directory and run container:
sudo docker run --rm -e PASSWORD=letmein -p 8787:8787 -v $PWD:/home/rstudio/ rocker/verse



printf "\n [+]  ${BIGreen}Returning file ownership from root to ${USER}.\n      You may be asked to reenter your password.${NC}\n"


# change ownership of a file to your own login if it was created in the docker container.
sudo chown $USER ./*
printf "\n [+] ${BIGreen} The working container is now closed. ${NC}\n"
