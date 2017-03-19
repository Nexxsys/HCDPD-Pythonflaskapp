#!/bin/bash
# $Source: unfiled
# $Revision: 1 $
# Author: Jim Busser
# fetcher of Health Canada Drug Product Databases (DPD)
# munger of CSV into pipe-separated values to forestall
# sqlite3 CLI tendency to hiccup on CSV parsing
# sqlite is used by tne new BSD-licensed FreeDiams

# optionally uncomment the following
# cd ~
# mkdir ca_dpd
# cd ca_dpd

#obtain *licensed* data files from Health Canada
wget http://www.hc-sc.gc.ca/dhp-mps/alt_formats/zip/prodpharma/databasdon/allfiles.zip
unzip allfiles.zip

# sqlite CLI has trouble parsing csv ("", "") import
# therefore substitute vertical pipes, using Stream EDiting (sed) tool
# This method relies on absence of vertical pipes from the input and
# entails replacing "," by | and stripping quotes at beginning & end of lines
# Had the CSV creator not double-quote-wrapped everything,
# any internal commas would have posed a problem.

sed -e 's/.$//' -e 's/","/|/g' -e 's/\(^"\)\(.*\)/\2/' -e 's/"$//w drug.csv' drug.txt
sed -e 's/.$//' -e 's/","/|/g' -e 's/\(^"\)\(.*\)/\2/' -e 's/"$//w form.csv' form.txt
sed -e 's/.$//' -e 's/","/|/g' -e 's/\(^"\)\(.*\)/\2/' -e 's/"$//w route.csv' route.txt
sed -e 's/.$//' -e 's/","/|/g' -e 's/\(^"\)\(.*\)/\2/' -e 's/"$//w status.csv' status.txt
sed -e 's/.$//' -e 's/","/|/g' -e 's/\(^"\)\(.*\)/\2/' -e 's/"$//w ingred.csv' ingred.txt
sed -e 's/.$//' -e 's/","/|/g' -e 's/\(^"\)\(.*\)/\2/' -e 's/"$//w ther.csv' ther.txt
sed -e 's/.$//' -e 's/","/|/g' -e 's/\(^"\)\(.*\)/\2/' -e 's/"$//w package.csv' package.txt

# the above does omit some DPD files for which FreeDiams is not yet ready

# FIXME how to enable suppressing echo to screen
# using option -n is no good as, it results in empty files

# explanation of the above:
# employ the -e multiple command option for 4 commands
#
# 's/.$//'
# --> on account of these being Windows CR/LF files:
# --> substitute the last character . prior to line endings $ with nothing
#
# 's/","/|/g'
# --> uses the sed 'substitution' (s) command
# --> replaces CSV comma-within-double quotes with a vertical pipe
# --> non-universally quote-wrapped CSVs may need all commas replaced
# --> recursively (globally: g) for all occurrences within each line
#
# 's/\(^"\)\(.*\)/\2/'
# --> looks for two patterns, each within escaped parentheses \( \)
# --> first pattern is beginning of line double-quote ^"
# --> second pattern is the remainder of the line
# --> only the second among these patterns \2 is retained
# 's/"$//w package.csv'
# --> remove the trailing quote " before end of line $
# --> write w filename
# 
# the last parameter per statement is the input file


# create a new sqlite database from the above data
echo "Working..."
echo "this will need several minutes..."
sqlite3 dpd.db <create_dpd_db.sql
#sqlite3 dpd.db < -init create_dpd_db.sql
# see if the following alternate method will fix failure of exit
# for Ubuntu  # sqlite3 dpd.db <create_dpd_db.sql
#sqlite dpd.db <create_dpd_db.sql


# in case the default drugs.db database is available
mv drugs.db drugs.origdb
cp dpd.db drugs.db
