
source /home/josecobo/miniconda3/etc/profile.d/conda.sh
conda activate gridion

#ls 00.raw_reads > list.txt
mkdir 00.porechop2
parallel -j 8 -a list.txt porechop -i 00.raw_reads/{} -o 00.porechop2/{} --threads 16
