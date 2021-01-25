---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Approve-IssueFix

## SYNOPSIS
Sets the fix status to Ready.

## SYNTAX

```
Approve-IssueFix [-Fix] <PSObject> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the issue fix object status to Ready. 
Typically used on those whose status is Pending.

## EXAMPLES

### EXAMPLE 1
```
Read-IssueFix -isPending | Approve-IssueFix | Write-IssueFix
```

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

### IssueFix The approved fix object(s)
## NOTES

## RELATED LINKS
