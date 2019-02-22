userChrome.css goes in .mozilla/firefox/[0-9a-z]+.default/chrome/userChrome.css 

Installing Omnisharp
=====================

First install Mono

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF\necho "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list\nsudo apt update
sudo apt install mono-devel
```

Libuv

```
sudo apt install libuv libuv-dev libuv1-dev
```

Then try to open a .cs file with vim, you will be prompted to install the
omnisharp server.

If you haev issues delete `~/.omnisharp` and reinstall the server to get more
verbose logs.
