---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Deny-IssueFix

## SYNOPSIS
Sets the issue fix status to Canceled.

## SYNTAX

```
Deny-IssueFix [-Fix] <PSObject> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the issue fix object status to Canceled. 
Typically used on those whose status is Pending.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Read-IssueFix -isPending | Deny-IssueFix | Write-IssueFix
```

Retrieves pending issues fixes (assuming DatabasePath set by DefaultParameterValue), changes the status to Canceled and then writes them back to the database (assuming DatabasePath set by DefaultParameterValue).

## PARAMETERS

### -Fix
The issue fix object to change, typically passed via pipeline.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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

### IssueFix The denied fix object(s)
## NOTES

## RELATED LINKS
