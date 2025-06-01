function Read-MemoryMappedFileContent {
    param(
        [Parameter(Mandatory)]
        [string] $Name
    )

    begin {}

    process {
        $mmf = Get-MemoryMappedFile -Name $Name
        if (-not $mmf) {
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
