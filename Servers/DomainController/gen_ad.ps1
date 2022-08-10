param([Parameter(Mandatory=$true)] $JSONFile);

function createADGroup() {
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
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

$json = ( Get-Content $JSONFile | ConvertFrom-Json)

$Global:Domain = $json.domain

foreach ($group in $json.groups) {
    CreateADGroup $group
}

foreach ( $user in $json.users ) {
    CreateADUser $user
}
