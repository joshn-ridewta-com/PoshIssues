param(
    [String] $Path = ".\docs"
)
Import-Module platyPS
Update-MarkdownHelpModule -Path $Path -Force
New-ExternalHelp .\docs -OutputPath .\PoshIssues\en-US -Force