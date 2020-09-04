## Goal
Set up a development environment in a docker container so that it can be easily deployed on any computer that can run docker containers.

## Build
It is required to build the docker container as the user that the container will be run as. The build process will get
the current user and create a user with the same name and ID in the container. This is needed so that the document
ownership will be the same as the user. If this is not done when the files are saved they will be owned by root.

Build via Makefile:  
`make build-vim`  

OR

Docker build command:  
`docker build --build-arg user_name="$(id --user --name)" --build-arg user_id="$(id --user)" -t docker-vim:latest .`

## To Run
To run the container cd to the top directory that has the files you wish to edit, and use the provided script called dvim and pass in the filename as the argument or issue the docker
container run command below passing in the fileneme.

Using the dvim script:  
`<path to docker-vim>/scripts/dvim <filename>`

Using the docker run command:  
`docker container run -it --mount type=bind,source="$(pwd)",destination="${HOME}/documents" docker-vim:latest $@`

## Create an alias or install
To make it easier to execute you can create an alias to the dvim script so in your .bashrc or you can install the dvim
script to /user/local/bin or some other directory in your PATH. There is a Makefile target that will copy dvim to
/usr/local/bin for you, note you will probably need to use sudo when executing the make target.

'make install'

## Gotchas
When the container is run it will get the corrent working directory and it will bind mount that directory into the
container. It needs to do this so that when the container is stopped you do not lose all of the changes you made. This
means that you will not be able to edit files that are located above the current working directory that the container
was started in.

## The vimrc
The provided vimrc has some basic configuration you can look at the vimrc file to see what is configured, I have
provided comments as to what each option does. It does have two plugins NERDTree for browsing and Lightline for a status
line at the bottom of the terminal. It is using vim-plug to install these plugins.

Naturally you will probably want to customise the vimrc to your prefrences, this can be done by simply modifying the
vimrc file and rebuilding the container. Plugins can be a bit of work to add. The vim plugins can have dependencies that
will need to be added to the container. The two plugins that I have added do not have any external dependencies so they
were easy to add and why they are here. Some plugins want fancy fonts such as powerline or airline status bars. In this
case you will need to install the powerline fonts in the container by modifying the Dockerfile and adding the plugin to
vimrc along with any configuration that the plugin requires, then build, and run.

## Reference
NERDTree:  
https://vimawesome.com/plugin/nerdtree-red  
https://github.com/preservim/nerdtree

Lightline:  
https://vimawesome.com/plugin/lightline-vim  
https://github.com/itchyny/lightline.vim

Vim-plug:  
https://github.com/junegunn/vim-plug

Dockerfile:  
https://docs.docker.com/engine/reference/builder/
