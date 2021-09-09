# MacOS and Ubuntu container builder and executer
# Formatting
GREEN='\033[0;32m'        # Green
BIGreen='\033[1;92m'      # Green
NC='\033[0m' # No Colour

# Say something nice to the user. Note, $USER, is login account credential.
printf "\n [+] ${BIGreen} Hello ${USER}! Setting up your working container for R.${NC}\n [+]  ${BIGreen}You may be asked to enter your password.${NC}\n"



# Mount local directory and run container:
sudo docker run -ti --rm -v "$PWD":/home/docker -w /home/docker -u docker r-base
