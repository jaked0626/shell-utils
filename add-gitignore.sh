#!/bin/bash


# get path to directory to seed with .gitignore file 
directory=${1:-./}

# to use this script, you should have a directory somewhere storing many different types of gitignore files (can find on github) 
# get path to such directory
gitignore_path=${2:-~/gitignore}

# identify the programming languages used within the directory
languages=$(find $directory -type f -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.py' -o -name '*.js' -o -name '*.jl' -o -name '*.rs' -o -name '*.go'  -o -name '*.r' -o -name '*.tex' -o -name '*.tf' -o -name '*.rb' -o -name '*.kt' -o -name '*.dart'| sed 's/.*\.//' | sort | uniq)

# map suffix to formal language names
for lang in $languages
do
  case $lang in
    c) formal_name="C";;
    cpp) formal_name="C++";;
    java) formal_name="Java";;
    py) formal_name="Python";;
    js) formal_name="Node";;
    html) formal_name="HTML";;
    css) formal_name="CSS";;
    jl) formal_name="Julia";;
    rs) formal_name="Rust";;
    go) formal_name="Go";;
    r) formal_name="R";;
    tex) formal_name="TeX";;
    tf) formal_name="Terraform";;
    rb) fromal_name="Ruby";;
    kt) formal_name="Kotlin";;
    dart) formal_name="Dart";;
    *) formal_name="Unknown";;
  esac
  language_names+=("$formal_name")
done

# echo the languages used
echo "The following languages were detected in the directory $directory:"
echo "$language_names"

# create a .gitignore if one doesn't already exist
if [ ! -f "$directory/.gitignore" ]
then
  touch "$directory/.gitignore"
fi

# concatenate contents of gitignore files
for lang in $language_names
do
  lang_gitignore_path="${gitignore_path}/${lang}.gitignore" 
  echo "checking if ${lang_gitignore_path} exists"
  if [ -f $lang_gitignore_path ]
  then
    echo "file found!"
    echo "### git ignore for ${lang}" >> "$directory/.gitignore \n"
    cat "$lang_gitignore_path" >> "$directory/.gitignore"
  fi
done

echo "The .gitignore file in $directory has been updated with relevant rules."

