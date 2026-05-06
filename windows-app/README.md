# windows-app

A minimal Electron desktop wrapper around Microsoft's Cloud PC portal:

- https://windows.cloud.microsoft/

This makes it behave like a standalone app window on Fedora/Linux.

## Requirements

- Node.js 20+
- npm

## Run

```bash
cd windows-app
npm install
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
