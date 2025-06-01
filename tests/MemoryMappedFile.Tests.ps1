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
            $path = './shared.json'
            $mmf = New-MemoryMappedFile -Name 'shared' -Path $path
            { $mmf.Dispose() } | Should -Not -Throw
            $mmf | Should -Not -BeNullOrEmpty
            Test-Path $path | Should -BeTrue
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
