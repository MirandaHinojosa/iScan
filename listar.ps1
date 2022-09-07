try
{
    # Load WinSCP .NET assembly
    Add-Type -Path "WinSCPnet.dll"
 
    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions
    $sessionOptions.Protocol = [WinSCP.Protocol]::Sftp
    $sessionOptions.HostName = "10.192.152.15"
    $sessionOptions.UserName = "gedsa"
    $sessionOptions.Password = "HArnau@Gedsa2015"
    $sessionOptions.SshHostKeyFingerprint = "ssh-rsa 2048 26:87:a5:d0:5b:8d:5d:4c:11:42:be:e9:3a:40:da:bb"
 
    $session = New-Object WinSCP.Session
 
    try
    {
        # Connect
        $session.Open($sessionOptions)
 
        $directory = $session.ListDirectory("/volcados/gedsa")
 
        foreach ($fileInfo in $directory.Files)
        {
            Write-Host ("{0} with size {1}, permissions {2} and last modification at {3}" -f
                $fileInfo.Name, $fileInfo.Length, $fileInfo.FilePermissions, $fileInfo.LastWriteTime)
        }
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }
 
    exit 0
}
catch [Exception]
{
    Write-Host $_.Exception.Message
    exit 1
}