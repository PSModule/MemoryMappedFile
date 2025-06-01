function Show-MemoryMappedFile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Name,

        [Parameter()]
        [int] $RefreshSeconds = 1
    )

    begin {}

    process {
        while ($true) {
            Read-MemoryMappedFileContent -Name $Name
            Start-Sleep -Seconds $RefreshSeconds
            Clear-Host
        }
    }

    end {}
}
