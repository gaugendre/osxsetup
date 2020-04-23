# osxsetup

## interactive mode

```bash
curl -fsSL https://raw.githubusercontent.com/gaugendre/osxsetup/master/install.sh | bash
```

or download / fork

```bash
cd ~/Downloads/osxsetup-master
./install.sh
```

## or just what you want


```bash
curl -fsSL https://raw.githubusercontent.com/gaugendre/osxsetup/master/setup-defaults.sh | bash
curl -fssL https://raw.githubusercontent.com/gaugendre/osxsetup/master/brewfiles/apps.rb | brew bundle --file=-
curl -fssL https://raw.githubusercontent.com/gaugendre/osxsetup/master/brewfiles/clitools.rb | brew bundle --file=-
curl -fssL https://raw.githubusercontent.com/gaugendre/osxsetup/master/brewfiles/devtools.rb | brew bundle --file=-
```
