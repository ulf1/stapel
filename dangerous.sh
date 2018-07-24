#DON'T EXECUTE THIS SCRIPT

#just in case
echo "Are you crazy? Stop It!"
exit

# FORK BOMB
# - The fork bomb starts a process that fork itself until all computer ressources are busy. 
# - No root access required.
:(){ :|: & };:

# DELETE FS
# - Delete the file system. 
# - Requires root access. 
# - The "rm" command mean remove files. 
# - The options "-rf" mean remove recursively, and force deletion. 
# - The path "/" is the root of the file system.
rm -rf /

# DELETE BOOT
# - Delete the kernel. removes the kernel, initrd, grub/lilo. 
# - Requires root access.
rm -rf /boot/

# DELETE INIT
# - Delete all init files to start services. 
# - Root access required
cd / ; find -iname init -exec rm -rf {} \;


