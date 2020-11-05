# PoshIssues
PowerShell module to check, track and fix issues.

# Fix
A fix is a ScriptBlock to make the change recomended by the fix.  It supports a number of features to allow for reviewing and documenting the fixes.

The IssueFix object contains:
+ iD (GUID) calculated from a hash of fixCommand
+ sequenceNumber (Long Int)
+ checkName (String)
+ fixCommand (ScriptBlock)
+ fixDescription (String)
+ status (Int) Ready | Pending | Complete | Error | Canceled | Hold | Scheduled
+ fixResults (String)
+ notificationCount (Int)
+ scheduledAfter (DateTime)
+ priority (Int) High | Medium | Low
+ databasePath (string) Add/updated by Read/Write-IssueCheck if saved to a database folder.
+ path (string) Add/updated by Read/Write-IssueCheck if saved as a standalone file.
+ creationDateTime (DateTime) Date and time when the fix object is created.
+ statusDateTime (DateTime) Date and time when status was updated.

# Sequence Number
The IssueFix has sequence numbers that are used for sorting fixes.  Invoke-IssueFix DOES NOT sort input fix objects, author SHOULD Sort-Objects on Sequence Number prior to passing to Invoke-IssueFix.

# Notification Count
Each time a notificaton is sent for a fix the notificationCount is decremented by one. By default, only fixes with a notification count greater then 0 are sent. This allows for control over how often a fix is notified about.  If the IssueFix creator does not want any notifications sent (by default), set to 0.  If only want to be notified once, set to 1.  The notification cmdlets provide control over when this value is used.  For example, parameters allow only using the notification count for "Pending" fixes and instead setting "Completed/Error" fixes to 0 after first notification.  Or the notification cmdlet can send for all fixes and ignore this value completely.

# cmdlets
## Fixes
Review, cancel or complete, remove issue fixes.  Fixes in a pending state can be canceled or completed.  Fixes can come from results or be loaded from files or the database.  Fixes that are automatically executed ("Completed" or "Error" states) can not be canceled or completed, only those in a "Pending" state.  New-IssueFix creates a fix object for return and use in checks script blocks or for direclty.  All cmdlets passthru any fix objects on the pipeline.
### New-IssueFix
Returns a PSObject<PoshIssues.Fix> object.
### Write-IssueFix
Saves a PSObject<PoshIssues.Fix> object to a file or in a database folder.  Use PassThru switch with NoClobber to get all Fixes passed thru, otherwise only Fixes written are passed thru.
### Remove-IssueFix
Removes a PSObject<PoshIssues.Fix> object file from a database folder.
### Read-IssueFix
Imports a PSObject<PoshIssues.Fix> object from a database folder.
### Set-IssueFix
Changes properties of a PSObject<PoshIssues.Fix> object.
### Approve-IssueFix
Changes status property of a PSObject<PoshIssues.Fix> object to "Ready".  Used as a verb to change from Pending or Canceled to Ready.
### Deny-IssueFix
Changes status property of a PSObject<PoshIssues.Fix> object to "Cancel".
### Archive-IssueFix
Moves a saved IssueFix file into the Archive folder of the database and updates filename to include the execution date.
### Invoke-IssueFix
Invokes the fix PowerShell ScriptBlock associated with the fix, storing the results and updating the status.  Unless forced, will only process those that have a Ready status.
### Limit-IssueFix
Limits fixes to one per fix by sorting through the piped input removing duplicate Fixes, keeping the oldest.  Used to prevent the same fix from being fired multiple times.

## Notes on Invoking Issues
The invoke occurs within a new child scope within a module and thus has the same limites as new scopes within modules.  Of note variables such as $_, $this, and $input are not available.

This includes the incrediably useful $PSDefaultParameterValue variable.  To compensate the Invoke-IssueFix cmdlet has an optional parameter, DefaultParameterValues.  This can take a custom hash table or the existing $PSDefaultParameterValues as parameter value and adds it as $PSDefaultParameterValues to the invoke scope.  Always want your DefaultParameterValues to contain $PSDefaultParameterValues?  Add the following to your $PSDefaultParameterValues:
`
$PSDefaultParameterValues["Invoke-IssueFix:DefaultParameterValues"] = {$PSDefaultParameterValues}
`

## Notification
Support sending notification of fixes.  Starting off with email but could add other channels.
### Send-IssueMailMessage
Sends and email for each applicable IssurFix.  Updating notifocationCount by default.  Choose which types of fixes to include in the notification.

# Database
The data will be stored in a folder with each object stored as a seperate JSON file.  This should reduce write conflicts and simplify data management tools.  The databasePath folder must exist.

It will be important to Write any changed objects back to the database.  Thus any commands using the database should always end the pipeline with a Write-IssueFix cmdlet.

Each object when Read or after being writtened to the database will have a databasePath property added.  This property can be supplied by property value to future write cmdlets to easily re-save a changed object.
##Folders
Each Write cmdlet will save to a different folder, creating the folders as needed.
###Fixes
###Fixes\Archive

#Pipeline
All cmdlets take and/or return Fix objects.  They behave similar to the PassThru concept.

# Workflow
## On Demand
Script(s) run performing "checks" and generating 0 or more fixes (via New-IssueFix).  These are typically written to a database (Write-IssueFix -NoClobber).

```
If ($NeedsFixing) {
     New-IssueFix -fixCommand {echo 'Fixed'} -fixDescription 'Fixed it's -checkName 'Sample Check' -status Pending | Write-IssueFix -DatabasePath 'c:\issuesdb' -NoClobber # The NoClobber parameter does not overwrite fixes with the same command, this allows a check to be ran over and over again and not effect the first instance with it's status, etc.
}
```
After invoking, the user can review the results either by iterating the return or by querying the database with Read-IssueFix.

```
Read-IssueFix -DatabasePath 'c:\issuesdb'
```

Fixes in the "Pending" state can be changed to "Ready" through either the Set-IssueFix or the Complete-IssueFix cmdlets.  If instead a fix should be skipped or canceled, use either Set-IssueFix changing status to "Canceled" or Deny-IssueFix.  They can also be moved to the Hold status which is like a special Pending.  Typically Hold status are not included in notifications.

In order to execute the fixes, read the fixes and invoke them.  It is recommended that this be done at the beginning of the check script and again at the end.
```
Read-IssueFix -isReady -DatabasePath 'c:\issuesdb' | Invoke-IssueFix | Write-IssueFix -DatabasePath 'c:\issuesdb'
# Note, invoke will only process those in Ready status so the isPending parameter is not required on the read cmdlet BUT it improves performance :-)
```

When finished a notification of all fixes, either still pending or finished, can be sent with the Send-IssueFixMail cmdlet. Each time a notificaton is sent for a fix the notificationCount is decremented by one. By default, only fixes with a notification count greater then 0 are sent. This allows for control over how often a fix is notified about. Parameters for the cmdlet can be saved in the database using Set-IssueFixMail cmdlet.

If all done, fixes that are completed or errored can be removed using Remove-IssueFix, from the database, allowing those same fixes to be presented again.  For example, an issue can be raised, addressed and then removed so the user can be notified if it comes up again.

Better yet, comoleted fixes can be archived using Archive-IssueFix to maintain a record of fixes executed.

## Scheduled
Most issues processes will be scheduled.  In fact there coukd be different databases for different schedules.

The scheduled job will:
1) Run scripted checks and output fix objects to database
2) Send-IssueFixMail notifications
3) Archive-IssueFix fixes that have completed or errored, perhaps based on the notificationCount.

Users then recieve the the notification and can review both ezecuted fixes and "Pendong" fixes.  The user can use fix cmdlets to change the status of pending fixes which will then be processed at the next scheduled Invoke.

### Scheduled Status
Do not confuse the concept of scheduling invokes with the Scheduled status.  The Scheduled status behaves similar to Ready status except the Invoke-IssueFix cmdlet also checks the scheduledAfter fix attribute and verifies it is in the past before invoking.

# Use Cases
Detect system irregularities or failures.  Check coukd be to ping one or more systems.  If a system doesn't respond a fix could be generated in the "Pending" state to just provide notice or maybe the fix is a command to restart something.  Notification count could be set high so users keep getting the notice.

Note, the module currently does not have a method for removing a fix that is resolved out of band.

Don't let the words "issue" or "fix" limit how this module can be used.

For example one of the first uses of this module was to keep Active Directory up to date with a HR system.  So the check compares all employee AD User object titles with those that are set in the HR database.  Fixes with a "Set-ADUser -Identity [distinguishedName] -Title [new title]" are generated for each descrepency.  These fixes are either executed imediately ("Ready") or await review ("Pending").  In either case IT is notified through email.
