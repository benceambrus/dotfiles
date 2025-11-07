# Alias commands
Function TitusUtil
{ Invoke-WebRequest -useb https://christitus.com/win | Invoke-Expression 
}
Set-Alias -Name titus -Value TitusUtil

# Add fzf to path.
$env:PATH = "C:\Users\Ambri\AppData\Local\Microsoft\WinGet\Links;$env:PATH"

# Chezmoi Git Alias
Function ChezmoiGit
{
  $currDir = $pwd
  cd ~\.local\share\chezmoi; git add .
  git commit -m "Automatic commit from chezmoi-git."
  git push origin main
  cd $currDir
}
Set-Alias -Name chezmoi-git -Value ChezmoiGit

# Starship
# if (Get-Command starship)
# {
#   $ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
#   Invoke-Expression (&starship init powershell)
# }

# Oh-my-posh
if (Get-Command -ErrorAction SilentlyContinue oh-my-posh)
{
  oh-my-posh --config $env:USERPROFILE\.config\oh-my-posh.omp.yml init pwsh | Invoke-Expression
}

# Editor
$env:Editor = "nvim"

# Vi-mode with cursor indicator
Set-PsReadLineOption -EditMode Vi
$OnViModeChange = [scriptblock] {
  if ($args[0] -eq 'Command')
  {
    # Set the cursor to a blinking block.
    Write-Host -NoNewLine "`e[1 q"
  } else
  {
    # Set the cursor to a blinking line.
    Write-Host -NoNewLine "`e[5 q"
  }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange

# LFCD
# Function lfcd { lf -print-last-dir $args | Set-Location }
# Set-Alias -Name l -Value lfcd

# PSFzf options
## Argument search and History
Set-PsFzfOption -PSReadLineChordProvider 'Ctrl+t' -PSReadLineChordReverseHistory 'Ctrl+r'

## Aliases
Set-PsFzfOption -EnableAliasFuzzyEdit # fe
Set-PsFzfOption -EnableAliasFuzzyHistory # fh
Set-PsFzfOption -EnableAliasFuzzyKillProcess # fkill
Set-PsFzfOption -EnableAliasFuzzySetLocation # fd
#$commandOverride = [ScriptBlock]{ param($Location) Write-Host $Location }
#Set-PsFzfOption -AltCCommand $commandOverride

# Yazi cd
function y
{
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp -Encoding UTF8
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
  {
    Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
  }
  Remove-Item -Path $tmp
}

# Zoxide
if (Get-Command -ErrorAction SilentlyContinue zoxide)
{ 
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# eza
function eza-grid
{ & eza --group-directories-first --icons=always 
}
function eza-long
{ & eza --long --group-directories-first --icons=always 
}
if (Get-Command eza -ErrorAction SilentlyContinue)
{
  Set-Alias -Name ls -Value eza-grid
  Set-Alias -Name ll -Value eza-long
}

# Mamba
if (Get-Command mamba -ErrorAction SilentlyContinue)
{
  # !! Contents within this block are managed by 'mamba shell init' !!
  $Env:MAMBA_ROOT_PREFIX = "~\miniforge3"
  $Env:MAMBA_EXE = "~\miniforge3\Library\bin\mamba.exe"
  (& $Env:MAMBA_EXE 'shell' 'hook' -s 'powershell' -r $Env:MAMBA_ROOT_PREFIX) | Out-String | Invoke-Expression
}
