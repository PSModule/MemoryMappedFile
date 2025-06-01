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
        # It 'New-MemoryMappedFile' {
        #     $fileName = '$HOME\test.json'
        #     $size = 1024
        #     $mmf = New-MemoryMappedFile -Name 'shared' -Path $fileName -Size $size
        #     $mmf | Should -Not -BeNullOrEmpty
        #     Test-Path $fileName | Should -BeTrue
        # }
    }
}
