# get the base image, this one has R, RStudio, pandoc, and a bunch of R packages that I use often
FROM rocker/rstudio

# required
MAINTAINER Ben Marwick <benmarwick@gmail.com>

# install some packages that not in the base image, these have to be manually identified from my package's Description -> Imports list
RUN apt-get update -y \
  && apt-get install r-cran-rjava   -y \
  # install devtools so we can get pkgs from github
  && install.r devtools \
  # get the packages we depend on from the local packrat repo
  && R -e "0" --args --bootstrap-packrat \
  # allow to install from GitHub
  && installGithub.r --deps TRUE \
  # install from GitHub my package that is the focus of this image
  benmarwick/mjbtramp \
  # get the full set of repository files from GitHub (since the built package doesn't have them all)
  && git clone https://github.com/benmarwick/mjbtramp.git \
  # make these files writable
  && chmod 777 -R mjbtramp



#################### Notes to self ###############################
# a suitable disposable test env:
# docker run -dp 8787:8787 rocker/rstudio

# to build this image:
# docker build -t benmarwick/mjbtramp https://raw.githubusercontent.com/benmarwick/mjbtramp/master/Dockerfile

# to run this container to work on the project:
# docker run -dp 8787:8787  -v /c/Users/bmarwick/docker:/home/rstudio/ -e ROOT=TRUE  benmarwick/mjbtramp
# then open broswer at localhost:8787 or run `docker-machine ip default` in the shell to find the correct IP address

# go to hub.docker.com
# create empty repo for this repo ('Create Automated Build'), then

# to add CI for the docker image
# add .circle.yml file
# - Pushes new image to hub on successful complete of test
# - And gives a badge to indicate test status
# go to circle-ci to switch on this repo

# On https://circleci.com/gh/benmarwick/this_repo
# I need to set Environment Variables:
# DOCKER_EMAIL
# DOCKER_PASS
# DOCKER_USER

# Circle will push to docker hub automatically after each commit, but
# to manually update the container at the end of a work session:
# docker login # to authenticate with hub
# docker push benmarwick/mjbtramp

# When running this container, the mjbtramp dir is not writable, so we need to
# sudo chmod 777 -R mjbtramp

#

