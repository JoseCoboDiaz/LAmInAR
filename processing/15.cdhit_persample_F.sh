#mkdir 01.cdhit_outputs
for x in $(ls 00.reads_quality_fixname/F* | sed "s/.fasta//g" | sed "s/00.reads_quality_fixname//g"); do \
echo ${x} /
cdhit -i 00.reads_quality_fixname${x}.fasta -o 01.cdhit_outputs${x} -c 0.9 -s 0.9 -T 32 -M 200000; done
