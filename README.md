# blanket-plasmoid

A small KDE Plasma 6 system tray widget for [Blanket](https://github.com/rafaelmardojai/blanket).

Click its icon to open Blanket or focus its existing window.

> Uses Blanket's installed icon and desktop entry.

## Requirements

- KDE Plasma 6 with its standard application launcher components.
- Blanket installed with the following exposed to Plasma:
  1. A `com.rafaelmardojai.Blanket.desktop` desktop entry.
  2. Its icon.

## Install

From this repository:

```sh
kpackagetool6 --type Plasma/Applet --install package
```

Open **System Tray Settings → Entries**, enable **Blanket**, and choose **Always shown** if desired.

### Update

```sh
kpackagetool6 --type Plasma/Applet --upgrade package
```

### Uninstall

```sh
kpackagetool6 --type Plasma/Applet --remove com.github.trethore.blanket-plasmoid
```

## License

Licensed under the [MIT License](LICENSE) by Titouan Réthoré.
