[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSReviewUnusedParameter', '',
    Justification = 'Required for Pester tests'
)]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute(
    'PSUseDeclaredVarsMoreThanAssignments', '',
    Justification = 'Required for Pester tests'
)]
[CmdletBinding()]
param()

Describe 'Module' {
    Context 'MemoryMappedFile' {
        It 'New-MemoryMappedFile' {
            $fileName = '$HOME\test.json'
            $size = 1024
            $mmf = New-MemoryMappedFile -Name 'shared' -Path $fileName -Size $size
            $mmf | Should -Not -BeNullOrEmpty
            Test-Path $fileName | Should -BeTrue
        }

        It 'Get-MemoryMappedFile' {
            $retrievedMmf = Get-MemoryMappedFile -Name 'shared'
            $retrievedMmf | Should -Not -BeNullOrEmpty
        }

        It 'Set-MemoryMappedFile' {
            $data = @{ key = 'value' }
            Set-MemoryMappedFileContent -Name 'shared' -Content (ConvertTo-Json $data)
            $retrievedData = Get-MemoryMappedFileContent -Name 'shared' | ConvertFrom-Json
            $retrievedData.key | Should -Be 'value'
        }
    }
}
