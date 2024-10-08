FROM alpine:3.20

# INSTALL PREREQUESTIES
RUN apk add git && \
  apk add vim && \
  apk add build-base cmake coreutils curl unzip gettext-tiny-dev

# INSTALL NVIM
RUN git clone https://github.com/neovim/neovim /neovim && \
  cd neovim && \
  git checkout v0.10.0 && \
  make CMAKE_BUILD_TYPE=RelWithDebInfo && \
  make CMAKE_INSTALL_PREFIX=$HOME/local/nvim install

# SET PATH
ENV PATH="$PATH:/root/local/nvim/bin"

# CLONE CONFIG
RUN mkdir ~/.config/ && \   
  git clone https://github.com/vloneskorpion/nvim-setup ~/.config/nvim

# BUILD LAZY
RUN nvim --headless :+Lazy! build +qa && \
  nvim --headless "+Lazy! sync" +qa
