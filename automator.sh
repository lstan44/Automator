#! /bin/bash
# Linux Programming CS 265 Final Project
# Stanley Lalanne
# CUNY - Medgar Evers College
clear
echo "Enter the path of the directory that you want to work with:"
read d_path
echo "============================================================"
echo "Ok, those are the files that you have in that directory:"
echo

ls -a $d_path
menu=("\t\t=============================================================\n"
"\t\tWhat do you want to do with them? Choose an item below:\n"
"\t\tenter cd to change working directory\n"
"\t\tEnter ls to see the content of your working directory at any time\n"
"\t\tEnter 1 to group all pdfs in a pdf folder\n"
"\t\tEnter 2 to group all sh files in an sh folder\n"
"\t\tEnter 3 to group all pictures in a picture folder\n"
"\t\tEnter 4 to specify the extension of the files that you want to group together\n"
"\t\tEnter 5 to compress a folder\n"
"\t\tEnter 6 to decompress a folder\n"
"\t\tEnter 7 to merge multiple pdfs into one pdf\n"
"\t\tEnter m to show this menu again\n"
"\t\tEnter exit to exit program\n"
)

echo -e ${menu[*]}

while [ true ];
do

read user_in
if [ $user_in == "m" ];
then
  echo -e ${menu[*]}
fi
if [ $user_in == "cd" ];
then
  echo "enter a new directory:"
  read newdir
  d_path=$newdir
  echo "Now working in $d_path"
fi
if [ $user_in == "ls" ];
then
  ls -a $d_path
fi
if [ $user_in == "exit" ];
then
  echo "Exiting program now.. Goodbye!!"
  exit -1
fi
if [ $user_in == "1" ];
then
  echo "These are your pdf files:"
  ls -a | grep "$d_path/*.pdf"$

  echo "Enter the name of the folder in which you want to put them:"
  read f_name

  mkdir "$d_path/$f_name"

  pdfs=$d_path"/*.pdf"
  f_path=$d_path"/"$f_name

  mv $pdfs $f_path
  echo " All pdfs have been moved to $d_path/$f_name."
fi


if [ $user_in == "2" ];
then
  echo "These are your shell files:"
  ls -a | grep "$d_path/*.sh"$

  echo "Enter the name of the folder in which you want to put them:"
  read f_name

  mkdir "$d_path/$f_name"

  sh_f=$d_path"/*.sh"
  f_path=$d_path"/"$f_name

  mv $sh_f $f_path
  echo " All shell files have been moved to $d_path/$f_name."
fi


if [ $user_in == "3" ];
then
  echo "These are your pictures:"
  ls -a "$d_path"| grep -e ".png" -e ".jpg"

  echo "Enter the name of the folder in which you want to put them:"
  read picturefolder

  mkdir "$d_path/$picturefolder"

  png=$d_path"/*.png"
  jpg=$d_path"/*.jpg"
  picture_folder_path=$d_path"/"$picturefolder

  mv $png $jpg $picture_folder_path
  echo " All pictures have been moved to $picture_folder_path."

fi



if [ $user_in == "4" ];
then
  read -p "Enter the extension of files which you want to group in this format: .extension_name" extension_name

  echo "These are the $extension_name files that you have:"
  ls -a "$d_path"| grep -e "$extension_name"$

  echo "enter the name of the folder where you want to put them:"

  read ext_folder_name

  mkdir "$d_path/$ext_folder_name"

  ext_files=$d_path"/*$extension_name"
  ext_files_path=$d_path"/"$ext_folder_name

  mv $ext_files $ext_files_path
  echo " All $extension_name have been moved to $ext_files_path."
fi

if [ $user_in == "5" ];
then
  echo "enter the name of the file or folder which you want to compress"
  read f_to_compress
  tar -czvf $f_to_compress".tar.gz" $d_path"/"$f_to_compress

  echo "$f_to_compress has been compressed to $f_to_compress.tar.gz ."

fi

if [ $user_in == "7" ];
then
  echo "How many pdfs do you want to group together?"

  read num_pdfs
  declare -a pdfs[$num_pdfs]
  for (( c=0; c<$num_pdfs; c++ ))
  do
      read -p "Enter name of pdf $c : " pdfs[$c]
  done

  read -p "enter a name for the merged pdf" mergedpdf

  for (( c=0; c<$num_pdfs; c++ ))
  do
      echo "merging ${pdfs[$c]}"
      gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile=$d_path"/$mergedpdf" ${pdfs[*]}
  done

echo " ${pdfs[*]} has been grouped under a single pdf called $mergedpdf ."
fi
done
