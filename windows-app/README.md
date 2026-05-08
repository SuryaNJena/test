# windows-app

A minimal Electron desktop wrapper around Microsoft's Cloud PC portal:

- https://windows.cloud.microsoft/

This behaves like a standalone app window on Fedora/Linux and includes a red app icon.

## Included desktop assets

- `windows-app-icon.svg` (red app icon)
- `windows-cloud-app.desktop` (ready-to-copy launcher template that already references the icon)

## Browser request behavior

All popup/new-window requests are handled **inside Electron**.

- Links that request a new browser window open in a new Electron child window.
- Requests are no longer sent to your system's default browser.

## Shortcut capture support

The app now uses Electron global shortcuts (while focused) to forward these keys directly to the Cloud PC session:

- `Ctrl+V`
- `Ctrl+Shift+P`

Important platform limits on Linux:

- `Alt+Tab` is controlled by your desktop environment/window manager and cannot be reliably hijacked by Electron.
- `Win+V` (`Super+V`) is also typically reserved by the OS/desktop and may fail to register.

If registration fails, Electron logs a warning in the terminal.

## Microsoft sign-in note

If Microsoft sign-in endpoints appeared to receive `GET` instead of `POST`, that was caused by app-level navigation interception. The app now lets browser navigations proceed normally so auth POST flows are preserved.

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
