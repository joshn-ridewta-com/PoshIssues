---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Archive-IssueFix

## SYNOPSIS
Archives (moves) an IssueFix object in the file system.

## SYNTAX

### DatabasePath (Default)
```
Archive-IssueFix [-Fix] <PSObject> [-DatabasePath] <String> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Path
```
Archive-IssueFix [-Fix] <PSObject> [-Path] <String> [-ArchivePath] <String> [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Archives (moves) an IssueFix object in the file system. 
File must have previousely been written to file system. 
Can use the path information from the fix if present and passed through pipeline. 
Just performas a move-item.

## EXAMPLES

### Example 1
```powershell
PS C:\> Read-IssueFix -isComplete | Archive-IssueFix
```

Retrieves the issuefixes that have status Complete (assuming DatabasePath set by DefaultParameterValue) and passes those to the archive cmdlet which moves them to the archive folder in the database (assuming DatabasePath set by DefaultParameterValue).

## PARAMETERS

### -Fix
IssueFix object(s), typically passed via the pipeline, to be moved to archive location.

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
The IssueFix files will be moved to an Archive folder under the Fixes folder and the filename will be appended with the current datatime. 
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
A string path representing the path and file name to current JSON file. 
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

### -ArchivePath
{{ Fill ArchivePath Description }}

```yaml
Type: String
Parameter Sets: Path
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force
Switch to force overwritting any existing file.

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
