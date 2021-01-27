---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# New-IssueFix

## SYNOPSIS
Creates a new IssueFix object with the passed parameters

## SYNTAX

### Block (Default)
```
New-IssueFix [-FixCommand] <ScriptBlock> [[-FixDescription] <String>] [[-CheckName] <String>]
 [[-Status] <IssueFixStatus>] [[-NotificationCount] <Int64>] [[-SequenceNumber] <Int64>]
 [[-ScheduledAfter] <DateTime>] [[-Priority] <IssueFixPriority>] [-useCommandAsDescription]
 [<CommonParameters>]
```

### String
```
New-IssueFix [-FixCommandString] <String> [[-FixDescription] <String>] [[-CheckName] <String>]
 [[-Status] <IssueFixStatus>] [[-NotificationCount] <Int64>] [[-SequenceNumber] <Int64>]
 [[-ScheduledAfter] <DateTime>] [[-Priority] <IssueFixPriority>] [-useCommandAsDescription]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new IssueFix object with the passed parameters, using defaults as needed.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-IssueFix -FixCommand {echo 'Hello World'} -Status Pending -Priority Low
```

This will create a simple fix that when executed it simply echos 'Hello World'.  It is created with a status of Pending so unless it is changed to ready (Approve-IssueFix) of invoked with Force, it will not invoke.  Priorty is set to Low.  The object is returned to the pipeline and NOT saved to the database automatically, use Write-IssueFix to save it beyond the pipeline.

## PARAMETERS

### -FixCommand
A ScriptBlock to be added to that fix that will be executed to fix the issue.

```yaml
Type: ScriptBlock
Parameter Sets: Block
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -FixCommandString
A String that can be converted to a ScriptBlock to be added to that fix that will be executed to fix the issue.

```yaml
Type: String
Parameter Sets: String
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -FixDescription
A user friendly description of what the fix does, prefereble specific to this instance.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CheckName
Name of the issue check that generated this fix.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Status
The status of this fix. 
See IssueFixStatus enum. 
Default is Ready.

```yaml
Type: IssueFixStatus
Parameter Sets: (All)
Aliases:
Accepted values: Ready, Pending, Complete, Error, Canceled, Hold, Scheduled

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NotificationCount
Set the number of times notices is sent about this fix. 
Usefull for scheduled notifications of pending fixes. 
Each time a notificaton is sent for a fix the notificationCount is decremented by one.
By default, only fixes with a notification count greater then 0 are sent.
This allows for control over how often a fix is notified about. 
Default is 10000.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 10000
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SequenceNumber
Fix sort order. 
Default is 1.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 1
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ScheduledAfter
DateTime (defaults to current) in which the fix is able to be invoked when status is also Scheduled

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Priority
Priority High, Meduim or Low. 
Defaults to Low.

```yaml
Type: IssueFixPriority
Parameter Sets: (All)
Aliases:
Accepted values: Low, Medium, High

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -useCommandAsDescription
Switch to ignore the passed description, if any, and instead use the command as a string value for description.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### ScriptBlock representing the script that will be invoked by the fix
### String representing the script that will be invoked by the fix
## OUTPUTS

### IssueFix The fix object(s) created by the cmdlet
## NOTES

## RELATED LINKS
