#!/usr/bin/python3

import cgi, cgitb, pymysql

cgitb.enable(display=0, logdir="./" )
form = cgi.FieldStorage()  # Create instance of FieldStorage

# Get the gene_id from field
gene_id = form.getvalue('gene_id')

# Connect to database
db = pymysql.connect(host="localhost", user="sadovsd", passwd="bio466", db="sadovsd")
cur_new_1 = db.cursor() # Create a Cursor object to execute queries
cur_new_2 = db.cursor()
cur_new_3 = db.cursor()
cur_old_1 = db.cursor()
cur_old_2 = db.cursor()
cur_old_3 = db.cursor()

# Query the new assembly tables for gene data
cur_new_1.execute(f'SELECT gene_name, gene_biotype, chromosome, start_, end_, end_ - start_ '
                  f'FROM New_Gene WHERE gene_id="{gene_id}"')
cur_new_2.execute(f'SELECT transcript_id, transcript_name, start_, end_, end_ - start_ '
                  f'FROM New_Transcript WHERE gene_id="{gene_id}";')
cur_new_3.execute(f'SELECT transcript_id, count(*) AS exon_count, count(*) + 1 AS intron_count '
                  f'FROM New_Exon WHERE gene_id="{gene_id}" GROUP BY transcript_id;')
# Query the old assembly tables for gene data
cur_old_1.execute(f'SELECT gene_name, gene_biotype, chromosome, start_, end_, end_ - start_ '
                  f'FROM Old_Gene WHERE gene_id="{gene_id}"')
cur_old_2.execute(f'SELECT transcript_id, transcript_name, start_, end_, end_ - start_ '
                  f'FROM Old_Transcript WHERE gene_id="{gene_id}";')
cur_old_3.execute(f'SELECT transcript_id, count(*) AS exon_count, count(*) + 1 AS intron_count '
                  f'FROM Old_Exon WHERE gene_id="{gene_id}" GROUP BY transcript_id;')

# Convert the query results into lists
new_1 = cur_new_1.fetchall()
new_2 = cur_new_2.fetchall()
new_3 = cur_new_3.fetchall()
old_1 = cur_old_1.fetchall()
old_2 = cur_old_2.fetchall()
old_3 = cur_old_3.fetchall()

print("Content-type:text/html\r\n\r\n")
print("<html>")
print("<head>")
print("<title>Form Results</title>")
print("</head>")
print("<body>")
print("<h1>Comparison Results</h1><br><br>")

# Display the comparison results
if len(new_1) == 0:
    print("<b><font size='+1'>Release 108 (Oct 2022):</font></b><br>")
    print(f"<span style='margin-left:40px'>Gene {gene_id} is not in the new release!</span><br>")
else:
    print("<b><font size='+1'>Release 108 (Oct 2022):</font></b><br>")
    print(f"<span style='margin-left:40px'>Gene ID: {gene_id}</span><br>")
    print(f"<span style='margin-left:40px'>Gene Name: {new_1[0][0]}</span><br>")
    print(f"<span style='margin-left:40px'>Gene Category: {new_1[0][1]}</span><br>")
    print(f"<span style='margin-left:40px'>Chromosome: {new_1[0][2]}</span><br>")
    print(f"<span style='margin-left:40px'>Start: {new_1[0][3]}</span><br>")
    print(f"<span style='margin-left:40px'>End: {new_1[0][4]}</span><br>")
    print(f"<span style='margin-left:40px'>Gene Length: {new_1[0][5]}</span><br>")
    print(f"<span style='margin-left:40px'>Number of Transcripts: {len(new_2)}</span><br>")
    for row1, row2 in zip(new_2, new_3):
        print(f"<span style='margin-left:80px'></span>")
        for i, col in enumerate(row1):
            if i == 0:
                print(f"{col}: ")
            elif i == 1:
                label = "name="
            elif i == 2:
                label = "start="
            elif i == 3:
                label = "end="
            else:
                label = "length="
            if i != 0:
                print(f"{label}{col}, ")
        print(f"exons={row2[1]}, ")
        print(f"introns={row2[2]}")
        print("<br>")

if len(old_1) == 0:
    print("<br><br><b><font size='+1'>Release 97 (July 2019):</font></b><br>")
    print(f"<span style='margin-left:40px'>Gene {gene_id} is not in the old release!</span><br>")
else:
    print("<br><br><b><font size='+1'>Release 97 (July 2019):</font></b><br>")
    print(f"<span style='margin-left:40px'>Gene ID: {gene_id}</span><br>")
    print(f"<span style='margin-left:40px'>Gene Name: {old_1[0][0]}</span><br>")
    print(f"<span style='margin-left:40px'>Gene Category: {old_1[0][1]}</span><br>")
    print(f"<span style='margin-left:40px'>Chromosome: {old_1[0][2]}</span><br>")
    print(f"<span style='margin-left:40px'>Start: {old_1[0][3]}</span><br>")
    print(f"<span style='margin-left:40px'>End: {old_1[0][4]}</span><br>")
    print(f"<span style='margin-left:40px'>Gene Length: {old_1[0][5]}</span><br>")
    print(f"<span style='margin-left:40px'>Number of Transcripts: {len(old_2)}</span><br>")
    for row1, row2 in zip(old_2, old_3):
        print(f"<span style='margin-left:80px'></span>")
        for i, col in enumerate(row1):
            if i == 0:
                print(f"{col}: ")
            elif i == 1:
                label = "name="
            elif i == 2:
                label = "start="
            elif i == 3:
                label = "end="
            else:
                label = "length="
            if i != 0:
                print(f"{label}{col}, ")
        print(f"exons={row2[1]}, ")
        print(f"introns={row2[2]}")
        print("<br>")

print("</body>")
print("</html>")