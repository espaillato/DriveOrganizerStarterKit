# setup.ps1 — one-command setup for the Living Reference Starter Kit (Windows PowerShell).
#
# What this does (see SETUP_GUIDE.md step 1 for the full explanation):
#   1. Asks where you want your File Archive and Living Reference folders.
#   2. Copies File_Archive_Template/ and Living_Reference_Template/ into
#      those locations — never overwriting a file that's already there, so
#      it's safe to re-run this after you've started filing real documents.
#   3. Builds file-renamer.skill and file-archive-audit.skill (installable
#      zip packages) into dist/ from the source in skills/.
#   4. Prints next steps pointing at SETUP_GUIDE.md.
#
# Safe to re-run. Existing files in your target folders are never touched.

$ErrorActionPreference = "Stop"

$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $RepoDir

Write-Host "Living Reference Starter Kit — setup"
Write-Host "======================================"
Write-Host ""

# ---- 1. Ask for target locations -------------------------------------------

$ArchiveTarget = Read-Host "Where should your File Archive folder go? (e.g. a path inside your Google Drive)"
$ReferenceTarget = Read-Host "Where should your Living Reference folder go? (a sibling folder, not nested inside the archive)"

if ([string]::IsNullOrWhiteSpace($ArchiveTarget) -or [string]::IsNullOrWhiteSpace($ReferenceTarget)) {
    Write-Error "Both paths are required. Re-run setup.ps1 when you're ready."
    exit 1
}

New-Item -ItemType Directory -Force -Path $ArchiveTarget | Out-Null
New-Item -ItemType Directory -Force -Path $ReferenceTarget | Out-Null

# ---- 2. Copy templates, never overwriting existing files -------------------

function Copy-WithoutOverwrite {
    param(
        [string]$Source,
        [string]$Destination
    )

    Get-ChildItem -Path $Source -Recurse -File | ForEach-Object {
        $relativePath = $_.FullName.Substring($Source.Length).TrimStart('\', '/')
        $destPath = Join-Path $Destination $relativePath
        $destDir = Split-Path -Parent $destPath

        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Force -Path $destDir | Out-Null
        }

        if (-not (Test-Path $destPath)) {
            Copy-Item -Path $_.FullName -Destination $destPath
        }
    }
}

Write-Host ""
Write-Host "Copying File_Archive_Template/ -> $ArchiveTarget (existing files kept as-is)..."
Copy-WithoutOverwrite -Source (Join-Path $RepoDir "File_Archive_Template") -Destination $ArchiveTarget

Write-Host "Copying Living_Reference_Template/ -> $ReferenceTarget (existing files kept as-is)..."
Copy-WithoutOverwrite -Source (Join-Path $RepoDir "Living_Reference_Template") -Destination $ReferenceTarget

# ---- 3. Build the installable .skill packages ------------------------------

Write-Host ""
Write-Host "Building installable skill packages into dist/..."
$DistDir = Join-Path $RepoDir "dist"
New-Item -ItemType Directory -Force -Path $DistDir | Out-Null

function Build-Skill {
    param([string]$SkillName)

    $srcDir = Join-Path $RepoDir "skills\$SkillName"
    $outZip = Join-Path $DistDir "$SkillName.skill"

    if (-not (Test-Path $srcDir)) {
        Write-Warning "  skipping $SkillName — $srcDir not found"
        return
    }

    if (Test-Path $outZip) {
        Remove-Item $outZip -Force
    }

    # Zip the *contents* of the skill folder, not the folder itself, so
    # SKILL.md ends up at the root of the archive as required.
    Compress-Archive -Path (Join-Path $srcDir "*") -DestinationPath $outZip -Force
    Write-Host "  built dist\$SkillName.skill"
}

Build-Skill -SkillName "file-renamer"
Build-Skill -SkillName "file-archive-audit"

# ---- 4. Done ----------------------------------------------------------------

Write-Host ""
Write-Host "Done."
Write-Host "  File Archive:      $ArchiveTarget"
Write-Host "  Living Reference:  $ReferenceTarget"
if (Test-Path (Join-Path $DistDir "file-renamer.skill")) {
    Write-Host "  Skill packages:     $DistDir"
}
Write-Host ""
Write-Host "Next: open SETUP_GUIDE.md and continue from step 2."
