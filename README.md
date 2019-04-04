# MiniProject

Provisions a Web App on Azure with the latest html application on git hub using Powershell script.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Azure Subscription

Git Hub Account 

Jenkins hosted on a machine 
•	Install required Plugins
•	Add credentials for git server
•	Add credentials for Azure Service Principal – Provide Contributor access inside IAM role

Git Bash(optional)


## Running the tests

No Automated tests written seperately. The powershell scripts inside Jenkins job itself checks for content and 200 OK status.

## Deployment

Open Jenkins at "http://10.140.10.85:8080/" 
go to the view "Projects"
Trigger the Job with Name - "MiniProject". Select Build Parameter "CleanUpResources" as "Yes" to clean up the resources at the end.
It will trigger the resources, deploy to the web app and clean up at the end.

## Built With

Visual Studio Code


