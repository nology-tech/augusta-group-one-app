# Jenkins configuration

## Brief overview

Jenkins was configured so that when changes are pushed to "development" branch, Jenkins will be triggered through 
the Github WebHook, the tests will be ran and - if succesful - the new build will be merged into the main branch, if not succesful the changes will not be pushed.

## Github configuration

Access was given to the settings of the GitHub repository. From there a new webhook was added with the Jenkins
server ip adress and its port. A new public-private key was created in order to link the Repository to the Jenkins
server. The public key was added to the github.

## Jenkins Build configuration

A new Build was defined in the Jenkins server. The link of the repository was added to the new build and it was 
restricted to run in NodeJS. For the source code management, a new credential was created and the private key previously created was used. The Build Triggers were configured so that the main trigger is Github hook trigger for GITScm polling on the specified branch: development.
On the build section a shell command is executed: moving into the app folder, installing NPM and then running the pre-defined tests. 
Using Post-Build Actions, Git Publisher was added so that the build will only be pushed if it succeded (passing the tests) and then merged into the origin main branch.