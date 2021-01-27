param(
    [String] $Path = ".\docs"
)
Import-Module platyPS

#Import-Module .\PoshIssues -Force
# Update-MarkdownHelpModule -Path $Path -Force

New-ExternalHelp .\docs -OutputPath .\PoshIssues\en-US -Force