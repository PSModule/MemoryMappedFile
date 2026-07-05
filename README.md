# MemoryMappedFile

MemoryMappedFile is a PowerShell module for creating, reading, writing, and closing named memory-mapped files.

## Prerequisites

- PowerShell with `Microsoft.PowerShell.PSResourceGet` available for `Install-PSResource`.
- The [PSModule framework](https://github.com/PSModule) is used for building, testing, and publishing the module.

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-PSResource -Name MemoryMappedFile
Import-Module -Name MemoryMappedFile
```

## Commands

- `New-MemoryMappedFile` creates a named memory-mapped file from a backing file path.
- `Set-MemoryMappedFile` returns an existing map by name or creates it when missing.
- `Get-MemoryMappedFile` opens an existing named map.
- `Set-MemoryMappedFileContent` writes UTF-8 string content to a named map.
- `Read-MemoryMappedFileContent` reads UTF-8 string content from a named map.
- `Show-MemoryMappedFile` displays map content repeatedly in the console.
- `Close-MemoryMappedFile` disposes a named map.

## Usage

Create or open a map backed by a file:

```powershell
Set-MemoryMappedFile -Name 'SharedMap' -Path './shared.dat' -Size 2MB
```

Write and read string content:

```powershell
Set-MemoryMappedFileContent -Name 'SharedMap' -Path './shared.dat' -Content 'Hello from PowerShell'
Read-MemoryMappedFileContent -Name 'SharedMap'
```

Close the map when finished:

```powershell
Close-MemoryMappedFile -Name 'SharedMap'
```

## Examples

More usage examples are available in the [examples](examples) folder.

## Documentation

Command documentation is published at [psmodule.io/MemoryMappedFile](https://psmodule.io/MemoryMappedFile/).

## Contributing

Issues and pull requests are welcome. Please use the repository issue tracker to report bugs, request features, or discuss improvements.
