
$RepoPath = "https://github.com/prateekchawla/SecondGit"

$appID="717152e6-feef-4c22-904e-bad03901940d"
$password="/DJv.^g!_#Q|)II_[};-1$W/#-$>?r$dI/*&}*6"
$tenant="a26a5ff8-8542-4fff-b6de-bee30a6b56b7"
$RESOURCE_NAME="AzureResourceGroup"
$PLAN_NAME="AzurePlan"
$WEBAPP_NAME="MyFirstAzureWebsiteAdmiral"

az login --service-principal -u $appID --password $password --tenant $tenant
az group create --location westeurope --name $RESOURCE_NAME
az appservice plan create --name $PLAN_NAME --resource-group $RESOURCE_NAME --sku FREE
az webapp create --name $WEBAPP_NAME --resource-group $RESOURCE_NAME --plan $PLAN_NAME


az webapp deployment source config --name $WEBAPP_NAME --resource-group $RESOURCE_NAME --repo-url $RepoPath --branch master --manual-integration

echo http://$WEBAPP_NAME.azurewebsites.net
