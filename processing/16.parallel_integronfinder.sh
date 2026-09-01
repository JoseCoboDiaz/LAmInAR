mkdir 02.integron_finder/
parallel -a list.txt -j 64 integron_finder --func-annot --cpu 1 --outdir 02.integron_finder/{} --calin-threshold 1 --promoter-attI 01.cdhit_outputs/fasta_good/{}.fna
