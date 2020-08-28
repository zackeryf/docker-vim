FROM ubuntu:18.04

# First we need to do a update before installing anything so that apt can find them
RUN apt-get update
# Git is needed for the vim plugin manager
RUN apt-get -y install git
RUN apt-get install -y locales 
# The star application
RUN apt-get -y install vim
# We need curl to easily install the plugin manager
RUN apt-get -y install curl
RUN rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
ENV TERM=xterm-256color
# Install the plugin manager
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Change the working dir
WORKDIR /root
# For now copy in the vimrc to /root/.vimrc
COPY vimrc .vimrc
# Now configure vim by running the pluging manager and quitting vim
RUN vim --not-a-term -c "PlugInstall" -c "qa"
