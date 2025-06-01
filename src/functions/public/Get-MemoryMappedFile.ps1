function Get-MemoryMappedFile {
    [OutputType([System.IO.MemoryMappedFiles.MemoryMappedFile])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Name
    )
    try {
        return [System.IO.MemoryMappedFiles.MemoryMappedFile]::OpenExisting($Name)
    } catch {
        return $null
    }
}
