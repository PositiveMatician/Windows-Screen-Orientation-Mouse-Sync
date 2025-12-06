
# Windows Screen & Mouse Rotation Sync (Raw Accel Script)

**Fix inverted touchpad controls in Portrait Mode on Windows Tablets and Convertibles.**

![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-blue)
![Language](https://img.shields.io/badge/Language-PowerShell-5391FE)
![License](https://img.shields.io/badge/License-MIT-green)

## 🛑 The Problem
When physically rotating a Windows device (e.g., from Landscape to Portrait), Windows rotates the display interface, but **does not** automatically rotate the mouse or touchpad coordinate system.

This results in "inverted" or "sideways" input—moving your finger "up" on the touchpad causes the cursor to move "left" or "right" on the screen, making the device frustrating to use in tablet mode.

## ✅ The Solution
This PowerShell utility acts as a **master toggle**. With a single hotkey, it cycles through screen orientations and simultaneously injects the correct coordinate profile into the mouse driver.

**It Syncs:**
1.  **Display Orientation:** 0° ➔ 90° ➔ 180° ➔ 270°
2.  **Mouse/Touchpad Axis:** Automatically applies the matching rotation matrix.

## ⚙️ How It Works
The script utilizes **[Raw Accel](https://github.com/RawAccelOfficial/rawaccel)** (a signed kernel-level mouse driver) to handle the input rotation and **[MultiMonitorTool](https://www.nirsoft.net/utils/multi_monitor_tool.html)** to handle the display rotation.

It tracks the current state using temporary lockfiles with a custom extension (`.positivematician`) in the system `%TEMP%` directory to ensure reliability without requiring Administrator privileges for file creation.

---

## 🚀 Prerequisites

1.  **[Raw Accel](https://github.com/RawAccelOfficial/rawaccel/releases)** (Required for mouse rotation).
2.  **[MultiMonitorTool](https://www.nirsoft.net/utils/multi_monitor_tool.html)** (Required for screen rotation - Scroll down to "Feedback" on their site to find the download link).
3.  **PowerShell** (Pre-installed on Windows).

---

## 🛠️ Installation & Setup

### Step 1: Create Raw Accel Profiles
The script relies on 4 specific JSON profile files. You must create these manually in your Raw Accel folder:

1.  Open **Raw Accel**.
2.  Set **Rotation** to `0`. Click **Apply**.
3.  Go to your Raw Accel folder, copy `settings.json`, and rename it to `landscape.json`.
4.  Repeat this process for the other 3 angles:
    * **Rotation 90** ➔ Save as `portrait.json`
    * **Rotation 180** ➔ Save as `landscape flipped.json`
    * **Rotation 270** ➔ Save as `portrait flipped.json`

### Step 2: Configure the Script
1.  Download `ToggleRotation.ps1` from this repository.
2.  Open it with any text editor (Notepad, VS Code).
3.  Update the **Configuration** section at the top with your specific file paths:

```powershell
# EXAMPLE CONFIGURATION
$RawAccelWriter = "C:\Users\YourName\Tools\RawAccel\writer.exe"
$ProfileFolder  = "C:\Users\YourName\Tools\RawAccel"
$MultiMonitor   = "C:\Users\YourName\Tools\MultiMonitorTool.exe"
````

### Step 3: Create a Hotkey

To use this instantly (like a native feature):

1.  Right-click `ToggleRotation.ps1` ➔ **Send to** ➔ **Desktop (create shortcut)**.
2.  Right-click the new Shortcut ➔ **Properties**.
3.  In the **Target** field, add ` powershell -WindowStyle Hidden -File  ` before the path. It should look like this:
    ```text
    powershell -WindowStyle Hidden -File "C:\Path\To\ToggleRotation.ps1"
    ```
4.  Click in the **Shortcut Key** box and press your desired combo (e.g., `Ctrl` + `Alt` + `R`).
5.  Click **Apply**.

-----

## 🎮 Usage

Simply press your hotkey (`Ctrl + Alt + R`) to cycle through the modes:

1.  **Landscape** (Standard Laptop Mode)
2.  **Portrait** (Tablet / Reading Mode)
3.  **Landscape Flipped** (Tent Mode)
4.  **Portrait Flipped** (Reverse Tablet Mode)

*Note: The script creates a `.positivematician` file in your Temp folder to remember which state it is in.*

-----

## 📱 Compatibility

This script works on **Windows 10** . It is specifically useful for 2-in-1 convertibles and tablets including:

  * Microsoft Surface Pro / Go
  * Lenovo Yoga Series
  * HP Spectre x360 / Envy x360
  * Dell XPS 2-in-1
  * Asus ROG Flow / ZenBook Flip

## 📄 License

This project is licensed under the [MIT License](https://www.google.com/search?q=LICENSE).

```
```
