# Install TagLib NuGet Library (https://github.com/mono/taglib-sharp)
Install-Package -Name TagLibSharp -ProviderName NuGet -Scope CurrentUser -Destination .\lib -Force

# Load TagLib Assembly
$DLLPath = (Resolve-Path -Path "$PSScriptRoot\..\..\..\lib\TagLibSharp.dll")
[System.Reflection.Assembly]::LoadFrom($DLLPath)

$MusicLibraryPath = '.\data\music\2Pac\2pac Remixes'
$MusicFiles = (Get-ChildItem -Path $MusicLibraryPath).FullName

$File = $MusicFiles[0]
$Tag = [TagLib.File]::Create($File)

$MetaData = @{
  'Title'   = $Tag.Tag.Title
  'Album'   = $Tag.Tag.Album
  'Year'    = $Tag.Tag.Year
  'Track'   = $Tag.Tag.Track
  'Genre'   = $Tag.Tag.Genres
  'Artists' = $Tag.Tag.Artists
}

$Tag.Tag.Artists
