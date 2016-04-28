#**RhoInstaller Build**#
###Prerequisite gems building###

####**1.rhodes gem**
 - For **```rhodes```** gem creation, we need to build **```rhosimulator```** first. Follow [Windows RhoSimulator Build Guidelines ](https://github.com/rhomobile/rhodes/blob/master/doc/oss/RhoSimulator_Installation_And_Build_Guidelines_For_Windows_Desktop.md) & [Mac RhoSimulator Build Guidelines](https://github.com/rhomobile/rhodes/blob/master/doc/oss/RhoSimulator_Installation_And_Build_Guidelines_For_Mac_Machine.md) for building **```rhosimulator```**.
 - Clone ```rhodes``` repository
 - Open version file and update the required rhodes version to be build
 - Open cmd and navigate to rhodes repository
 - Run command ```rake gem```
 - This will generate **```rhodes```** gem in the rhodes repository
 
####**2.rhoconnect-client gem**
 - Clone ```rhoConnect-client``` repository(if not cloned) 
 - Navigate to  RhoConnect-Client and rename **'config.yml.sample'** to **'config.yml'** 
 - Ensure that, the path for rhodes and rhoconnect is correctly set in **'config.yml'** 
 - Modified the version file with version number.
 - Install the below gems if not installed
    - **```gem install listen --version 3.0.6```**  
    - **```gem install rest-client```** 
 - Open cmd and navigate to rhoconnect-client repository
 - Run  **```rake gem:make_gem --trace```** command
 - This will generate **```rhoconnect-client```** gem in the RhoConnect-Client repository

####**3.rhoconnect**
 NOTE:- Linux or Mac Machine is requied for building this gem
 - Clone ```rhoconnect``` repository(if not cloned) 
 - Run **'gem install bundler'**
 - Run **'bundle install'**
 - Open cmd and navigate to rhoconnect repository
 - Run **```rake build```**
 - This will generate **```rhoconnect```** gem in the rhoconnect repository

####**4.rhoconnect-push**
 NOTE:- Linux or Mac Machine is requied for building this gem
 - Clone ```rhoconnect-push``` repository
 - Open cmd and navigate to rhoconnect-push repository
 - Run **```make clean```**
 - Run **```make all```**
 - This will generate **rhoconnect-push-x.y.z.tgz** in the rhoconnect-push repository
 
####**5.rhoconnect-adaptor**
 - Get ```rhoconnect-adaptor``` [here](https://rubygems.org/gems/rhoconnect-adapters) 
 
#### Note:- 
 In case of getting **Gem::Builder** error on mac, run below command.

	$ rvm install rubygems 1.8.24 --force
	
In case of getting **Gem::Builder** error on windows, run below command.

    gem update --system 1.8.24	

##**Step for rhoinstaller build on Windows**##
###Prerequisite downloads
- Download Java Development Kit (JDK)1.7  32bit [here](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)
- Download Git source control manager 32-bit [here](https://git-scm.com/downloads)
- Download NSIS- Nullsoft Scriptable Install System [here](https://sourceforge.net/projects/nsis/)
- Download Eclipse 3.7.2 (Indigo SR2) for RCP and RAP Developers 32bit [here](http://www.eclipse.org/downloads/packages/eclipse-rcp-and-rap-developers/indigosr2)
- Download [Eclipse 3.7.2 delta pack](http://archive.eclipse.org/eclipse/downloads/drops/R-3.7.2-201202080800/download.php?dropFile=eclipse-3.7.2-delta-pack.zip)  
- Download [dltk-sdk-R-4.0-201206120903.zip](http://ftp.halifax.rwth-aachen.de/eclipse/technology/dltk/downloads/drops/R4.0/R-4.0-201206120903/dltk-sdk-R-4.0-201206120903.zip). Note:- Make Sure that downloaded file size is approximately 26MB.
- Download [ruby-1.9.3-p551-i386 7-zip Archieve](http://rubyinstaller.org/downloads/archives)
- Download [DevKit-tdm-32-4.5.2-20111229-1559-sfx.exe](http://rubyinstaller.org/downloads/)
- Download [make-3.81.exe](https://sourceforge.net/projects/gnuwin32/files/make/3.81/)
- Download [redis 2.4.0](https://github.com/dmajkic/redis/downloads)
- Download [node-v0.12.7-x64.msi](https://www.google.com.sg/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0ahUKEwiJ06607cfLAhUPGo4KHdWDA2EQFggaMAA&url=https%3A%2F%2Fnodejs.org%2Fdist%2Fv0.12.7%2Fx64%2Fnode-v0.12.7-x64.msi&usg=AFQjCNHLrLfg9EeCEucn2BAOcUa9RjTl_w&sig2=4MuRzgQAlyM1JvsrhqKZRg&bvm=bv.117218890,d.c2E&cad=rja)

###Configuration sequence(strictly Follow steps as following)
- Install JDK
- Install git
- Install NSIS
- Create a new Root directory which will contain all setups for build (e.g.-RhoInstaller_Build) and put all prerequisite downloaded file here.(***Note:*** Make sure that the below steps are done in the same ***Root Folder***.)
- Clone rhostudio
- Clone rhoinstaller
- Clone rhodes-system-api-samples
- Extract ruby-1.9.3-p551-i386 and rename it as "ruby" 
- Install devkit.exe in devkit folder explicitly providing the folder name "devkit" while installing it(Note:- its mandatory to install, not to extract)
- Extract eclipse 3.7.2 for rcp and rap developers
- Extract deltapack 3.7.2 here such that it overwrites the eclipse
- Create a folder called "files" and put all the gems that we have created by following above '**Prerequisite gems building'** instuctions.It will contains 
 - rhoconnect-x.y.z.gem
 - rhoconnect-adapters-x.y.z.gem
 - rhoconnect-client-x.y.z.v.gem
 - rhodes-x.y.z.v.gem
 - rhoconnect-push-x.y.z.tgz<br/>
Note:- x.y.z.v represents the latest gem's version built. 

####**Package directory Setup**
 1. Navigate to ***rhoinstaller -> package*** directory.
 2. Create a folder named ***"redis-2.4.0"*** .
 3. Now extract redis-2.4.0.zip in some other location.Navigate to 32bit and Copy all files and paste it outside (i.e. in extracted folder).Delete existing 32bit and 64bit folders. Now Copy all contents and paste it in folder created ***"redis-2.4.0"*** in package folder.
 4. Create a folder named ***make-3.81*** .
 5. Install make-3.81.exe .Choose Compact installation while installing it.
 6. Navigate to C:\Program Files (x86)\GnuWin32 .
 7. Copy all the folders except **uninstall**,**doc**,**info** and paste them to created folder ***make-3.81***
 8. Navigate to **package** directory and put **node-v0.12.7-x64.msi** and **git.exe**
 9. Navigate to **rhoconnect-push-service** folder present inside **package** folder.And follow to note.txt
 10. Navigate to **rhoconnect-push** folder present inside **package** folder and put **node-v0.12.7-x64.msi** and **rhoconnect-push-x.y.z.tgz** in that folder
 
- Open eclipse and create workspace in same Root directory
- Now install dltk to the eclipse using Help->Install New Software->Add->archive->attache dltk.zip file->Install
- Import rhostudio to workspace
- If error is as red exclamation in imported project ,select the JRE as 1.7 in properties->Java Build Path
- Close the eclipse
- Navigate to **rhoinstaller->script** ,open **rhomobilesuite.nsi** and replace all occurances of **Git-1.7.6-preview20110708.exe** with your downloaded git version that has been put inside **package folder**. 
- Open command promt. navigate to directory "rhoinstaller->Scripts"

####Now run following commands together

    set path <Full Qualified Path of Root Directory>\ruby\bin;C:\Windows\system32
    rake installer:symbol fullbuild_installer_version=0.2.9.16 --trace
   
**Note:** you can specify your version accordingly    
 
##**Step for rhoinstaller build on MAC OSX**##

###**Download required files**###

1. [Java Development Kit (JDK)1.7  64-bit ](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)

2. [Git source control manager](https://git-scm.com/downloads) 

3. [Eclipse 3.7.2 (Indigo SR2) for RCP and RAP Developers (64-bit)](http://mirror.tspu.ru/eclipse/technology/epp/downloads/release/indigo/SR2/eclipse-rcp-indigo-SR2-macosx-cocoa-x86_64.tar.gz)

4. [Eclipse 3.7.2 delta pack](http://archive.eclipse.org/eclipse/downloads/drops/R-3.7.2-201202080800/download.php?dropFile=eclipse-3.7.2-delta-pack.zip)

5. [DLTK SDK 4.0 for Eclipse](http://ftp.halifax.rwth-aachen.de/eclipse/technology/dltk/downloads/drops/R4.0/R-4.0-201206120903/dltk-sdk-R-4.0-201206120903.zip)

###**Install & Configure Software**###

1. Install JDK 1.7 (64-bit)

2. Install Git source control manager

3. Create empty directory where you will build installer. It will be referred to as <root> in this document.

4. Clone rhoinstaller, rhostudio and rhodes-system-api-samples repositories into <root> directory:

    ```
    $ cd <root>
    $ git clone http://github.com/rhomobile/rhoinstaller.git
    $ git clone http://github.com/rhomobile/rhostudio.git
    $ git clone http://github.com/rhomobile/rhodes-system-api-samples.git
    ```
5. Create ``` <root> ```\files directory and place rhodes, rhoconnect and rhoconnect-adapters gems there.

6. Place rhoconnect-push-<version>.tgz into ``` <root> ```\files.

7. Extract Eclipse and delta pack archives into ``` <root> ``` directory.
    
    ```
    cd <root>
    tar -xzf <download_dir>/eclipse-rcp-indigo-SR2-macosx-cocoa-x86_64.tar.gz
    unzip -o <download_dir>/eclipse-3.7.2-delta-pack.zip
    ```
    
8. Configure Eclipse:
    Run Eclipse with command (always use absolute path as -data parameter):
    ``` <root> ```/eclipse/eclipse -data ``` <root> ```/workspace&
    

    - From menu select "Help"->"Install new software...".
    - Press "Add...".
    - Press "Archive...".
    - Point DLTK SDK archive.
    - Press "OK".
    - Mark "Dynamic Languages Toolkit (DLTK)" and press "Next >".
    - Press "Next >" again.
    - Accept license and press "Finish".
    - Wait for the DLTK installation to finish.
    - Restart Eclipse from "Software Updates" dialog.
    - From menu select "File"->"Import...".
    - In list of import sources select "General"->"Existing Projects into Workspace", then press "Next >".
    - Press "Browse...".
    - Select ``` <root> ```/rhostudio directory, press "Open".
    - Press "Finish".
    - Close Eclipse.
    
###**Build Installer**###

1. Edit ``` <root> ```\rhoinstaller\script\Rakefile file. You can tune following variables:
    ```
    $version           = '2.2.1.11'
    ```
2. Run build script:

    ```
    cd <root>/rhoinstaller/script
    rake installer:mac:make fullbuild_installer_version=0.2.9.16 --trace
    ```
3. New installer can be found as ``` <root> ```/RMS_*.dmg
