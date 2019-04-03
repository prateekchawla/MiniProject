$RESOURCE_NAME="AzureResourceGroup"

echo "Now Cleaning up Resources"

az group delete --name $RESOURCE_NAME --yes

echo "Resources Deleted"
