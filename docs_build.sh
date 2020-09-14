#!/bin/bash
cd "${0%/*}" # cd to the folder with script
antora #Verify Antora is installed
RESULT=($?)
if [ $RESULT -eq 127 ]; then #if Antora is not found in $PATH (probably not installed) 
    echo -e '>> \e[31mFAIL\e[0m Antora not found in \$PATH, Install Antora from https://docs.antora.org/antora/2.2/install/install-antora/'
    exit 1
elif [ -f local-site.yml ]; then
    rm -rf build/ docs/ #remove the existing docs. Just in case there are docs that should not be there. 
    echo -e '>> \e[34mINFO\e[0m Building docs with Antora'
    antora --fetch local-site.yml # build documentation with antora
    echo -e '>> \e[34mINFO\e[0m Copying generated docs to the root folder.'
    cp -rfv build/site/* .
    echo -e '>> \e[92mDONE\e[0m Review the generated documentation in index.html, commit the changes and submit a pull request to Lookyloo docs.'
else
    echo -e '>> \e[31mFAIL\e[0m local-site.yml not found in the path of the docs_build.sh. Terminating.'
    exit 1
fi
exit 0
