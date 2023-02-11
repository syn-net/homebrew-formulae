# Homebrew Formulae

This is my personal repository of Homebrew formulae. I try to follow the 
rules as laid forth by the official documentation for brew taps [1].

## Other taps I use

```shell
brew tap cavaliercoder/homebrew-dmidecode
```

## Usage

My collection of formulae in use in my environment will always be found 
in the root of the `Formula` directory. I keep my casks separated in their 
own `Casks` directory. Note that you need not specify either one of these 
herein mentioned directories!

```shell
brew tap i8degrees/homebrew-formulae
```

An install of the daemon `ddclient` resides in my `Formula` directory and 
is installed like so:

```shell
# Formula
brew install i8degrees/formulae/ddclient
```

The install of the awesome `mpv` video player sits in my `Casks` directory 
and is done the same way:

```shell
# Cask
brew install i8degrees/mpv
```

### Uninstall

```shell
brew untap i8degrees/homebrew-formulae
```

### Update

```shell
brew update
```

## References

1. [Maintaining a Brew Tap](https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/How-to-Create-and-Maintain-a-Tap.md)
1. <https://docs.brew.sh/Formula-Cookbook>
