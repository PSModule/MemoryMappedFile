function Show-MemoryMappedFile {
    <#
        .SYNOPSIS
        Continuously displays the contents of a memory-mapped file in the console.

        .DESCRIPTION
        This function reads and displays the contents of a specified memory-mapped file in a loop,
        refreshing the view at a user-defined interval. It uses `Read-MemoryMappedFileContent` to
        retrieve data and clears the console after each refresh cycle.

        .EXAMPLE
        Show-MemoryMappedFile -Name 'SharedBuffer' -RefreshSeconds 2

        Output:
        ```powershell
        Data: Hello from another process!
        Timestamp: 2025-06-01T12:00:00
        ```

        Continuously displays the content of the 'SharedBuffer' memory-mapped file, refreshing every 2 seconds.

        .LINK
        https://psmodule.io/MemoryMapped/Functions/Show-MemoryMappedFile
    #>
    [CmdletBinding()]
    param(
        # The name of the memory-mapped file to read and display.
        [Parameter(Mandatory)]
        [string] $Name,

        # The number of seconds to wait between refreshes of the displayed content.
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

#SkipTest:FunctionTest:Will add a test for this function in a future PR
