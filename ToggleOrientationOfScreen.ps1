# ToggleOrientationOfScreen.ps1
# Made by Positive Matician
<#
.SYNOPSIS
    Synchronized Screen and Mouse/Touchpad Rotation Toggler.

.DESCRIPTION
    This script cycles the Windows display orientation (0, 90, 180, 270) and simultaneously 
    applies the corresponding coordinate transformation profile to the Raw Accel driver.
    
    This ensures that mouse/touchpad inputs remain intuitive and aligned regardless of 
    physical screen rotation.

.NOTES
    - Cycle Order: Landscape -> Portrait -> Landscape (Flipped) -> Portrait (Flipped).
    - State Tracking: Uses persistence files with custom extension '.positivematician' 
      located in the system %TEMP% directory to remember the current rotation state.

.DEPENDENCIES
    1. MultiMonitorTool.exe (NirSoft) - For handling display rotation.
    2. Raw Accel (writer.exe) - For handling mouse sensor rotation.
    3. Four JSON profiles (landscape, portrait, landscape flipped, portrait flipped).
#>

# ==============================================================================
# CONFIGURATION - USERS MUST UPDATE THESE PATHS
# ==============================================================================
# 1. Path to the Raw Accel 'writer.exe'
$RawAccelWriter = "C:\Path\To\RawAccel\writer.exe"

# 2. Folder where your JSON profiles (landscape.json, etc.) are saved
$ProfileFolder  = "C:\Path\To\RawAccel"

# 3. Path to MultiMonitorTool.exe
$MultiMonitor   = "C:\Path\To\MultiMonitorTool\MultiMonitorTool.exe"
# ==============================================================================


# We use the system temp folder so we don't need Admin rights to write to C:\
$StateDir = $env:TEMP

# 2. Check current orientation using .positivematician extension
# LOGIC CYCLE:  Land -> Port -> LandFlip -> PortFlip (Loop)

if (Test-Path "$StateDir\is_port_flip.positivematician") {
    # SWITCH TO LANDSCAPE (0)
    & $MultiMonitor /SetOrientation 1 0
    & $RawAccelWriter "$ProfileFolder\landscape.json"
    
    New-Item "$StateDir\is_land.positivematician" -ItemType File -Force | Out-Null
    Remove-Item "$StateDir\is_port_flip.positivematician" -ErrorAction SilentlyContinue

} elseif (Test-Path "$StateDir\is_land.positivematician") {
    # SWITCH TO PORTRAIT (90)
    & $MultiMonitor /SetOrientation 1 90
    & $RawAccelWriter "$ProfileFolder\portrait.json"
    
    New-Item "$StateDir\is_port.positivematician" -ItemType File -Force | Out-Null
    Remove-Item "$StateDir\is_land.positivematician" -ErrorAction SilentlyContinue

} elseif (Test-Path "$StateDir\is_port.positivematician") {
    # SWITCH TO LANDSCAPE FLIPPED (180)
    & $MultiMonitor /SetOrientation 1 180
    & $RawAccelWriter "$ProfileFolder\landscape flipped.json"
    
    New-Item "$StateDir\is_land_flip.positivematician" -ItemType File -Force | Out-Null
    Remove-Item "$StateDir\is_port.positivematician" -ErrorAction SilentlyContinue

} elseif (Test-Path "$StateDir\is_land_flip.positivematician") {
    # SWITCH TO PORTRAIT FLIPPED (270) 
    & $MultiMonitor /SetOrientation 1 270
    & $RawAccelWriter "$ProfileFolder\portrait flipped.json"
    
    New-Item "$StateDir\is_port_flip.positivematician" -ItemType File -Force | Out-Null
    Remove-Item "$StateDir\is_land_flip.positivematician" -ErrorAction SilentlyContinue

} else {
    # DEFAULT / INITIAL STATE -> PORTRAIT FLIPPED
    # This runs the first time you ever use the script
    & $MultiMonitor /SetOrientation 1 270
    & $RawAccelWriter "$ProfileFolder\portrait flipped.json"
    
    New-Item "$StateDir\is_port_flip.positivematician" -ItemType File -Force | Out-Null
}
