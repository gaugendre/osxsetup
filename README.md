# osxsetup

## interactive mode

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/gaugendre/osxsetup/master/install.sh)"
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

## boot tips

* boot menu: `alt` + `Power`
* reset SMC
  * T2 chip: `right shift` + `ctrl` + `alt` + `Power` wait 10s
  * macbooks < 2017: `left shift` + `ctrl` + `alt` + `Power` wait 10s
* reset NVRAM: `cmd` + `alt` + `P`+ `R` wait 2d bell
