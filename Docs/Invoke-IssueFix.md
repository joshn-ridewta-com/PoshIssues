---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Invoke-IssueFix

## SYNOPSIS
Takes each fix object passed and invoked the scriptblock adding the results to the object.

## SYNTAX

```
Invoke-IssueFix [-Fix] <PSObject> [-Force] [-DefaultParameterValues <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
For each issue fix object passed, if the object status is
Ready, Scheduled AND ScheduledAfter is in the past, or Force is set
invokes the scriptblock. 
Add the results to the object and sets status
to either Complete or Error. 
The scriptblock is invoked in a child scope.

## EXAMPLES

### EXAMPLE 1
```
Read-IssueFix | Invoke-IssueFix
```

## PARAMETERS

### -Fix
The issue fix object to invoke, typically passed via pipeline.

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

### -Force
Invokes all passed fix objects no matter of status.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultParameterValues
Due to the child scope, DefaultParameterValues are not inherited. 
If needed,
pass existing or new DefaultParameterValues into the child scope using this parameter.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### IssueFix The fix object(s) passed through the cmdlet
## NOTES
The scriptblock in invoked using the InvokeWithContext method. 
DefaultParameterValues, if
provided is passed into the context.

## RELATED LINKS
