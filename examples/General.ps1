#
# Monitor process
#
Show-MemoryMappedFile -Name 'shared'


#
# Client that writes to the memory-mapped file
#
$params = @{
    Name    = 'shared'
    Path    = "$HOME\shared.json"
    Content = [PSCustomObject]@{
        Name    = 'This is my name'
        Size    = 'XL'
        Content = 'This is my content'
        Date    = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
        Tags    = @('tag1', 'tag2', 'tag3')
    } | ConvertTo-Json -Depth 10
}
Set-MemoryMappedFileContent @params -PassThru
