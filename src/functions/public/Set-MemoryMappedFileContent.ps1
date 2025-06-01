function Set-MemoryMappedFileContent {
    param(
        [Parameter(Mandatory)]
        [string] $Name,

        [Parameter(Mandatory)]
        [string] $Path,

        [Parameter(Mandatory, ValueFromPipeline)]
        [string] $Content,

        [Parameter()]
        [switch] $PassThru
    )

    begin {}

    process {
        Write-Verbose "Setting content for memory-mapped file '$Name'."
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($Content)
        Write-Verbose "Writing content of size $($bytes.Length) bytes to memory-mapped file '$Name'."
        $size = $bytes.Length
        $mmf = Set-MemoryMappedFile -Name $Name -Path $Path -FileSize $size
        try {
            $accessor = $mmf.CreateViewAccessor()
        } catch {
            Write-Error "Failed to create view accessor for memory-mapped file '$Name'."
            throw $_
        }
        if (-not $accessor) {
            Write-Error "Failed to create view accessor for memory-mapped file '$Name'."
            throw $_
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
    }
}
