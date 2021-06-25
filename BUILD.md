# BUILD

Generate Hive adapters:
```
flutter packages pub run build_runner build
```


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


## Cross-build for aarch64 (Librem One, Pinephone)

This issue seems really close to being merged:

https://github.com/flutter/flutter/pull/61221

So waiting for now and focusing my energy elsewhere, but here are some notes I took:

Although Flutter team is still working on adding official support ([issue 61221](https://github.com/flutter/flutter/pull/61221)),
it is possible to cross-compile right now with a little elbow grease.  

"If you want to cross-build for Arm64, you need to prepare a target sysroot." - HidenoriMatsubayashi

For now you have to:
- built local version of Flutter Engine
- prepare customized sysrootfs for aarch64
- cross-compile with patched Flutter SDK

### Built local version of Flutter Engine

### Prepare customized sysrootfs for aarch64

There are two ways:
1. use an external sysroot
2. modify buildroot to use debian_sid_arm64-sysroot

Q. Can I just use an external sysroot for now? If now, see below:

Patches to modify the buildroot here:

https://github.com/HidenoriMatsubayashi/buildroot/tree/topic-support-linux-aarch64-cross-build

The above patched repo (flutter/buildroot) is used by (flutter/engine).

To point the engine to a new version of buildroot after your patch is merged, update the buildroot hash in the engine's [DEPS](https://github.com/flutter/engine/blob/master/DEPS) file.

### Cross-compile with patched Flutter SDK
 
Here is the patch: https://github.com/flutter/flutter/pull/61221


### Resources
- Build Flutter engine with sysroot for aarch64
    - https://github.com/flutter/flutter/pull/61221#issuecomment-667785280
- Hidenori Matsubayashi's Proposal for *embedded* flutter (not what I need)
    - https://docs.google.com/document/d/1n4NXCk0QlGz16gUCtywR79H0Z1fzPqB2iNL8oxuexuk/edit



