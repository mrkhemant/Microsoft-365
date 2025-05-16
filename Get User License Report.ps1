$users = Get-MgUser -All
$report = foreach ($user in $users) {
    $licenses = (Get-MgUserLicenseDetail -UserId $user.Id).SkuPartNumber -join ", "
    [PSCustomObject]@{
        DisplayName = $user.DisplayName
        Email       = $user.UserPrincipalName
        Licenses    = $licenses
    }
}
$report | Export-Csv -Path "C:\Users\Desktop\UserLicenseReport.csv" -NoTypeInformation
