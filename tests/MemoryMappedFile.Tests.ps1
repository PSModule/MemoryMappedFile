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
            $fileName = 'test.mmf'
            $size = 1024
            $mmf = New-MemoryMappedFile -FileName $fileName -Size $size
            $mmf | Should -Not -BeNullOrEmpty
            Test-Path $fileName | Should -BeTrue
        }
    }
}
