FROM python:3-alpine

RUN apk update && apk add git curl vim 
RUN pip install flake8
COPY ./plugins/ale/ /usr/share/vim/vim91/
COPY ./plugins/landscape.vim/ /usr/share/vim/vim91/
COPY ./plugins/vim-python-pep8-indent/ /usr/share/vim/vim91/
COPY ./plugins/vim-just/ /usr/share/vim/vim91/
RUN rm /etc/vim/vimrc
COPY ./vimrc /etc/vim/vimrc
WORKDIR /home
VOLUME /home

ENTRYPOINT [ "vim" ]
CMD [""]
