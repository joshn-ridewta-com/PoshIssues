---
external help file: fixes-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Read-IssueFix

## SYNOPSIS
Reads an IssueFix object from the file system.

## SYNTAX

### DatabasePath (Default)
```
Read-IssueFix [-DatabasePath] <String> [-IncludeArchive] [-OnlyArchive] [-isPending] [-isComplete] [-isReady]
 [-isError] [-isCanceled] [-isHold] [-isScheduled] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Path
```
Read-IssueFix [-Path] <String> [-isPending] [-isComplete] [-isReady] [-isError] [-isCanceled] [-isHold]
 [-isScheduled] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Reads an IssueFix object from the file system. 
File must have previousely been written to file system.

## EXAMPLES

### Example 1
```powershell
PS C:\> Read-IssueFix -DatabasePath C:\Issues
```

Reads all issuefix objects from the file/folder based database found at C:\Issues.

## PARAMETERS

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

### -IncludeArchive
Include IssueFix files archived in the database.
(all)

```yaml
Type: SwitchParameter
Parameter Sets: DatabasePath
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnlyArchive
Read just from the database archive.

```yaml
Type: SwitchParameter
Parameter Sets: DatabasePath
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

### -isPending
Switch to return only IssueFix objects where status is Pending.

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

### -isComplete
Switch to return only IssueFix objects where status is Complete.

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

### -isReady
Switch to return only IssueFix objects where status is Ready.

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

### -isError
Switch to return only IssueFix objects where status is Error.

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

### -isCanceled
Switch to return only IssueFix objects where status is Canceled.

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

### -isHold
{{ Fill isHold Description }}

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

### -isScheduled
{{ Fill isScheduled Description }}

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

## OUTPUTS

### IssueFix The fix object(s) read from file system
## NOTES

## RELATED LINKS
