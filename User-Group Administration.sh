#!/bin/bash
while true; do
        echo "Hi, You Are Welcome, Choose What You Want to Do"
        PS3="Please Make Your Choise => " ; export PS3
        select option in "Create User" "Modify User" "Delete User" "Create Group" "Modify Group" "Delete Group" "Quit"
        do
                case $option in
                        "Create User")
                                echo "Please Entre the User Name: "
                                read username
                                if id "$username" >/dev/null 2>&1; then
                                echo "User Exists, Try Again Another One: "
                                else
                                echo "Creating User......"
                                useradd $username
                                echo "User "$username" Added Successfully and Exists in the passwd File as: "
                                cat /etc/passwd | grep -i $username
                                echo "The Uid, Gid and Groups of The New User is: "
                                id $username
                                fi
                                break
                                ;;
                        "Modify User")
                                while true; do
                                        echo "Choose What u Want to Modify Please.."
                                        select option in "Rename" "Home Dir" "Shell" "Add Secondary Group" "Primary Group" "Main Menu"
                                        do
                                                case $option in
                                                     	"Rename")
                                                        echo "Entre the Username u Want to Rename: "
                                                        read username
                                                        if id "$username" >/dev/null 2>&1; then
                                                        echo "Entre the New Name: "
                                                        read newName
                                                        echo "Info of the User Before Changing: "
                                                        id $username
                                                        echo "Changing the Name....."			    
                                                        usermod -l $newName $username
                                                        echo "Name Changed Successfuly."
                                                        echo "Info of the User After Changing the Name: "
                                                        id $newName
                                                        else
                                                        echo "The User is not Exist, Try Again"
                                                        fi
                                                        break					    
                                                        ;;		
                                                        "Home Dir") 
                                                        echo "Entre the Username u Want to Modify: "
                                                        read username
                                                        if id "$username" >/dev/null 2>&1; then
                                                        echo "User Info from the passwd File Before Editing: "
                                                        cat /etc/passwd | grep -i $username
                                                        echo "Entre the Path of the New Home Dir u Want: "
                                                        read homedir
                                                        echo "Editing the Home Dir....."
                                                        usermod -d $homedir $username
                                                        echo "Done Successfully as u See the User Info from the passwd File: "
                                                        cat /etc/passwd | grep -i $username
                                                        else
                                                        echo "The User is not Exist, Try Again"
                                                        fi
                                                        break
                                                        ;;
                                                        "Shell")
                                                        echo "Entre the Username u Want to Modify: "
                                                        read username
                                                        if id "$username" >/dev/null 2>&1; then
                                                        echo "User Info from the passwd File Before Editing: "
                                                        cat /etc/passwd | grep -i $username
                                                        echo "Entre the Path of the New Shell u Want: "
                                                        read shell
                                                        echo "Editing the User Shell....."
                                                        usermod -s $shell $username
                                                        echo "Shell Updated Successfully as u See the User Info from the passwd File: "
                                                        cat /etc/passwd | grep -i $username
                                                        else
                                                        echo "The User is not Exist, Try Again"
                                                        fi
                                                        break
                                                        ;;
                                                        "Add Secondary Group")
                                                        echo "Entre the Username u Want to Modify: "
                                                        read username
                                                        if id "$username" >/dev/null 2>&1; then
                                                        echo "The User Info Before Editing: "
                                                        id $username    
                                                        echo "Entre the Name of the Secondary Group u Want to Add: "
                                                        read groupName
                                                        if grep -q "^$groupName:" /etc/group; then
                                                        echo "Adding the User to the Secondary Group....."
                                                        usermod -aG $groupName $username
                                                        echo "User Groups Updated Successfully as u See from User info: "
                                                        id $username
                                                        else
                                                        echo "Group '$groupName' Does not Exist, Try Again"
                                                        fi
                                                        else
                                                        echo "The User is not Exist, Try Again"
                                                        fi
                                                        break
                                                        ;;
                                                        "Primary Group")
                                                        echo "Entre the Username u Want to Modify: "
                                                        read username
                                                        if id "$username" >/dev/null 2>&1; then
                                                        echo "The User Info Before Editing: "
                                                        id $username
                                                        echo "Entre the Name of the Primary Group u Want to Add: "
                                                        read groupName
                                                        if grep -q "^$groupName:" /etc/group; then
                                                        echo "Adding the User to the Primary Group....."
                                                        usermod -g $groupName $username
                                                        echo "User Primary Group Updated Successfully as u See from User info: "
                                                        id $username
                                                        else
                                                        echo "Group '$groupName' Does not Exist, Try Again"
                                                        fi
                                                        else
                                                        echo "The User is not Exist, Try Again"
                                                        fi
                                                        break
                                                        ;;			
                                                        "Main Menu")
                                                        echo "Returning to the Main Menu....."	
                                                        break 2
                                                        ;;
                                                        *)
                                                        echo "Error: Invalid Input."
                                                        break
                                                        ;;
                                                esac
                                        done
                                done
				break
                                ;;
                        "Delete User")
                                echo "Be Carefull when u Deleting Something....."
                                echo "Entre the UserName u Want to Delete: "
                                read username
                                if id "$username" >/dev/null 2>&1; then
                                echo "Deleting User "$username"....."
                                userdel $username
                                echo "User "$username" Deleted Successfuly."
                                else
                                echo "The User "$username" is not Exist, Try Again"
                                fi
                                break
                                ;;
                        "Create Group")
                                echo "Entre the Group Name u Want to Add: "
                                read groupName
                                if grep -q "^$groupName:" /etc/group; then
                                echo "Group "$groupName" Alreay Exisiting, Try Again Another One"
                                else
                                echo "Creating Group "$groupName"..... "
                                groupadd $groupName
                                echo "Group "$groupName" Has Been Added Successfuly."
                                cat /etc/group | grep -i $groupName
                                fi
                                break
                                ;;
                        "Modify Group")
                                while true; do
                                        echo "Choose What u Want to Modify Please.."
                                        select option in "Rename" "Group id" "Main Menu"
                                        do
                                                case $option in
                                                        "Rename")
                                                        echo "Entre the Group u Want to Rename: "
                                                        read groupName
                                                        if grep -q "^$groupName:" /etc/group; then
                                                        echo "Entre the New Name: "
                                                        read newName
                                                        echo "Changing the Name of the Group....."			    
                                                        groupmod -n $newName $groupName
                                                        echo "Name Changed Successfuly and u Can Check from the group File in etc Dir: "
                                                        cat /etc/group | grep -i $newName
                                                        else
                                                        echo "The Group "$groupName" is not Exist, Try Again"
                                                        fi
                                                        break					    
                                                        ;;		
                                                        "Group id") 
                                                        echo "Entre the Group u Want to Change it's id: "
                                                        read groupName
                                                        if grep -q "^$groupName:" /etc/group; then
                                                        echo "The info of the Group Before Changing the id: "
                                                        cat /etc/group | grep -i $groupName		    
                                                        echo "Insert the New id: "
                                                        read newid
                                                        echo "Changing the id of the Group "$groupName"....."
                                                        groupmod -g $newid $groupName
                                                        echo "The id Changed Successfuly and The Info of the Group After Changing is: "
                                                        cat /etc/group | grep -i $groupName
                                                        else
                                                        echo "The Group "$groupName" is not Exist, Try Again"
                                                        fi
                                                        break
                                                        ;;			
                                                        "Main Menu")
                                                        echo "Returning to the Main Menu....."	
                                                        break 2
                                                        ;;
                                                        *)
                                                        echo "Error: Invalid Input."
                                                        break
                                                        ;;
                                                esac
                                        done
                                done
				break
                                ;;
                        "Delete Group")
                                echo "Be Carefull when u Deleting Something....."
                                echo "Entre the Group Name u Want to Delete: "
                                read groupName
                                if grep -q "^$groupName:" /etc/group; then
                                echo "Deleting Group....."
                                groupdel $groupName
                                echo "Group "$groupName" Deleted Successfuly."
                                else
                                echo "Group '$groupName' Does not Exist, Try Again"
                                fi
                                break
                                ;;
                        "Quit")
                                echo "Programm Exited, See u Soon :)"
                                exit 0
                                ;;        
                        *)
                                echo "Error: Invalid Input."
                                break
                                ;;
                esac
        done
done
