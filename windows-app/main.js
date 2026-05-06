const path = require('path');
const { app, BrowserWindow, shell } = require('electron');

const CLOUD_PC_URL = 'https://windows.cloud.microsoft/';
const APP_ICON = path.join(__dirname, 'windows-app-icon.svg');

app.commandLine.appendSwitch('enable-features', 'UseOzonePlatform');
app.commandLine.appendSwitch('ozone-platform-hint', 'auto');

function createWindow() {
  const win = new BrowserWindow({
    width: 1400,
    height: 900,
    minWidth: 1024,
    minHeight: 700,
    autoHideMenuBar: true,
    backgroundColor: '#7f1d1d',
    icon: APP_ICON,
    show: false,
    webPreferences: {
      contextIsolation: true,
      sandbox: true,
      devTools: true
    }
  });

  win.once('ready-to-show', () => win.show());
  win.loadURL(CLOUD_PC_URL);

  win.webContents.setWindowOpenHandler(({ url }) => {
    shell.openExternal(url);
    return { action: 'deny' };
  });

  win.webContents.on('did-fail-load', (_event, errorCode, errorDescription, validatedURL) => {
    console.error(`Failed to load ${validatedURL}: [${errorCode}] ${errorDescription}`);
  });

  win.webContents.on('render-process-gone', (_event, details) => {
    console.error('Renderer process exited:', details);
  });
}

app.whenReady().then(() => {
  createWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
