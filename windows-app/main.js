const path = require('path');
const { app, BrowserWindow, globalShortcut, session } = require('electron');

const CLOUD_PC_URL = 'https://windows.cloud.microsoft/';
const APP_ICON = path.join(__dirname, 'windows-app-icon.svg');

const EDGE_LIKE_USER_AGENT = [
  'Mozilla/5.0 (X11; Linux x86_64)',
  'AppleWebKit/537.36 (KHTML, like Gecko)',
  'Chrome/136.0.0.0',
  'Safari/537.36',
  'Edg/136.0.0.0'
].join(' ');

app.commandLine.appendSwitch('enable-features', 'UseOzonePlatform');
app.commandLine.appendSwitch('ozone-platform-hint', 'auto');

const shortcutBindings = [
  { accelerator: 'CommandOrControl+V', keyCode: 'V', modifiers: ['control'] },
  { accelerator: 'CommandOrControl+Shift+P', keyCode: 'P', modifiers: ['control', 'shift'] },
  { accelerator: 'Super+V', keyCode: 'V', modifiers: ['meta'] }
];

function sendShortcutToCloudPc(win, keyCode, modifiers) {
  if (!win || win.isDestroyed()) return;
  const wc = win.webContents;
  wc.focus();
  wc.sendInputEvent({ type: 'keyDown', keyCode, modifiers });
  wc.sendInputEvent({ type: 'keyUp', keyCode, modifiers });
}

function registerShortcutsForWindow(win) {
  win.on('focus', () => {
    shortcutBindings.forEach(({ accelerator, keyCode, modifiers }) => {
      const ok = globalShortcut.register(accelerator, () => {
        const target = BrowserWindow.getFocusedWindow();
        sendShortcutToCloudPc(target, keyCode, modifiers);
      });
      if (!ok) {
        console.warn(`Could not register shortcut: ${accelerator}`);
      }
    });
  });

  win.on('blur', () => {
    shortcutBindings.forEach(({ accelerator }) => {
      globalShortcut.unregister(accelerator);
    });
  });
}

function createBaseWindowConfig() {
  return {
    width: 1400,
    height: 900,
    minWidth: 1024,
    minHeight: 700,
    autoHideMenuBar: true,
    backgroundColor: '#7f1d1d',
    icon: APP_ICON,
    webPreferences: {
      contextIsolation: true,
      sandbox: true,
      devTools: true
    },
    userAgent: EDGE_LIKE_USER_AGENT
  };
}

function createChildWindow(url) {
  const child = new BrowserWindow({
    ...createBaseWindowConfig(),
    parent: BrowserWindow.getFocusedWindow() || undefined,
    show: false
  });

  child.once('ready-to-show', () => child.show());
  child.loadURL(url);
  attachWebContentsHandlers(child);
  registerShortcutsForWindow(child);

  return child;
}

function attachWebContentsHandlers(win) {
  win.webContents.setWindowOpenHandler(({ url }) => {
    createChildWindow(url);
    return { action: 'deny' };
  });

  // Do not override navigations here. Intercepting and replaying with loadURL()
  // can convert POST-based auth navigations into GET requests.
  win.webContents.on('did-fail-load', (_event, errorCode, errorDescription, validatedURL) => {
    console.error(`Failed to load ${validatedURL}: [${errorCode}] ${errorDescription}`);
  });

  win.webContents.on('render-process-gone', (_event, details) => {
    console.error('Renderer process exited:', details);
  });
}

function createWindow() {
  const win = new BrowserWindow({
    ...createBaseWindowConfig(),
    show: false
  });

  win.once('ready-to-show', () => win.show());
  win.loadURL(CLOUD_PC_URL);
  attachWebContentsHandlers(win);
  registerShortcutsForWindow(win);
}

app.whenReady().then(() => {
  session.defaultSession.webRequest.onBeforeSendHeaders((details, callback) => {
    details.requestHeaders['User-Agent'] = EDGE_LIKE_USER_AGENT;
    callback({ requestHeaders: details.requestHeaders });
  });

  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on('will-quit', () => {
  globalShortcut.unregisterAll();
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
