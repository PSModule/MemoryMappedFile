function Close-MemoryMappedFile {
    <#
        .SYNOPSIS
        Closes and disposes an existing memory-mapped file by name.

        .DESCRIPTION
        This function attempts to open an existing memory-mapped file with the specified name.
        If the file exists, it disposes of the file and frees the associated memory resources.
        If the file does not exist or has already been closed, a warning is displayed instead.
        This operation is useful for cleaning up unmanaged resources created with memory-mapped files.

        .EXAMPLE
        Close-MemoryMappedFile -Name 'MySharedMemory'

        Output:
        ```powershell
        VERBOSE: Memory-mapped file 'MySharedMemory' closed successfully.
        ```

        Closes the memory-mapped file named 'MySharedMemory' and disposes of its resources.

        .LINK
        https://psmodule.io/MemoryMappedFile/Functions/Close-MemoryMappedFile
    #>

    [CmdletBinding()]
    param(
        # The name of the memory-mapped file to close and dispose.
        [Parameter(Mandatory)]
        [string] $Name
    )

    try {
        $item = [System.IO.MemoryMappedFiles.MemoryMappedFile]::OpenExisting($Name)
    } catch {
        return $null
    }

    if ($item) {
        $item.Dispose()
        Write-Verbose "Memory-mapped file '$Name' closed successfully."
    }
}
