function Read-MemoryMappedFileContent {
    <#
        .SYNOPSIS
        Reads the content of an existing memory-mapped file.

        .DESCRIPTION
        This function opens a memory-mapped file by name and reads its entire content as a UTF-8 encoded string.
        If the file does not exist or cannot be accessed, the function returns null.
        Leading and trailing null characters are trimmed from the result.

        .EXAMPLE
        Read-MemoryMappedFileContent -Name 'SharedBuffer'

        Output:
        ```powershell
        Hello from shared memory!
        ```

        Reads the contents of the memory-mapped file named 'SharedBuffer' and outputs the decoded string.

        .OUTPUTS
        string

        .NOTES
        The UTF-8 decoded string content of the memory-mapped file. Returns null if the file is inaccessible.

        .LINK
        https://psmodule.io/MemoryMapped/Functions/Read-MemoryMappedFileContent
    #>
    [OutputType([string])]
    [CmdletBinding()]
    param(
        # The unique name for the memory-mapped file.
        [Parameter(Mandatory)]
        [string] $Name
    )

    begin {}

    process {
        try {
            $mmf = [System.IO.MemoryMappedFiles.MemoryMappedFile]::OpenExisting($Name)
        } catch {
            return $null
        }
        $accessor = $mmf.CreateViewAccessor()
        $buffer = New-Object byte[] $accessor.Capacity
        $null = $accessor.ReadArray(0, $buffer, 0, $accessor.Capacity)
        $content = ([System.Text.Encoding]::UTF8.GetString($buffer)).Trim([char]0)
        return $content
    }

    end {}

    clean {
        if ($accessor) {
            $accessor.Dispose()
        }
    }
}
