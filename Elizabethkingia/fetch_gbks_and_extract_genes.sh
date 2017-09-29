esearch -db assembly -query "Elizabethkingia" | efetch -db assembly -format docsum | xtract -pattern DocumentSummary -if RefSeq -element SpeciesName FtpPath_RefSeq > refseq_ftp.txt
cut -f 2 refseq_ftp.txt  | sed "s/\(\/GCF_.*\)/\1\1_genomic.gbff.gz/" > refseq_genbanks.txt
mkdir -p gbks && cd gbks && wget -i ../refseq_genbanks.txt
gzip -d *.gz
mkdir -p fasta && cd fasta 
rm -f *.fasta && for i in $(ls ../*.gbff); do python ../../../general_scripts/extract_gbk.py ${i}; done
