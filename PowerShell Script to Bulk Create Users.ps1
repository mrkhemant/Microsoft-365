
# Import Microsoft Graph module
Import-Module Microsoft.Graph.Users

# Connect to Graph
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All"

# Import user data from CSV
$users = Import-Csv -Path "C:\Users\Desktop\usercreationdetails.csv"  # Replace with your actual path

foreach ($user in $users) {
    # Create password profile object
    $passwordProfile = @{
        Password = $user.password
        ForceChangePasswordNextSignIn = $true
    }

    # Create user object
    $userParams = @{
        AccountEnabled   = $true
        DisplayName      = $user.displayName
        MailNickname     = $user.mailNickname
        UserPrincipalName= $user.userPrincipalName
        GivenName        = $user.givenName
        Surname          = $user.surname
        JobTitle         = $user.jobTitle
        Department       = $user.department
        OfficeLocation   = $user.officeLocation
        UsageLocation    = $user.usageLocation
        PasswordProfile  = $passwordProfile
    }

    # Call New-MgUser with splatted parameters
    New-MgUser @userParams

    Write-Host "Created: $($user.userPrincipalName)" -ForegroundColor Green
}
