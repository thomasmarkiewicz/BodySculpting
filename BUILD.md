# BUILD

## Linux Desktop

To build a flakpak of the release binary:
```
./build_flatpak.sh
```

Copy it to the Librem5 emulator:
```
scp -r -P 6666 bodysculpting.flatpak purism@localhost:/home/purism
```

Install the flatpack:
```
$ flatpak --user install bodysculpting.flatpak
```

And run run it:
```
$ flatpak --user run app.sculpting.body
```



If you need to setup flatpak on your machine:
```
$ sudo apt-get install flatpak flatpak-builder
$ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
$ flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
$ flatpak install flathub org.gnome.Platform//3.36
```

To run it on a real device (Librem5/PinePhone) we'd need to cross-compile the fluter binary to aarch64 architecture, but there is no easy way to do that yet.  It is coming though:
https://github.com/flutter/flutter/projects/181#card-48274867


Prepare the Librem5 emulator to run flatpaks:
```
$ sudo apt -y install flatpak
$ flatpak --user remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
```

