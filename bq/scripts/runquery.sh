#!/bin/bash

# Takes a template file and runs the query

queryFile=${1}

if [ ! -f $queryFile ]; then
    echo "Error: $queryFile does not exist."
    exit 1
fi

# Check if BIGQUERYRC is populated
if [ -s "$BIGQUERYRC" ]; then
    bqrc_path="$BIGQUERYRC"
else
    bqrc_path="$HOME/.bigqueryrc"
fi

query=$(<"$queryFile")

echo "Running following w/ bigqueryrc=$bqrc_path:
$query "

read -p "Do you want to proceed? (Y/n): " confirm
confirm=${confirm:-n}  # Default to Y if no input is provided

if [[ $confirm =~ ^[Yy]$ ]]; then
    echo "Proceeding with the execution."
    outputPath="./outputs/$(basename "$queryFile" .sql).csv"
    touch "$outputPath"
    echo "Saving output to $outputPath"
    bq query --apilog="./outputs/latestLog.log" --format=csv "$query" > $outputPath
else
    echo "Aborted."
    exit 0
fi
