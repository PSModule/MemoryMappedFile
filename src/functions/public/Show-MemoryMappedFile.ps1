function Show-MemoryMappedFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Name
    )

    begin {}

    process {
        while ($true) {
            Read-MemoryMappedFileContent -Name 'shared'
            Start-Sleep -Seconds 1
            Clear-Host
        }
    }

    end {}
}
