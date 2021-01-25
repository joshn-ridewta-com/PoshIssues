---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Limit-IssueFix

## SYNOPSIS
Removes duplicate issue fix objects from pipeline.

## SYNTAX

```
Limit-IssueFix [-Fix] <PSObject> [<CommonParameters>]
```

## DESCRIPTION
Removes duplicate issue fix objects from pipeline. 
Duplicates are matched by iD. 
Only the oldest fix object of each matching by iD is passed on.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Fix
The issue fix object, only useful if a collection of them is passed via pipeline.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### IssueFix
## OUTPUTS

### IssueFix The fix object(s) passed through the cmdlet
## NOTES

## RELATED LINKS
