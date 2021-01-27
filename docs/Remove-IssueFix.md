---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Remove-IssueFix

## SYNOPSIS
Removes (deletes) an IssueFix object from the file system.

## SYNTAX

### DatabasePath (Default)
```
Remove-IssueFix [-Fix] <PSObject> [-DatabasePath] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Path
```
Remove-IssueFix [-Fix] <PSObject> [-Path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes (deletes) an IssueFix object from the file system. 
Can use the path information from the fix if present and passed through pipeline. 
Just performs a remove-item.

## EXAMPLES

### Example 1
```powershell
PS C:\> Read-IssueFix -isError | Remove-IssueFix
```

Reads all issuefix objects from the database (assuming DatabasePath set by DefaultParameterValue) that have status Error and removes (deletes) them from the database.

## PARAMETERS

### -Fix
IssueFix object(s), typically passed via the pipeline, to be removed from the file system.

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

### -DatabasePath
A string path representing the folder to use as a simple database. 
The IssueFix files will be remvoed using their iD value from a Fixes folder. 
Folders will be created as needed. 
If the IssueFix has already been saved once, the cmdlet can get the value from the pipeline object.

```yaml
Type: String
Parameter Sets: DatabasePath
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path
A string path representing the path and file name to remove. 
If the IssueFix has already been saved once, the cmdlet can get the value from the pipeline object.

```yaml
Type: String
Parameter Sets: Path
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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

## RELATED LINKS
