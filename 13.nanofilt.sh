
source /home/josecobo/miniconda3/etc/profile.d/conda.sh
conda activate gridion

mkdir 00.reads_quality/
for i in $(ls 00.porechop2/ | sed 's/.fastq//g'); do echo "---> Runing NanoFilt on sample ${i}"; cat 00.porechop2/${i}.fastq | NanoFilt -q 10 -l 150 | sed -n '1~4s/^@/>/p;2~4p' > 00.reads_quality/${i}.fasta; done


