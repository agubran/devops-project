Param(
    [parameter(Mandatory=$false)][string]$appName="",
    [parameter(Mandatory=$false)][bool]$clean=$true
    )

function Uninstall-Chart  {
    Param([string]$chart, [string]$initialOptions)
    $options=$initialOptions
    $command = "helm uninstall $chart ./$chart/ $options"
    Write-Host "Helm Command: $command" -ForegroundColor Gray
    Invoke-Expression $command
}


Write-Host "Begin uninstallation using Helm" -ForegroundColor Green

if ($clean) {    
    $listOfReleases=$(helm ls --filter $appName -q)    
    if ([string]::IsNullOrEmpty($listOfReleases)) {
        Write-Host "No previous releases found!" -ForegroundColor Green
	}else{
        Write-Host "Previous releases found" -ForegroundColor Green
        Write-Host "Cleaning previous helm releases..." -ForegroundColor Green
        helm uninstall $listOfReleases

        Write-Host "Previous releases deleted" -ForegroundColor Green
	}        
}

$charts =  ("mongodb", "api", "web")

foreach ($chart in $charts) {
    Write-Host "Uninstall: $chart" -ForegroundColor Green
    Uninstall-Chart $chart
}


Write-Host "helm charts Uninstall." -ForegroundColor Green