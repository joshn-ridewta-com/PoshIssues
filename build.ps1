param (
    [String] $Path = ".\PoshIssues", #Path to the module folder
    [String] $TestsPath = ".\Tests\", #Path to the Pester tests files
    [String] $DocsPath = ".\docs", #Path to the platyPS docs
    [String] $PublishRepo = "PSGallery"
)

Import-Module -Name $Path -Force
. .\Tests\localTestValues.ps1

# Run tests
Invoke-Pester -Script "$TestsPath*"

#TODO: verify tests past and then proceed, if not, stop here


# Build help files
Import-Module platyPS
New-ExternalHelp $DocsPath -OutputPath "$Path\en-US" -Force

# Publish to PSGallery
Import-Module PowerShellGet
Publish-Module -Path $Path -Repository $PublishRepo -Verbose

<#

{
    "version": "0.1.0",
    "command": "powershell",
    "args": [   
        "-ExecutionPolicy",
        "Unrestricted",
        "-NoProfile",
        "-File",
        "${cwd}/build.ps1"       
    ],
    "taskSelector": "-task ",
    "showOutput": "always",
    "tasks": [
        {
            "taskName": "build",
            "showOutput": "always",
            "isBuildCommand": true
        }
    ]
}

#>