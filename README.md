# Augusta Group One Application & Development Environment

## Development Environment

### Vagrant configuration (Windows/Intel chip)

Vagrant is used for this project to create a local development environment, to configure how Vagrant works and to spin up virtual machines, it requires the use of a Vagrantfile, which is written in the Ruby coding language. Configuring the setup in the vagrant file allows the user to create a VM with their specified configuation (synced folders, shared folders, RAM allowance, CPU allocation etc)and to then bring up the VM with the "vagrant up" command. The configuration setup was done for two machines in this project, one that houses the database and one that houses the game. In order to get the database VM up and running we had to create a provisioning script that installed the specified programs and files on the VM on boot. The same setup was followed for the game VM. There are also inclusions of proxy configuration files which allow the use of running the database and game on the local network, which in turn gives the ability to have these to connect to each. Both machines are accessible via SSH. To access the game in a browser for Windows enter the ip address "192.168.56.10", this will load up the game and upon a successful run, you will also see the high score "database" on the webpage.
Vagrant is configured both for machines with Intel chips and Apple M1 chips. Default version is set for Intel chips. To change it to M1, the Vagrantfile has to be adjusted. Comment out the part that's listed as the "Intel Version" (Lines 1-29), and uncomment the config that's listed as the "M1 Version" (Lines 31-75). When the M1 version is succsefully run, SSH into 'snake' and run command `hostname -I` to get app's IP, copy it. After that, exit the machine and SSH into the 'mongodb' machine. Change the directory to /api and run `node server.js`. Use the IP you copied before to access the game from the browser.

---

## Jenkins configuration

### Brief overview

Jenkins was configured so that when changes are pushed to "development" branch, Jenkins will be triggered through
the Github WebHook, the tests will be ran and - if succesful - the new build will be merged into the main branch, if not succesful the changes will not be pushed.

### Github configuration

Access was given to the settings of the GitHub repository. From there a new webhook was added with the Jenkins
server ip adress and its port. A new public-private key was created in order to link the Repository to the Jenkins
server. The public key was added to the github.

### Jenkins Build configuration

A new Build was defined in the Jenkins server. The link of the repository was added to the new build and it was
restricted to run in NodeJS. For the source code management, a new credential was created and the private key previously created was used. The Build Triggers were configured so that the main trigger is Github hook trigger for GITScm polling on the specified branch: development.
On the build section a shell command is executed: moving into the app folder, installing NPM and then running the pre-defined tests.
Using Post-Build Actions, Git Publisher was added so that the build will only be pushed if it succeded (passing the tests) and then merged into the origin main branch.

---

## Contributors

- [Constantin](https://github.com/Constantin-Coica)
- [Huma](https://github.com/humashaikhc)
- [Oliver](https://github.com/ovt12)
- [Jay](https://github.com/JayBuckby)
- [Walter](https://github.com/waltervoynarovsky)
- Coach : [Charlie](https://github.com/Charlie-robin)
