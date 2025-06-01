function Close-MemoryMappedFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Name
    )

    try {
        $item = [System.IO.MemoryMappedFiles.MemoryMappedFile]::OpenExisting($Name)
    } catch {
        $null
    }

    if ($item) {
        $item.Dispose()
        Write-Verbose "Memory-mapped file '$Name' closed successfully."
    } else {
        Write-Warning "Memory-mapped file '$Name' does not exist or is already closed."
    }
}
