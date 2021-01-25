---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Set-IssueFix

## SYNOPSIS
Change issue fix properties.

## SYNTAX

```
Set-IssueFix [[-Fix] <PSObject>] [[-FixDescription] <String>] [[-CheckName] <String>]
 [[-Status] <IssueFixStatus>] [[-NotificationCount] <Int64>] [[-SequenceNumber] <Int64>]
 [[-ScheduledAfter] <DateTime>] [[-Priority] <IssueFixPriority>] [-DecrementNotificationCount] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Allows for changing certain properties of an issue fix object.

## EXAMPLES

### EXAMPLE 1
```
Set-IssueFix -Fix $aFixObject -Description "This is an issue fix with a new description."
```

## PARAMETERS

### -Fix
The issue fix object to change, typically passed via pipeline.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -FixDescription
Set the description of the fix to STRING value.

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
Set the name of the fix to STRING value.

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
Set the status of the fix to STRING value.

```yaml
Type: IssueFixStatus
Parameter Sets: (All)
Aliases:
Accepted values: Ready, Pending, Complete, Error, Canceled, Hold, Scheduled

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NotificationCount
Set the notification count of the fix to INT value.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SequenceNumber
Set the sequence number of the fix to INT value.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ScheduledAfter
Sets a dateTime when the fix should be invoked AFTER

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Priority
Changes the priority to either High, Medium or Low

```yaml
Type: IssueFixPriority
Parameter Sets: (All)
Aliases:
Accepted values: Low, Medium, High

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DecrementNotificationCount
Switch which changes the fix object by decrementing the notification count by 1.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### IssueFix
## OUTPUTS

### IssueFix The changed fix object(s)
## NOTES

## RELATED LINKS
