FROM alpine:latest

RUN apk add -U --no-cache \
    neovim git git-perl \
    zsh tmux openssh-client bash ncurses \
    curl less man
RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true
COPY zshrc .zshrc
COPY vimrc .config/nvim/init.vim
# Install Vim Plug for plugin management
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
RUN nvim +PlugInstall +qall >> /dev/null
# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
# Install plugins
RUN apk add -U --no-cache \
    neovim git git-perl \
    zsh tmux openssh-client bash ncurses \
    curl less man \
    docker py-pip
RUN pip install docker-compose
docker run -it --rm \
    -v /srv/dev-disk-by-label-NAS/Users/marco/workspace:/workspace \
    ls12styler/ide:latest
# Create a user called 'me'
RUN useradd -ms /bin/zsh me
# Do everything from now in that users home directory
WORKDIR /home/me
ENV HOME /home/me

