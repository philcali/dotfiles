#! /bin/sh

VIM_VERSION="vim-7.3"
VIM_DIR="vim73"

VIM_CURRENT=$HOME/.vim
VIMRC_CURRENT=$HOME/.vimrc
SCREENRC_CURRENT=$HOME/.screenrc

VIM_BACKUP=$HOME/.vim.bak
VIMRC_BACKUP=$HOME/.vimrc.bak
SCREENRC_BACKUP=$HOME/.screenrc.bak

if [ ! -z `which vim` ]
then
  sudo apt-get remove vim
fi

if [ -z `which vim` ]
then
  sudo apt-get install ruby-dev
  sudo apt-get install ncurses-dev
  wget "ftp://ftp.vim.org/pub/vim/unix/$VIM_VERSION.tar.bz2"
  tar -xvf $VIM_VERSION.tar.bz2
  rm $VIM_VERSION.tar.bz2
  cd $VIM_DIR
  ./configure --enable-rubyinterp --with-features=huge
  make
  sudo make install
  cd ../
  rm -rf $VIM_DIR
fi

if [ -e $VIM_CURRENT ]
then
  echo "Backing up your $VIM_CURRENT to $VIM_BACKUP"
  cp -vr $VIM_CURRENT $VIM_BACKUP
  rm -rf $VIM_CURRENT
fi

ln -s $PWD/vim $VIM_CURRENT

cd vim/bundle/command-t
make
cd ../../../

if [ -e $SCREENRC_CURRENT ]
then
  echo "Backing up your $SCREENRC_CURRENT to $SCREENRC_BACKUP"
  cp -v $SCREENRC_CURRENT $SCREENRC_BACKUP
  rm $SCREENRC_CURRENT
fi

ln -s $PWD/screenrc $SCREENRC_CURRENT

if [ -e $VIMRC_CURRENT ]
then
  echo "Backing up your $VIMRC_CURRENT to $VIMRC_BACKUP"
  cp -v $VIMRC_CURRENT $VIMRC_BACKUP
fi

cp -v $PWD/vim/configs/vim-master $VIMRC_CURRENT

if [ -z `which git` ]
then
  echo "The rest of my configuration requires git... sorry :("
fi

git submodule update --init

cd vim-commander
sh install.sh
cd ../

ln -s $PWD/vim-pathogen/autoload/pathogen.vim $VIM_CURRENT/autoload/

cd $PWD/vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
cd ../../../../../

if [ -z `which java` ]
then
  echo "The rest of my  configuration requires java... sorry :("
  exit
fi

curl https://raw.github.com/n8han/conscript/master/setup.sh | sh

cs philcali/lmxml
#cs philcali/monido
#cs philcali/cronish
#cs philcali/spdf
#cs philcali/rvc
#cs softprops/unplanned
#cs harrah/xsbt --branch 0.12.1
