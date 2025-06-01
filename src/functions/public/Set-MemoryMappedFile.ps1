function Set-MemoryMappedFile {
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
    $mmf = Get-MemoryMappedFile -Name $Name
    if ($mmf) {
        return $mmf
    }

    return New-MemoryMappedFile -Name $Name -Path $Path -FileSize $FileSize
}
