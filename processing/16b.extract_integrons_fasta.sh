
#cat 01.cdhit_outputs/fasta_good/* > all_clusters.fna

#touch integron_reads.names
#for x in $(ls 02.integron_finder); do \
#echo ${x}; 
#grep -P "\t1" 02.integron_finder/${x}/*/*summary | cut -f 1 >> integron_reads.names; 
#done

seqtk subseq all_clusters.fna integron_reads.names > all_integron.fna
