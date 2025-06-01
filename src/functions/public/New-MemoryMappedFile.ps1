function New-MemoryMappedFile {
    <#
        .SYNOPSIS
        Creates a memory-mapped file from a specified file path and name.

        .DESCRIPTION
        This function creates a memory-mapped file using a specified name and backing file path.
        If the file exists, it uses the existing file and its size. If the file does not exist, a new file
        is created at the specified path. The memory-mapped file is created with a default size of 1MB unless
        otherwise specified. The function returns a [System.IO.MemoryMappedFiles.MemoryMappedFile] object.

        .EXAMPLE
        New-MemoryMappedFile -Name 'SharedMap' -Path 'C:\Temp\shared.dat'

        Output:
        ```powershell
        Capacity            : 1048576
        SafeMemoryMappedFileHandle : Microsoft.Win32.SafeHandles.SafeMemoryMappedFileHandle
        ```

        Creates a memory-mapped file named 'SharedMap' backed by 'C:\Temp\shared.dat' with a default size of 1MB.

        .OUTPUTS
        System.IO.MemoryMappedFiles.MemoryMappedFile

        .NOTES
        Represents the memory-mapped file created using the specified parameters.
        The returned object can be used for inter-process communication or efficient file access.

        .LINK
        https://psmodule.io/MemoryMapped/Functions/New-MemoryMappedFile/
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSUseShouldProcessForStateChangingFunctions', '',
        Justification = 'The function only creates a memory-mapped file and does not modify system state in a way that requires confirmation.'
    )]
    [OutputType([System.IO.MemoryMappedFiles.MemoryMappedFile])]
    [CmdletBinding()]
    param(
        # The unique name for the memory-mapped file.
        [Parameter(Mandatory)]
        [string] $Name,

        # Specifies the path to the file backing the memory-mapped file.
        [Parameter(Mandatory)]
        [string] $Path,

        # Specifies the size of the memory-mapped file in bytes. Defaults to 1MB.
        [Parameter()]
        [long] $Size = 1Mb
    )

    if (Test-Path $Path) {
        $file = Get-Item -Path $Path
        $Size = $file.Length
        if ($Size -gt 0) {
            Write-Verbose "Opening existing file from '$Path' as '$Name'"
            return [System.IO.MemoryMappedFiles.MemoryMappedFile]::CreateFromFile(
                $Path,
                [System.IO.FileMode]::OpenOrCreate,
                $Name
            )
        }
    }

    Write-Verbose "Opening new file at '$Path' as '$Name'"
    return [System.IO.MemoryMappedFiles.MemoryMappedFile]::CreateFromFile(
        $Path,
        [System.IO.FileMode]::OpenOrCreate,
        $Name,
        $Size
    )
}

#SkipTest:FunctionTest:Will add a test for this function in a future PR
