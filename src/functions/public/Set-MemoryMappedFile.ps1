function Set-MemoryMappedFile {
    <#
        .SYNOPSIS
        Creates or returns an existing memory-mapped file by name.

        .DESCRIPTION
        Checks whether a memory-mapped file with the given name already exists. If it does, returns it.
        If not, creates a new memory-mapped file backed by the specified path and size. This function
        ensures idempotent access to shared memory regions through named mapping.

        .EXAMPLE
        Set-MemoryMappedFile -Name 'MySharedMap' -Path 'C:\temp\shared.dat' -Size 2MB

        Output:
        ```powershell
        Capacity : 2097152
        Name     : MySharedMap
        SafeMemoryMappedFileHandle : Microsoft.Win32.SafeHandles.SafeMemoryMappedFileHandle
        ```

        Returns a new memory-mapped file named 'MySharedMap' backed by 'C:\temp\shared.dat' with a size of 2MB.

        .OUTPUTS
        System.IO.MemoryMappedFiles.MemoryMappedFile

        .NOTES
        Represents the created or retrieved memory-mapped file object.
        Provides access to shared memory backed by a file with support for named access and reuse.

        .LINK
        https://psmodule.io/MemoryMapped/Functions/Set-MemoryMappedFile/
    #>
    [OutputType([System.IO.MemoryMappedFiles.MemoryMappedFile])]
    [CmdletBinding()]
    param(
        # The unique name for the memory-mapped file.
        [Parameter(Mandatory)]
        [string] $Name,

        # Path to the file backing the memory-mapped region.
        [Parameter(Mandatory)]
        [string] $Path,

        # Size in bytes of the memory-mapped file. Defaults to 1MB if not specified.
        [Parameter()]
        [long] $Size = 1MB
    )
    $mmf = Get-MemoryMappedFile -Name $Name
    if ($mmf) {
        return $mmf
    }

    return New-MemoryMappedFile -Name $Name -Path $Path -Size $Size
}
