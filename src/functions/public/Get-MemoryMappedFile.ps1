function Get-MemoryMappedFile {
    <#
        .SYNOPSIS
        Retrieves an existing memory-mapped file by name.

        .DESCRIPTION
        This function attempts to open an existing memory-mapped file identified by the provided name.
        If the file does not exist or an error occurs during access, the function returns $null instead
        of throwing an exception.

        .EXAMPLE
        Get-MemoryMappedFile -Name 'SharedMemoryBlock'

        Output:
        ```powershell
        SafeMemoryMappedFileHandle
        --------------------------
        Microsoft.Win32.SafeHandles.SafeMemoryMappedFileHandle
        ```

        Retrieves the memory-mapped file named 'SharedMemoryBlock'.

        .OUTPUTS
        System.IO.MemoryMappedFiles.MemoryMappedFile

        .NOTES
        The memory-mapped file object if successful.
        null. Returned when the specified memory-mapped file does not exist or an error occurs.

        .LINK
        https://psmodule.io/Memory/Functions/Get-MemoryMappedFile
    #>

    [OutputType([System.IO.MemoryMappedFiles.MemoryMappedFile])]
    [CmdletBinding()]
    param(
        # The name of the memory-mapped file to open.
        [Parameter(Mandatory)]
        [string] $Name
    )
    try {
        return [System.IO.MemoryMappedFiles.MemoryMappedFile]::OpenExisting($Name)
    } catch {
        return $null
    }
}
