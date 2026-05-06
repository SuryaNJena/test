# windows-app

A minimal Electron desktop wrapper around Microsoft's Cloud PC portal:

- https://windows.cloud.microsoft/

This behaves like a standalone app window on Fedora/Linux and includes a red app icon.

## Included desktop assets

- `windows-app-icon.svg` (red app icon)
- `windows-cloud-app.desktop` (ready-to-copy launcher template that already references the icon)
This makes it behave like a standalone app window on Fedora/Linux.

## Requirements

- Node.js 20+
- npm

## Install
## Run

```bash
cd windows-app
npm install
```

## Start

```bash
npm start
```

If the window appears to "hang" after launch on Linux, use:

```bash
npm run start:safe
```

For detailed logs:

```bash
npm run start:verbose
```

> `npm warn deprecated boolean@3.2.0` is a transitive dependency warning from Electron's dependency tree and does not prevent the app from launching.

## Install the desktop launcher on Fedora

1. Open `windows-cloud-app.desktop` and replace `/absolute/path/to/windows-app` with your real path.
2. Copy it to your local applications folder:

```bash
cp windows-cloud-app.desktop ~/.local/share/applications/
chmod +x ~/.local/share/applications/windows-cloud-app.desktop
npm start
```

## Optional: create a desktop launcher on Fedora

Create `~/.local/share/applications/windows-cloud-app.desktop`:

```ini
[Desktop Entry]
Name=Windows Cloud App
Comment=Microsoft Windows 365 Cloud PC
Exec=/usr/bin/env bash -lc 'cd /absolute/path/to/windows-app && npm start'
Icon=computer
Terminal=false
Type=Application
Categories=Network;RemoteAccess;
StartupNotify=true
```

Then run:

```bash
update-desktop-database ~/.local/share/applications
```
