param(
    [Parameter(Mandatory=$true)] $JSONFile, 
    [switch]$Undo
)

function createADGroup() {
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
}

function deleteADGroup() {
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    Remove-ADGroup -Confirm:$false -Identity $name
}

function CreateADUser() {
    param([Parameter(Mandatory=$true)] $userObject)

    # Pull name from JSON object
    $name = $userObject.name
    $firstname, $lastname = $name.Split(" ")
    $password = $userObject.password
    # Generate a first inital lanst name username
    $username = ($firstname[0] + $lastname).ToLower()
    $samAccountName = $username
    $principalname = $username

    # Create the AD user
    New-ADUser -Name "$name" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount

    # Add user to appropriate groups
    foreach ($group_name in $userObject.groups) {

        try {
            Get-ADGroup -Identity "$group_name"
            Add-ADGroupMember -Identity $group_name -Members $username
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] {
            Write-Warning "AD object $group_name not found"
        }
    }
}

function deleteADUser() {
    param([Parameter(Mandatory=$true)] $userObject)

    $name = $userObject.name
    $firstname, $lastname = $name.Split(" ")
    $username = ($firstname[0] + $lastname).ToLower()
    Remove-ADUser -Identity $username -Confirm:$False
}

function killPasswordPolicy() {
    secedit /export /cfg C:\Windows\Tasks\secpol.cfg
    (Get-Content C:\Windows\Tasks\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0").replace("MinimumPasswordLength = 7", "MinimumPasswordLength = 1") | Out-File C:\Windows\Tasks\secpol.cfg
    secedit /configure /db C:\Windows\security\local.sdb /cfg C:\Windows\Tasks\secpol.cfg /areas SECURITYPOLICY
    Remove-Item -force C:\Windows\Tasks\secpol.cfg -confirm:$false
}
function reversePasswordPolicy() {
    secedit /export /cfg C:\Windows\Tasks\secpol.cfg
    (Get-Content C:\Windows\Tasks\secpol.cfg).replace("PasswordComplexity = 0", "PasswordComplexity = 1").replace("MinimumPasswordLength = 1", "MinimumPasswordLength = 7") | Out-File C:\Windows\Tasks\secpol.cfg
    secedit /configure /db C:\Windows\security\local.sdb /cfg C:\Windows\Tasks\secpol.cfg /areas SECURITYPOLICY
    Remove-Item -force C:\Windows\Tasks\secpol.cfg -confirm:$false
}

$json = ( Get-Content $JSONFile | ConvertFrom-Json)
$Global:Domain = $json.domain

if (-not $Undo) {
    killPasswordPolicy
    foreach ($group in $json.groups) {
        CreateADGroup $group
    }
    
    foreach ( $user in $json.users ) {
        CreateADUser $user
    }
}
else {
    reversePasswordPolicy

    foreach($user in $json.users) {
        deleteADUser $user
    }
    
    foreach($group in $json.groups) {
        deleteADGroup $group
    }
}
