# Helpful Commands

This is a collection of helpful commands that I have found useful over the years. I will continue to add to this list as I find more commands that I find useful.

<h2> Table of Contents </h2>

1. [Mac](#mac)
   1. [List All Apps Downloaded from App Store using `find`](#list-all-apps-downloaded-from-app-store-using-find)
   2. [Uninstall Google Update](#uninstall-google-update)
   3. [Exclude Files from time machine backup](#exclude-files-from-time-machine-backup)
   4. [Rings the terminal bell (if enabled) and puts a badge on it](#rings-the-terminal-bell-if-enabled-and-puts-a-badge-on-it)
   5. [Recursively Delete .DS\_Store Files](#recursively-delete-ds_store-files)
2. [NIX](#nix)
   1. [Compare Two Folders](#compare-two-folders)

## Mac

### List All Apps Downloaded from App Store using `find`

```bash
find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print | \sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'
```

### Uninstall Google Update

```bash
~/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/ksinstall --nuke
```

### Exclude Files from time machine backup

```bash
sudo tmutil addexclusion /path/to/file/or/folder
```

### Rings the terminal bell (if enabled) and puts a badge on it

```bash
tput bel
```

### Recursively Delete .DS_Store Files

```bash
find . -type f -name '.DS_Store' -ls -delete
```

## NIX

### Compare Two Folders

```bash
diff -qr /path/to/folder1 /path/to/folder2
```
