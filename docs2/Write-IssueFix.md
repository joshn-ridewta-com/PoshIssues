---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Write-IssueFix

## SYNOPSIS
Writes (saves) an IssueFix object to the file system as a JSON file.

## SYNTAX

### DatabasePath (Default)
```
Write-IssueFix [-Fix] <PSObject> [-DatabasePath] <String> [-NoClobber] [-PassThru] [<CommonParameters>]
```

### Path
```
Write-IssueFix [-Fix] <PSObject> [-Path] <String> [-NoClobber] [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
Writes (saves) an IssueFix object to the file system as a JSON file. 
Supports saving to a specific Path or to a Database folder structure.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Fix
IssueFix object(s), typically passed via the pipeline, to be written to the file system as a JSON object.

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
The IssueFix files will be saved as JSON files using their iD value into a Fixes folder. 
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
A string path representing the path and file name to save the JSON content as. 
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

### -NoClobber
Switch to prevent an existing file from being overwritten, otherwise by default, the existing file is overwritten.

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

### -PassThru
Use PassThru switch with NoClobber to get all Fixes passed thru, otherwise only Fixes written are passed thru.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### IssueFix
## OUTPUTS

### IssueFix The fix object(s) passed through the cmdlet
## NOTES

## RELATED LINKS
