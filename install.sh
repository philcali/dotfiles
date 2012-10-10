#! /bin/sh

VIM_CURRENT=$HOME/.vim
VIMRC_CURRENT=$HOME/.vimrc
SCREENRC_CURRENT=$HOME/.screenrc

VIM_BACKUP=$HOME/.vim.bak
VIMRC_BACKUP=$HOME/.vimrc.bak
SCREENRC_BACKUP=$HOME/.screenrc

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

if [ -e $SCREENRC_CURRENT]
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

ln -s $VIM_CURRENT/configs/vim-general $VIM_CURRENT

if [ -z `which git` ]
then
  echo "The rest of my configuration requires git... sorry :("
fi

git submodules update --init

cd vim-commander
sh install.sh
cd ../

ln -s $PWD/vim-pathogen/autoload/pathogen.vim $VIM_CURRENT/autoload/

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
