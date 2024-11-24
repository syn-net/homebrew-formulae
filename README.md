# Homebrew Formulae

This is my personal repository of Homebrew formulae. I try to follow the
rules as laid forth by the official documentation for brew taps [1].

## Other taps I use

```shell
brew tap cavaliercoder/homebrew-dmidecode
```

## Usage

**WARNING**: Depending on how you have your git configuration setup, you
may find either HTTPS, SSH or some combination thereof based git pulls 
easiest to support from the command line. Using the HTTPS git pull syntax
implies that you already have a local `~/.gitconfig` setup to accept
git tokens stored at `.git-credentials` for authentication. Whereas when
using the SSH git pull syntax, it is assumed that you have your `ssh-agent`
setup and the proper SSH key loaded. 

My collection of formulae in use in my environment will always be found
in the root of the `Formula` directory. I keep my casks separated in their
own `Casks` directory. Note that you need not specify either one of these
herein mentioned directories!

```shell
# Defaults to a HTTPS git pull
brew tap syn-net/homebrew-formulae
```

An install of the daemon `ddclient` resides in my `Formula` directory and
is installed like so:

```shell
# Formula
brew install syn-net/Formula/ddclient
```

The install of the awesome `mpv` video player sits in my `Casks` directory
and is done the same way:

```shell
# Casks do not require the word formulae in front of it
brew install syn-net/Formula/mpv
```

### git clone using SSH

```shell
# defaults to a SSH git pull
brew tap -v git@github.com:syn-net/homebrew-formulae git@github.com:syn-net/homebrew-formulae
```

### Uninstall

```shell
brew untap syn-net/homebrew-formulae
#brew untap -v git@github.com:syn-net/homebrew-formulae git@github.com:syn-net/homebrew-formulae
```

### Update

```shell
brew update
```

## References

1. [Maintaining a Brew Tap](https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/How-to-Create-and-Maintain-a-Tap.md)
1. <https://docs.brew.sh/Formula-Cookbook>
