# Files
- `.bigqueryrc`: default flags and options for bigquery
- `README.md`: this file.
- `scripts`: folder holding utility scripts. Check each script for explanation.
- `templates`: sql template files holding query examples
- `outputs`: where your output csvs will be stored 
- `latestLog.log`: logs from your last query 

# Steps

1. from project root, run
```bash
$ bash ./scripts/setenv.sh
```

2. populate templates with your queries. 

3. from project root, run 
```bash
$ ./scripts/runquery.sh ./templates/[templateName].sql
```
