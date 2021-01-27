---
external help file: notifications-help.xml
Module Name: PoshIssues
online version:
schema: 2.0.0
---

# Send-IssueMailMessage

## SYNOPSIS
Sends a mail message with error, pending and completed fixes listed in simple HTML tables.

## SYNTAX

```
Send-IssueMailMessage [[-Fix] <PSObject>] [-IgnoreNotificationCount] [[-SkipStatus] <String[]>]
 [-ReturnOnlySent] [-Attachments <String[]>] [-Bcc <String[]>] [[-Body] <String>] [-Encoding <Encoding>]
 [-Cc <String[]>] [-DeliveryNotificationOption <DeliveryNotificationOptions>] -From <String>
 [[-SmtpServer] <String>] [-Priority <MailPriority>] [[-Subject] <String>] [-To] <String[]>
 [-Credential <PSCredential>] [-UseSsl] [-Port <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Sends a mail message with error, pending and completed fixes listed in simple HTML tables. 
Uses the Send-MailMessage cmdlet and thus inherits all of its parameters. 
It overrides the Body and BodyAsHTML parameers. 
Returns issue fix objects with notification count potentially changed.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Read-IssueFix | Send-IssueMailMessage -From no-reply@contoso.com -To cares@contoso.com | Write-IssueFix
```
Reads all issuefix objects (assuming DatabasePath set by DefaultParameterValue) and sends a summary of them as an email to cares@contosa.com and saves the results of the act of sending the email (decrementing the notification count) back to the database.

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

### -IgnoreNotificationCount
For fixes in Error or Pending status, sends them even if notification count is equal or less then zero and does not decrement the notification count.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipStatus
When determining if there are fixes to send, ignore fixes with these status values. 
They will still be sent but only if there are others justifying the notification. 
Defaults to "Hold"

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: @("Hold")
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReturnOnlySent
{{ Fill ReturnOnlySent Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Attachments
Specifies the path and file names of files to be attached to the email message.
You can use this parameter or pipe the paths and file names to Send-MailMessage.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: PsPath

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Bcc
Specifies the email addresses that receive a copy of the mail but are not listed as recipients of the message.
Enter names (optional) and the email address, such as Name \<someone@fabrikam.com\>.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body
Specifies additional content to append to end of the email message.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
Specifies the type of encoding for the target file.
The default value is UTF8NoBOM.

```yaml
Type: Encoding
Parameter Sets: (All)
Aliases: BE

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Cc
Specifies the email addresses to which a carbon copy (CC) of the email message is sent.
Enter names (optional) and the email address, such as Name \<someone@fabrikam.com\>.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeliveryNotificationOption
Specifies the delivery notification options for the email message.
You can specify multiple values.
None is the default value.
The alias for this parameter is DNO.

```yaml
Type: DeliveryNotificationOptions
Parameter Sets: (All)
Aliases: DNO
Accepted values: None, OnSuccess, OnFailure, Delay, Never

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -From
The From parameter is required.
This parameter specifies the sender's email address.
Enter a name (optional) and email address, such as Name \<someone@fabrikam.com\>.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SmtpServer
Specifies the name of the SMTP server that sends the email message.

```yaml
Type: String
Parameter Sets: (All)
Aliases: ComputerName

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Priority
Specifies the priority of the email message.
Normal is the default.
The acceptable values for this parameter are Normal, High, and Low.

```yaml
Type: MailPriority
Parameter Sets: (All)
Aliases:
Accepted values: Normal, Low, High

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subject
The Subject parameter is not required.
This parameter specifies the subject of the email message. 
Defaults to "Results of Invoke-IssueCheck $(Get-Date)"

```yaml
Type: String
Parameter Sets: (All)
Aliases: sub

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -To
The To parameter is required.
This parameter specifies the recipient's email address.
If there are multiple recipients, separate their addresses with a comma (,).
Enter names (optional) and the email address, such as Name \<someone@fabrikam.com\>.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseSsl
The Secure Sockets Layer (SSL) protocol is used to establish a secure connection to the remote computer to send mail.
By default, SSL is not used.

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

### -Port
Specifies an alternate port on the SMTP server.
The default value is 25, which is the default SMTP port.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### IssueFix
## OUTPUTS

### IssueFix The fix object(s) that were send out via mailmessage, with nofiticatonCount updated (if not IgnoreNotificationCount)
## NOTES

## RELATED LINKS
