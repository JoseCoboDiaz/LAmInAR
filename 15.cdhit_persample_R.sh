#mkdir 01.cdhit_outputs
for x in $(cat list_R.txt | sed 's/.fasta//g'); do echo ${x} /
cdhit -i 00.reads_quality_fixname/${x}.fasta -o 01.cdhit_outputs/${x} -c 0.9 -s 0.9 -T 48 -M 200000; done
