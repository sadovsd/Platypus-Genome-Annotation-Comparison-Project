CREATE TABLE New_Gene (
    gene_id VARCHAR(19) PRIMARY KEY,
    gene_name VARCHAR(17),
    gene_biotype VARCHAR(21),
    chromosome VARCHAR(15),
    strand VARCHAR(2),
    source_ VARCHAR(8),
    start_ INT(10),
    end_ INT(10),
    gene_version VARCHAR(2)
);

CREATE TABLE Old_Gene (
    gene_id VARCHAR(19) PRIMARY KEY,
    gene_name VARCHAR(17),
    gene_biotype VARCHAR(15),
    chromosome VARCHAR(13),
    strand VARCHAR(2),
    source_ VARCHAR(19),
    start_ INT(9),
    end_ INT(9),
    gene_version VARCHAR(2)
);

CREATE TABLE New_Transcript (
    transcript_id VARCHAR(19) PRIMARY KEY,
    gene_id VARCHAR(19),
    transcript_name VARCHAR(21),
    transcript_biotype VARCHAR(21),
    start_ INT(10),
    end_ INT(10),
    transcript_version VARCHAR(2)
);

CREATE TABLE Old_Transcript (
    transcript_id VARCHAR(19) PRIMARY KEY,
    gene_id VARCHAR(19),
    transcript_name VARCHAR(21),
    transcript_biotype VARCHAR(15),
    start_ INT(9),
    end_ INT(9),
    transcript_version VARCHAR(2)
);

CREATE TABLE New_Exon (
    exon_id VARCHAR(19),
    gene_id VARCHAR(19),
    transcript_id VARCHAR(19),
    exon_number VARCHAR(3),
    start_ INT(10),
    end_ INT(10),
    exon_version VARCHAR(2),
    PRIMARY KEY (exon_id, transcript_id)
);

CREATE TABLE Old_Exon (
    exon_id VARCHAR(19),
    gene_id VARCHAR(19),
    transcript_id VARCHAR(19),
    exon_number VARCHAR(4),
    start_ INT(9),
    end_ INT(9),
    exon_version VARCHAR(2),
    PRIMARY KEY (exon_id, transcript_id)
);