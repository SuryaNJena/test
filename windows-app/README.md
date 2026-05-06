# windows-app

A minimal Electron desktop wrapper around Microsoft's Cloud PC portal:

- https://windows.cloud.microsoft/

This behaves like a standalone app window on Fedora/Linux and includes a red app icon.

## Included desktop assets

- `windows-app-icon.svg` (red app icon)
- `windows-cloud-app.desktop` (ready-to-copy launcher template that already references the icon)

## Requirements

- Node.js 20+
- npm

## Install

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
update-desktop-database ~/.local/share/applications
```
