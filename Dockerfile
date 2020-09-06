FROM ubuntu:18.04
# Setup the terminal to use color
ENV TERM=xterm-256color
# Set the timezone
ENV TZ=America/Denver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# First we need to do a update before installing anything so that apt can find them
RUN apt-get update && \
    # Git is needed for the vim plugin manager
    apt-get -y install git && \
    # The star application
    apt-get -y install vim-gtk && \
    # We need curl to easily install the plugin manager
    apt-get -y install curl
# Create a user account in the docker container that is based on the account of the executor
# This will be dependent on the docker build command passing in the user_name and user_id that
# the container will be executed as.
ARG user_name
ARG user_id
RUN useradd --uid ${user_id} --shell /bin/bash --create-home --user-group ${user_name}
USER ${user_name}
WORKDIR /home/${user_name}
# Install the plugin manager
RUN curl -fLo /home/${user_name}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# For now copy in the vimrc to /root/.vimrc
COPY vimrc /home/${user_name}/.vimrc
# Now configure vim by running the pluging manager and quitting vim
RUN vim --not-a-term -c "PlugInstall" -c "qa"
# Create a directory to map to external host
VOLUME /home/${user_name}/documents
# Change the working dir
WORKDIR /home/${user_name}/documents
# Start vim
ENTRYPOINT ["gvim"]
