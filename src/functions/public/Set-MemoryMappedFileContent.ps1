function Set-MemoryMappedFileContent {
    <#
        .SYNOPSIS
        Writes string content into a memory-mapped file with the given name and path.

        .DESCRIPTION
        This function writes UTF-8 encoded content into a memory-mapped file at the specified path.
        It creates or updates the file using the size of the input content. If the -PassThru switch
        is used, the resulting memory-mapped file object is returned. An internal accessor is used
        to perform the write operation, and proper disposal is handled in the clean block.

        .EXAMPLE
        Set-MemoryMappedFileContent -Name "LogMap" -Path "C:\Temp\log.map" -Content "Hello, Memory Map"

        Output:
        ```powershell
        (No output unless -PassThru is specified)
        ```

        Writes "Hello, Memory Map" to a memory-mapped file named 'LogMap' located at 'C:\Temp\log.map'.

        .OUTPUTS
        System.IO.MemoryMappedFiles.MemoryMappedFile

        .NOTES
        Returns the memory-mapped file object when -PassThru is used.

        .LINK
        https://psmodule.io/MemoryMapped/Functions/Set-MemoryMappedFileContent/
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        'PSUseShouldProcessForStateChangingFunctions', '',
        Justification = 'The function only updates a memory-mapped file.'
    )]
    [OutputType([System.IO.MemoryMappedFiles.MemoryMappedFile])]
    [CmdletBinding()]
    param(
        # The name to assign to the memory-mapped file.
        [Parameter(Mandatory)]
        [string] $Name,

        # The file system path where the memory-mapped file is stored.
        [Parameter(Mandatory)]
        [string] $Path,

        # The string content to write into the memory-mapped file.
        [Parameter(Mandatory, ValueFromPipeline)]
        [string] $Content,

        # If specified, returns the memory-mapped file object after writing.
        [Parameter()]
        [switch] $PassThru
    )

    begin {}

    process {
        Write-Verbose "Setting content for memory-mapped file '$Name'."
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($Content)
        Write-Verbose "Writing content of size $($bytes.Length) bytes to memory-mapped file '$Name'."
        $size = $bytes.Length
        $mmf = Set-MemoryMappedFile -Name $Name -Path $Path -Size $size
        try {
            $accessor = $mmf.CreateViewAccessor()
        } catch {
            throw "Failed to create view accessor for memory-mapped file '$Name'. Exception: $($_.Exception.Message)"
        }
        if (-not $accessor) {
            throw "Failed to create view accessor for memory-mapped file '$Name'."
        }
        $accessor.WriteArray(0, $bytes, 0, $size)
        Write-Verbose "Content written successfully to memory-mapped file '$Name'."
    }

    end {
        if ($PassThru) {
            Write-Verbose "Returning memory-mapped file '$Name'."
            return $mmf
        }
    }

    clean {
        if ($accessor) {
            $accessor.Flush()
            $accessor.Dispose()
        }
        if ($mmf) {
            $mmf.Dispose()
        }
    }
}
