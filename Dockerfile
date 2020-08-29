FROM ubuntu:18.04

# First we need to do a update before installing anything so that apt can find them
RUN apt-get update && \
    # Git is needed for the vim plugin manager
    apt-get -y install git && \
    # The star application
    apt-get -y install vim && \
    # We need curl to easily install the plugin manager
    apt-get -y install curl
ENV LANG en_US.utf8
# Setup the terminal to use color
ENV TERM=xterm-256color
# Install the plugin manager
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# For now copy in the vimrc to /root/.vimrc
COPY vimrc /root/.vimrc
# Now configure vim by running the pluging manager and quitting vim
RUN vim --not-a-term -c "PlugInstall" -c "qa"
# Create a directory to map to external host
RUN mkdir /root/documents
# Create a mountpoint
VOLUME ["/root/documents"]
# Change the working dir
WORKDIR /root/documents
# Start vim
ENTRYPOINT ["vim", "--not-a-term"]
