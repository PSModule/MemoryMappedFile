function New-MemoryMappedFile {
    [OutputType([System.IO.MemoryMappedFiles.MemoryMappedFile])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Name,

        [Parameter(Mandatory)]
        [string] $Path,

        [Parameter()]
        [long] $FileSize = 1Mb
    )
    if (Test-Path $Path) {
        $file = Get-Item -Path $Path
        $filesize = $file.Length
    } else {
        $file = New-Item -Path $Path -ItemType File -Force
    }
    return [System.IO.MemoryMappedFiles.MemoryMappedFile]::CreateFromFile(
        $Path,
        [System.IO.FileMode]::OpenOrCreate,
        $Name,
        $FileSize
    )
}
