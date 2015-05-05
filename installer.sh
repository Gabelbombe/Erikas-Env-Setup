#!/bin/bash


sudo -v ## ask for password up front


## Install brew and cask
if ! hash brew 2>/dev/null; then
  echo '-- Installing Homebrew!'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  ## Update Brew
  echo '-- Updating Brew'
  brew update
fi


# Update bash
brew install bash
echo "$(which bash)" |sudo tee -a /etc/shells


## Install cask and binaries
echo '-- Installing Cask and Binaries'
brew install caskroom/cask/brew-cask
brew tap homebrew/science
brew tap homebrew/binary


## GNU Utilities
echo '-- Installing Core Utilities'
brew install coreutils


## NIX your env
echo '-- Converting your environment to be more like Linux'
brew tap homebrew/dupes
brew install binutils
brew install diffutils
brew install ed --default-names
brew install findutils --default-names
brew install gawk
brew install gnu-indent --default-names
brew install gnu-sed --default-names
brew install gnu-tar --default-names
brew install gnu-which --default-names
brew install gnutls --default-names
brew install grep --default-names
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget
brew install expect


## Must have
echo '-- Installing GIT and adding GIT Aliases'
brew install git
curl -X GET https://raw.githubusercontent.com/ehime/Bash-Tools/master/.gitconfig >> ~/.gitconfig
brew install unzip

echo '-- Generating a new private key'
mkdir -p ~/.ssh && ssh-keygen -t rsa -N '' -f ~/.ssh/github_rsa


## Fresher bins
echo '-- Installing fresher biniaries'
brew install bash
brew install emacs
brew install gdb      # gdb requires further actions to make it work. See `brew info gdb`.
brew install gpatch
brew install m4
brew install make
brew install nano

echo '-- Adding Nano color coding'
git clone https://github.com/scopatz/nanorc.git ~/.nano
cat ~/.nano/nanorc >> ~/.nanorc


## Short of learning how to actually configure OSX, here's a hacky way to use
## GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise
echo '-- Aliasing Manpages'
echo -e "alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1; if [ \"$?\" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'" >> ~/.bash_profile

## Install AWS stuff
echo '-- Installing AWS CLI Tools'
for candidate in "$(grep -l AmazonWebServicesFormula /usr/local/Library/Formula/*.rb | awk -F/ '{sub(/.rb$/,""); print " " $NF}')"; do
  brew install $candidate
done


## Packer
echo '-- Installing Packer'
brew install packer


## Install PHPStorm
echo '-- Installing Developer Applications'
brew cask install --appdir="~/Applications" caskroom/homebrew-versions/java6
brew cask install --appdir="/Applications" heroku-toolbelt
brew cask install --appdir="/Applications" sublime-text
brew cask install --appdir="/Applications" phpstorm
brew cask install --appdir="/Applications" light-table
brew cask install --appdir="/Applications" macvim
brew cask install --appdir="/Applications" sourcetree
brew cask install --appdir="/Applications" charles
brew cask install --appdir="/Applications" easyfind


## Install Vagrant
echo '-- Installing Vagrant'
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" vagrant
brew cask install vagrant-manager
vagrant plugin install vagrant-vbguest


echo '-- Installing additional "Nice to have" Apps'
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" skype


# cleanup
echo '-- Running cleanup...'
brew cleanup --force
rm -fr /Library/Caches/Homebrew/*


echo 'Done!!'
