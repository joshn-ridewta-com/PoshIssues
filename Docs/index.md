# PoshIssues
TODO: Introduction goes here

# Fix
A fix is a ScriptBlock to make the change recomended by the fix.  It supports a number of features to allow for reviewing and documenting the fixes.

The IssueFix object contains:
+ iD (GUID) calculated feom a hash of fixCommand
+ sequenceNumber (Long Int)
+ checkName (String)
+ fixCommand (ScriptBlock)
+ fixDescription (String)
+ status (Int) Ready | Pending | Complete | Error | Canceled
+ fixResults (String)
+ notificationCount (Int)
+ databasePath (string) Add/updated by Read/Write-IssueCheck if saved to a database folder.
+ path (string) Add/updated by Read/Write-IssueCheck if saved as a standalone file.
+ creationDateTime (DateTime) Date and time when the fix object is created.
+ statusDateTime (DateTime) Date and time when status was updated.
+ priority (Int) Low | Medium | High
+ scheduledAfter (DateTime) Date and time after which Invoke-IssueFix will invoke the fix

# Sequence Number
IssueFixs have sequence numbers that are used for sorting fixes.

# Notification Count
Each time a notificaton is sent for a fix the notificationCount is decremented by one. By default, only fixes with a notification count greater then 0 are sent. This allows for control over how often a fix is notified about.  If the IssueCheck/IssueFix creator does not want any notifications sent (by default), set to 0.  If only want to be notified once, set to 1.  The notification cmdlets provide control over when this value is used.  For example, parameters allow only using the notification count for "Pending" fixes and instead setting "Completed/Error" fixes to 0 after first notification.  Or the notification cmdlet can send for all fixes and ignore this value.

# cmdlets
+ [New-IssueFix](New-IssueFix.md)
+ [Set-IssueFix](Set-IssueFix.md)
+ [Invoke-IssueFix](Invoke-IssueFix.md)
+ [Write-IssueFix](Write-IssueFix.md)
+ [Read-IssueFix](Read-IssueFix)
+ [Archive-IssueFix](Archive-IssueFix)
+ [Remove-IssueFix](Remove-IssueFix)
+ [Limit-IssueFix](Limit-IssueFix)
+ [Approve-IssueFix](Approve-IssueFix)
+ [Deny-IssueFix](Deny-IssueFix)
+ [Send-IssueMailMessage](Send-IssueMailMessage)

# Database (File System)
Read, Write, Archive and Remove cmdlets are all designed to work against JSON files.  When a DatabasePath is provided the data is stored in a folder with each object stored as a seperate JSON file.  This reduces write conflicts and simplifies data management tool.  The databasePath folder must exist.

It is important to Write any changed objects back to the database.  Thus any commands using the database should always end the pipeline with a Write, Archive or Remove cmdlet.

Each object when Read or after being writtened to the database will have a databasePath property added.  This property can be supplied by property value to future write cmdlets to easily re-save a changed object.
##Folder Structure
###Fixes
Where all of the non-archived fixes are stored.
###Fixes\Archive
Where archived fixes are stored.  To allow for duplicate fix IDs, the date/time of the archive action are appended to the file name.

#Pipeline
All cmdlets takes and return Fix objects.  

# Workflow
## On Demand
TODO: This needs ot be re-worked since I don't have IssueChecks.

User adds (New-IssueCheck) checks to the database in the form of ScriptBlocks.  A hashtable of parameters to be passed may also be saved.  Each issue check supports providing defaults foe the fix objects such as fixDescription, checkName, "Pending" or "Ready" status.

User calls Invoke-IssueCheck to run through all (or filtered) IssueChecks, executing each check.  Checks return 0 or more fix objects.  If the command returns Strings or ScriptBlocks these will be converted to Fix objects using New-IssueFix using the defaults saved with the IssueCheck.  Depending on invoke parameters, any fixes returned in the "Ready" state will be executed in sequenceNumber order.  They will also be returned as results .  Fixes are executed after each check, before the next check to allow check processes to build on each other.

Checks can be run multiple times but will only allow one fix to exist by comparing the iD which is a hash of fixCommand.  The Invoke-IssueCheck, by parameter, can run through the checks repeatedly until no new fixes are generated.  This allows checks to build upon each other and respond to fixes.  It also allows for single notification of issues.

After invoking, the user can review the results either by iterating the return or by querying the database with Read-IssueFix.

Fixes in the "Pending" state can be changed to "Ready" through either the Set-IssueFix or the Complete-IssueFix cmdlets.  If instead a fix should be skipped or canceled, use either Set-IssueFix changing status to "Canceled".

Re-running Invoke-IssueCheck will find any fixes in the ready state and execute those first.

When finished a notification of all fixes, either still pending or finished, can be sent with the Send-IssueFixMail cmdlet. Each time a notificaton is sent for a fix the notificationCount is decremented by one. By default, only fixes with a notification count greater then 0 are sent. This allows for control over how often a fix is notified about. Parameters for the cmdlet can be saved in the database using Set-IssueFixMail cmdlet.

If all done, fixes that are completed or errored can be removed using Remove-IssueFix, from the database, allowing those same fixes to be presented again.  For example, an issue can be raised, addressed and then removed so the user can be notified if it comes up again.

Better yet, comoleted fixes can be archived using Archive-IssueFix to maintain a record of fixes executed.

## Scheduled
Most issues processes will be scheduled.  In fact there coukd be different databases for different schedules.

The scheduled job will:
1) Invoke-IssueCheck using saved database
2) Send-IssueFixMail notifications
3) Archive-IssueFix fixes that have completed or errored, perhaps based on the notificationCount.

Users then recieve the the notification and can review both ezecuted fixes and "Pendong" fixes.  The user can use fix cmdlets to change the status of pending fixes which will then be processed at the next scheduled Invoke.

# Use Cases
Detect system irregularities or failures.  Check coukd be to ping one or more systems.  If a system doesn't respond a fix could be generated in the "Pending" state to just provide notice or maybe the fix is a command to restart something.  Notification count could be set high so users keep getting the notice.

Note, the module currently does not have a method for removing a fix that is resolved out of band.

Don't let the words "issue" or "fix" limit how this module can be used.

For example one of the first uses of this module was to keep Active Directory up to date with a HR system.  So the check compares all employee AD User object titles with those that are set in the HR database.  Fixes with a "Set-ADUser -Identity [distinguishedName] -Title [new title]" are generated for each descrepency.  These fixes are either executed imediately ("Ready") or await review ("Pending").  In either case IT is notified through email.
