# buntu-iso-builder

Remasters a *buntu Live ISO with customizations using GitHub Actions.

Specifically, it remasters a Lubuntu Live ISO with my [Filer](https://github.com/probonopd/Filer/) file manager and some [helloDesktop](https://hellosystem.github.io/docs/) components.

## Features

* Runs LxQt but with the helloDesktop core components [launch](https://github.com/helloSystem/launch/), [Menu](https://github.com/helloSystem/Menu), and [Filer](https://github.com/probonopd/Filer/) instead of the LxQt counterparts
* Tries to avoid anything Glib/Gtk/Gnome
* Automatically detects the keyboard layout (keyboard language) based on a Raspberry Pi Keyboard and Hub or the EFI variable `prev-lang:kbd` ([details](github.com/probonopd/casper-language-autodetection))

## Acknowledgements

* Based on https://github.com/rollingrhinoremix/RRR-builder
* The original iso builder for Ubuntu Unity: https://gitlab.com/ubuntu-unity/ubuntu-remixes/ubuntu-unity for base project
* Original creation_script at https://github.com/rollingrhinoremix/creation_script which helped convert ubuntu to RRR
