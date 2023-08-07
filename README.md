# LinuxPackTrans
(A somewhat similar to apt-clone)
Here are two simple Shell scripts designed for Debian-based Linux distributions. These scripts automate the process of installing all the packages you have installed on one Debian-based system onto another. 
Let's say you have a 'System A' and you want to replicate all the installed packages onto another system named 'System B'.

Script1 called package_finder[dot]sh. 
Start by running 'package_finder.sh' on System A. This script will search the system and generate a file called 'packages.list', containing the names of all installed packages on System A.
        Make the script executable with: $ sudo chmod +x package_finder.sh
        Run the script with: $ sudo bash package_finder.sh

Script2 called package_installer[dot]sh. 
Transfer the 'packages.list' file to System B. Ensure you have internet access.
    Navigate to the directory where 'packages.list' is located.
    Run 'package_installer.sh' on System B to install the packages listed in 'packages.list'.
        Make the script executable with: $ sudo chmod +x package_installer.sh
        Execute the script with: $ sudo bash package_installer.sh

By following these steps, you can effortlessly replicate the package installations from System A to System B."
