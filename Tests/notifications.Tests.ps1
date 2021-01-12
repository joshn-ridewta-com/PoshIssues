BeforeAll {
    #Import module
    Import-Module ..\PoshIssues -Force
}
Describe "Send-IssueMailMessage" {
    BeforeAll {
        $fixes = @()
        $fixes += New-IssueFix -FixCommand {Write-Output "Hello Completed"} -FixDescription "Completed fix" -CheckName "Greetings" -Status Complete -NotificationCount 1
        $fixes += New-IssueFix -FixCommand {Write-Output "Hello Pending 1"} -FixDescription "Pending fix 1" -CheckName "Greetings" -Status Pending -NotificationCount 1
        $fixes += New-IssueFix -FixCommand {Write-Output "Hello Pending 2"} -FixDescription "Pending fix 2" -CheckName "Greetings" -Status Pending
        $fixes += New-IssueFix -FixCommand {Write-Output "Hello Error"} -FixDescription "Error fix" -CheckName "Greetings" -Status Error -NotificationCount 1
        $fixes += New-IssueFix -FixCommand {Write-Output "Hello Canceled"} -FixDescription "Canceled fix" -CheckName "Greetings" -Status Canceled
        $fixes += New-IssueFix -FixCommand {Write-Output "Hello Held"} -FixDescription "Held fix" -CheckName "Greetings" -Status Hold -NotificationCount 1
    }

    it "Message should -Be sent and 6 fixes returned" {
        $results = $fixes | Send-IssueMailMessage
        ($results).Count | should -Be 6
    }

    it "Message should -Be sent and 1 fix returned" {
        $fixes = $fixes | Send-IssueMailMessage
        $results = $fixes | Send-IssueMailMessage -ReturnOnlySent
        ($results | Where-Object NotificationCount -gt 0).Count | should -Be 2
    }

    it "Message should NOT be sent as it is held and 0 fixes returned" {
        $heldFix = New-IssueFix -FixCommand {Write-Output "Hello Hold"} -FixDescription "Held fix" -CheckName "Greetings" -Status Hold -NotificationCount 2
        $results = $heldFix | Send-IssueMailMessage -ReturnOnlySent
        ($results | Measure-Object).Count | should -Be 0
    }

    it "Messages should NOT be sent as they are held and 0 fixes returned" {
        $heldFixes = @()
        $heldFixes += New-IssueFix -FixCommand {Write-Output "Hello Hold 1"} -FixDescription "Held fix 1" -CheckName "Greetings" -Status Hold -NotificationCount 2
        $heldFixes += New-IssueFix -FixCommand {Write-Output "Hello Hold 2"} -FixDescription "Held fix 2" -CheckName "Greetings" -Status Hold -NotificationCount 2
    
        $results = $heldFixes | Send-IssueMailMessage -ReturnOnlySent
        ($results | Measure-Object).Count | should -Be 0
    }

    it "Message should -Be sent and 2 fix returned" {
        $fixes = @()
        $fixes += New-IssueFix -FixCommand {Write-Output "Hello Completed"} -FixDescription "Completed fix" -CheckName "Greetings" -Status Complete -NotificationCount 1
        $heldFix = New-IssueFix -FixCommand {Write-Output "Hello Hold"} -FixDescription "Held fix" -CheckName "Greetings" -Status Hold -NotificationCount 2
        
        $fixes += $heldFix
        $results = $fixes | Send-IssueMailMessage
        ($results | Measure-Object).Count | should -Be 2
    }
}