# gene_id = "ENSOANG00000002544"

# Checking table metadata
DESCRIBE New_Exon;

# Get the first 3 rows from each table
SELECT * FROM New_Gene LIMIT 3;
SELECT * FROM New_Transcript LIMIT 3;
SELECT * FROM New_Exon LIMIT 3;

# Counting the number of rows in each table
SELECT count(*) FROM New_Gene;
SELECT count(*) FROM New_Transcript;
SELECT count(*) FROM New_Exon;
SELECT count(*) FROM Old_Gene;
SELECT count(*) FROM Old_Transcript;
SELECT count(*) FROM Old_Exone;

# Practicing Joins
SELECT * FROM New_Transcript CROSS JOIN New_Exon LIMIT 3;
# Below 2 don't work...
SELECT * FROM New_Transcript CROSS JOIN New_Exon WHERE gene_id="ENSOANG00000002544"; # error 1052 - WHERE ambigous
SELECT * FROM New_Transcript WHERE gene_id="ENSOANG00000002544" CROSS JOIN New_Exon; # syntax error

# Trying to resolve why New_Exon has only 222391 rows instead of the expected 443432. I suspect its a primary key issue
SELECT count(DISTINCT exon_id) FROM New_Exon; # result = 222391. Every exon entry is distinct

# Checking if Gene and Transcript tables have correct number of rows (they do)
SELECT count(*) FROM New_Gene;
SELECT count(*) FROM New_Transcript;

# It turned out that in the exon table, exon_id is NOT a primary key.

# Get gene annotation details for chosen gene from new assembly
SELECT gene_name, gene_biotype, chromosome, start_, end_, end_ - start_
FROM New_Gene
WHERE gene_id="ENSOANG00000002544";

# Get the transcripts and their details for chosen gene from new assembly -- easy way (without #exons column)
SELECT transcript_id, transcript_name, start_, end_, end_ - start_
FROM New_Transcript
WHERE gene_id="ENSOANG00000002544";
# ... Hard way that I'm trying to get to work - JOIN doesn't work...
SELECT transcript_id, transcript_name, start_, end_, end_ - start_, count(*) AS number_of_exons
FROM New_Exon INNER JOIN New_Transcript ON New_Transcript.gene_id = New_Exon.gene_id
WHERE gene_id="ENSOANG00000002544";
# ... Try again with GROUP BY - this shit doesn't work, I'll just do the 3 query statement option....
SELECT A.transcript_id, B.transcript_name, count(*) AS number_of_exons
FROM New_Exon A, New_Transcript B
WHERE A.gene_id = "ENSOANG00000002544" and B.gene_id = "ENSOANG00000002544"
GROUP BY transcript_id;

# Final queries for new gene:
SELECT gene_name, gene_biotype, chromosome, start_, end_, end_ - start_ FROM New_Gene WHERE gene_id="ENSOANG00000002544";
SELECT transcript_id, transcript_name, start_, end_, end_ - start_ FROM New_Transcript WHERE gene_id="ENSOANG00000002544";
SELECT transcript_id, count(*) AS exon_count, count(*) + 1 AS intron_count FROM New_Exon WHERE gene_id="ENSOANG00000002544" GROUP BY transcript_id;

# Final queries for old gene:
SELECT gene_name, gene_biotype, chromosome, start_, end_, end_ - start_ FROM Old_Gene WHERE gene_id="ENSOANG00000002544";
SELECT transcript_id, transcript_name, start_, end_, end_ - start_ FROM Old_Transcript WHERE gene_id="ENSOANG00000002544";
SELECT transcript_id, count(*) AS exon_count, count(*) + 1 AS intron_count FROM Old_Exon WHERE gene_id="ENSOANG00000002544" GROUP BY transcript_id;


# Get the number of exons/introns for the chosen gene from new assembly
SELECT count(*) AS number_of_exons FROM New_Exon WHERE gene_id = "ENSOANG00000002544";
