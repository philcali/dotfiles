#! /bin/sh

VIM_VERSION="vim-7.4"
VIM_DIR="vim74"

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
  wget "ftp://ftp.vim.org/pub/vim/unix/$VIM_VERSION.tar.bz2"
  tar -xvf $VIM_VERSION.tar.bz2
  rm $VIM_VERSION.tar.bz2
  cd $VIM_DIR
  ./configure --prefix=/usr --with-features=huge
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

if [ -z `which java` ]
then
  echo "The rest of my  configuration requires java... sorry :("
  exit
fi

ln -s $PWD/scala/tool-support/src/vim/ftdetect $VIM_CURRENT/ftdetect
ln -s $PWD/scala/tool-support/src/vim/plugin $VIM_CURRENT/plugin
ln -s $PWD/scala/tool-support/src/vim/syntax $VIM_CURRENT/syntax
ln -s $PWD/scala/tool-support/src/vim/indent $VIM_CURRENT/indent

#curl https://raw.github.com/n8han/conscript/master/setup.sh | sh

#cs philcali/lmxml
#cs philcali/monido
#cs philcali/cronish
#cs philcali/spdf
#cs philcali/rvc
#cs softprops/unplanned
#cs harrah/xsbt --branch 0.12.1
