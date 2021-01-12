BeforeAll {
    . .\localTestValues.ps1

    $DatabasePath = "TestDrive:\IssuesDB"
    $filePath = "TestDrive:\testFix.json"
    $archivePath = "TestDrive:\archiveFix.json"

    #Import module
    Import-Module ..\PoshIssues -Force
}

Describe "New-IssueFix" {
    BeforeAll {
        $result = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        $result2 = New-IssueFix -FixCommandString "Write-Output 'Hello World'" -FixDescription "First fix" -CheckName "Greetings"
    }
    
    it "should return a fix with checkName Greetings" {
        $result.checkName | should -Be "Greetings"
    }

    it "should return a Status of Ready" {
        $result.status | should -Be 0
    }
    
    it "should return a fix with an scriptblock" {
        $result2.fixCommand.InvokeReturnAsIs() | should -Be "Hello World"
    }

    it "should return a fix with default Priority of Low" {
        $result.Priority | should -Be Low
    }
}

Describe "Write-IssueFix" {
    BeforeAll {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
    }

    it "should create a JSON file in the database folder" {
        $fix | Write-IssueFix -DatabasePath $DatabasePath | Out-Null
        "$($DatabasePath)\Fixes\$($fix.id).json" | should -Exist
    }

    it "should update the JSON file in the database folder using the DatabasePath from the fix" {
        $fix = $fix | Write-IssueFix -DatabasePath $DatabasePath
        #TODO: The DatabasePath is not comming from the fix object
        $fix | Set-IssueFix -Status Error | Write-IssueFix #-DatabasePath $DatabasePath
        "$($DatabasePath)\Fixes\$($fix.id).json" | should -Exist
    }

    it "should create a JSON file at a specific location" {
        $fix | Write-IssueFix -Path $filePath | Out-Null
        $filePath | should -exist
    }

    it "should return the fix object with path set for further pipeline usage with path added" {
        $result = $fix | Write-IssueFix -Path $filePath
        $result.path | should -Be $filePath
    }

    it "should return the fix object with databasePath set for further pipeline usage with path added" {
        $filePath = "$($DatabasePath)\Fixes\$($fix.id).json"
        $result = $fix | Write-IssueFix -DatabasePath $DatabasePath
        $result.databasePath | should -Be $DatabasePath
    }
}

Describe "Remove-IssueFix" {

    it "should remove a JSON file in the database folder" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        $fix = $fix | Write-IssueFix -DatabasePath $DatabasePath

        
        #TODO: the Remove-IssueFix should take DatabasePath from the fix but doesn't
        $fix | Remove-IssueFix -DatabasePath $DatabasePath
        "$($DatabasePath)\Fixes\$($fix.id).json" | should -not -exist
    }

    it "should remove a JSON file at a specific location" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        $result = $fix | Write-IssueFix -Path $filePath

        $result | Remove-IssueFix
        $filePath | should -not -exist
    }
}

Describe "Archive-IssueFix" {
    it "should move the fix to the database archive folder" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        $fix = $fix | Write-IssueFix -DatabasePath $DatabasePath
        #TODO: Archive-IssueFix is not getting DatabasePath from pipeline
        $fix | Archive-IssueFix -DatabasePath $DatabasePath
        (Get-ChildItem "$($DatabasePath)\Fixes\Archive" | Measure-Object).Count | should -Be 1        
    }

    it "should move the fix to the ArchivePath specified" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        $result = $fix | Write-IssueFix -Path $filePath

        $result | Archive-IssueFix -ArchivePath $archivePath
        $archivePath | should -exist
    }
}

Describe "Read-IssueFix" {
    it "should read IssueFix(s) from the database" {
        New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" | Write-IssueFix -DatabasePath $DatabasePath
        New-IssueFix -FixCommand {Write-Output "Hello Josh"} -FixDescription "First fix" -CheckName "Greetings" | Write-IssueFix -DatabasePath $DatabasePath

        $fix = Read-IssueFix -DatabasePath $DatabasePath
        ($fix | Measure-Object).Count | should -Be 2
    }

    it "should read Pending IssueFix(s) from the database" {
        New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" -Status Ready | Write-IssueFix -DatabasePath $DatabasePath
        New-IssueFix -FixCommand {Write-Output "Hello Josh"} -FixDescription "First fix" -CheckName "Greetings" -Status Pending | Write-IssueFix -DatabasePath $DatabasePath

        $fix = Read-IssueFix -DatabasePath $DatabasePath -isPending
        ($fix | Measure-Object).Count | should -Be 1
    }

    it "should read Complete IssueFix(s) from the database" {
        New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" -Status Ready | Write-IssueFix -DatabasePath $DatabasePath
        New-IssueFix -FixCommand {Write-Output "Hello Josh"} -FixDescription "First fix" -CheckName "Greetings" -Status Complete | Write-IssueFix -DatabasePath $DatabasePath

        $fix = Read-IssueFix -DatabasePath $DatabasePath -isComplete
        ($fix | Measure-Object).Count | should -Be 1
    }

    it "should read IssueFix(s) from the path" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        $fix | Write-IssueFix -Path $filePath | Out-Null

        $fix = Read-IssueFix -Path $filePath
        ($fix | Measure-Object).Count | should -Be 1
    }
}

Describe "Set-IssueFix" {
    it "should change the description of the IssueFix" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        ($fix | Set-IssueFix -FixDescription "Test").fixDescription | should -Be "Test"
    }

    it "should change the Status of the IssueFix to Complete" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        ($fix | Set-IssueFix -Status Complete).status | should -Be Complete
    }
    it "should change the Status of the IssueFix to Ready" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" -Status Pending
        ($fix | Set-IssueFix -Status Ready -Verbose).status | should -Be Ready
    }
    it "should change the Status of the IssueFix to Pending" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" -Status Ready
        ($fix | Set-IssueFix -Status Pending).status | should -Be Pending
    }
    it "should change the Status of the IssueFix to Error" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" -Status Pending
        ($fix | Set-IssueFix -Status Error).status | should -Be Error
    }
    it "should change the Status of the IssueFix to Canceled" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" -Status Pending
        ($fix | Set-IssueFix -Status Canceled).status | should -Be Canceled
    }
    it "should change the Status of the IssueFix to Hold" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" -Status Pending
        ($fix | Set-IssueFix -Status Hold).status | should -Be Hold
    }
    it "should change the Status of the IssueFix to Scheduled" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" -Status Pending
        ($fix | Set-IssueFix -Status Scheduled).status | should -Be Scheduled
    }

    it "should change the NofiticationCount of the IssueFix" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        ($fix | Set-IssueFix -NotificationCount 100).notificationCount | should -Be 100
    }

    it "should change the SequenceNumber of the IssueFix" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        ($fix | Set-IssueFix -SequenceNumber 66).sequenceNumber | should -Be 66
    }

    it "should change the ScheduledAfter of the IssueFix" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        $futureDate = ((Get-Date).AddDays(2))
        ($fix | Set-IssueFix -ScheduledAfter $futureDate).scheduledAfter | should -Be $futureDate
    }

    it "should change the NofiticationCount of the IssueFix by 1" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings" -NotificationCount 101
        ($fix | Set-IssueFix -DecrementNotificationCount).notificationCount | should -Be 100
    }

    it "should change the Priority of the IssueFix to Medium" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        ($fix | Set-IssueFix -Priority Medium).Priority | should -Be Medium
    }

    it "should change the Priority of the IssueFix to High" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        ($fix | Set-IssueFix -Priority High).Priority | should -Be High
    }
}

Describe "Approve-IssueFix" {
    it "should change the Status of the IssueFix from Pending to Ready" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        ($fix | Set-IssueFix -Status Pending | Approve-IssueFix).status | should -Be Ready
    }
}

Describe "Deny-IssueFix" {
    it "should change the Status of the IssueFix from Pending to Canceled" {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        ($fix | Set-IssueFix -Status Pending | Deny-IssueFix).status | should -Be Canceled
    }
}

Describe "Invoke-IssueFix" {
    BeforeAll {
        $fix = New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
    }

    it "should invoke the ScriptBlock in the IssueFix, add the results to the IssueFix and update Status and statusDateTime" {
        $fix = $fix | Invoke-IssueFix
        $fix.fixResults | should -Be "Hello World"
    }

    it "should have updated the IssueFix status after results to be Completed" {
        $fix = $fix | Invoke-IssueFix
        $fix.status | should -Be "Complete"
    }


    it "should not invoke again as status is not Ready" {
        $fix = $fix | Invoke-IssueFix
        $lastD = $fix.statusDateTime
        STart-Sleep -Seconds 2
        $fix = $fix | Invoke-IssueFix
        $fix.statusDateTime | should -Be $lastD
    }

    it "should invoke again as Force is set" {
        $fix = $fix | Invoke-IssueFix
        $lastD = $fix.statusDateTime
        Start-Sleep -Seconds 2

        $fix = $fix | Invoke-IssueFix -Force
        $fix.statusDateTime | should -not -be $lastD
    }

    it "should invoke again as Status is Scheduled and ScheduledDate is set to yesterday" {
        $fix = $fix | Invoke-IssueFix
        $lastD = $fix.statusDateTime
        $fix = $fix | Set-IssueFix -Status Scheduled -ScheduledAfter (Get-Date).AddDays(-1)
        Start-Sleep -Seconds 2

        $fix = $fix | Invoke-IssueFix
        $fix.statusDateTime | should -not -be $lastD
    }

    it "should not invoke again even though status is Scheduled but ScheduledAfter is in the future" {
        $fix = $fix | Set-IssueFix -Status Scheduled -ScheduledAfter (Get-Date).AddDays(1)
        $lastD = $fix.statusDateTime
        Start-Sleep -Seconds 2

        $fix = $fix | Invoke-IssueFix
        $fix.statusDateTime | should -Be $lastD
    }

    it "should return an error string" {
        $fix = New-IssueFix -FixCommand {Write-Output (5 / 0)} -FixDescription "First error" -CheckName "Greetings"
        $fix = $fix | Invoke-IssueFix

        $fix.fixResults | should -BeLike "Attempted to divide by zero*"
    }

    it "should have updated the IssueFix status after results to be Completed" {
        $fix = New-IssueFix -FixCommand {Write-Output (5 / 0)} -FixDescription "First error" -CheckName "Greetings"
        $fix = $fix | Invoke-IssueFix

        $fix.status | should -Be "Error"
    }

    it "should use passed DefaultParameterValues" {
        function Test-Write-Output {
            [CmdletBinding(SupportsShouldProcess=$false,DefaultParameterSetName="example")]
            Param(
                [Parameter(Mandatory=$true)]
                [String]$Param1
            )
            Process {
                #Put process here
                Write-Output "$Param1"
            }
        }
        
        $fix = New-IssueFix -FixCommand {Test-Write-Output} -FixDescription "DefaultParameterValues" -CheckName "Greetings"

        $fix = $fix | Invoke-IssueFix -DefaultParameterValues @{"Test-Write-Output:Param1" = "Hi"}
        $fix.fixResults | should -Be "Hi"
    }
}

Describe "Limit-IssueFix" {
    BeforeAll {
        $fixes = @()
        $fixes += New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        $fixes += New-IssueFix -FixCommand {Write-Output "Hello World"} -FixDescription "First fix" -CheckName "Greetings"
        $fixes += New-IssueFix -FixCommand {Write-Output "Hi World"} -FixDescription "First fix" -CheckName "Greetings"
    }

    it "should only return the unique IssueFix objects" {
        $results = $fixes | Limit-IssueFix
        ($results | Measure-Object).Count | should -Be 2
    }
}