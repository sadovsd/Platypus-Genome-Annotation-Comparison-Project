# Readme.md

## Gene Annotation Comparison - step by step 

1.) Downloaded the platypus genome zipped .gtf files from Ensembl. An old version was accessed from Ensembl Archive Release 97 (July 2019) at [http://jul2019.archive.ensembl.org/Ornithorhynchus_anatinus/Info/Index](http://jul2019.archive.ensembl.org/Ornithorhynchus_anatinus/Info/Index) . The newest version was accessed from Ensembl Release 108 (Oct 2022) at 
[https://useast.ensembl.org/Ornithorhynchus_anatinus/Info/Index](https://useast.ensembl.org/Ornithorhynchus_anatinus/Info/Index)

2.) In a jupyter notebook file, in my local mac directory, wrote a class (Annotation) that parsed a gtf.gz file in its constructor using the pyranges module and then converted it to a dataframe.

3.) Performed various comparisons between 2 annotation objects (97 and 108 release) using methods in the Annotation class. 

4.) Used a method in the Annotation class to convert each annotation object into 3 tab delimited .txt files. The file names were “New_Gene.txt”, “New_Transcript.txt”, “New_Exon.txt”, “Old_Gene.txt”, “Old_Transcript.txt”, and “Old_Transcript.txt”.

5.) Wrote DDL.sql file containing code that initializes 6 such tables. The table names were “New_Gene”, “New_Transcript”, “New_Exon”, “Old_Gene”, “Old_Transcript”, and “Old_Transcript”.

6.) Secure copied the 6 tab delimited .txt files into the 
```bash 
/home/sadovsd 
```
directory by executing the 
```bash
scp file_location sadovsd@bio466-f15.csi.miamioh.edu:/home/sadovsd
```
command on the local mac terminal.

7.) Secure copied DDL.sql file into the /home/sadovsd directory on the class server by executing the command 
```bash
scp file_location sadovsd@bio466-f15.csi.miamioh.edu:/home/sadovsd 
```
command on the local mac terminal.

8.) Logged into the class server by executing the command 
```bash
ssh -x sadovsd@bio466-f15.csi.miamioh.edu 
```
and entering Miami password, on my local mac terminal.

9.) Started mysql using by executing the command 
```bash
mysql sadovsd -u sadovsd -p
```
with password 
```bash
bio466
```
in the 
```bash
/home/sadovsd
```
 location in the class server terminal.

10.) Created the tables in the sadovsd mysql database using the mysql command 

```bash
source DDL.sql
```  

11.) Added data into the 6 mysql tables by quitting the current mysql session, and executing the command 
```bash
mysqlimport -L -u sadovsd -p sadovsd table.txt
```
 with password “bio466” in home/sadovsd directory. This was performed 6 times, once for each table.

12.) Wrote a DML.sql file that contains queries to extract all relevant information about a gene given a specific gene_id. 

13.) In pycharm, in my local mac directory, created a .html file that represented a webpage. Various annotation comparison information and graphs were added to the page. A form was created that allows a user to enter a gene id that they wish to see information about from both annotations. The action parameter pointed to a new .py file that actually would perform the necessary queries.

14.) In pycharm, in my local mac directory, created a .py script that would perform queries using the gene id a user would enter using the .html form. This script connected to the .html form using cgi and cgitb. It connected to the sadovsd database (which contains the 6 tables about gene, transcript, and exon data) using mypysql. The DML queries written before in the DML.sql file were copied into this script to extract the necessary gene information from the database. HTML output containing formatted gene comparison information was generated using print statements in this script.

15.) The .html file, .py script, and any image files that were part of the web page were secure copied into the /home/sadovsd/public_html directory using the “scp” command.
