
hcode={}

`mkdir 00.raw_reads`

aa=File.open("WP4_samples_ULE_meat.csv").each_line do |line|
line.chomp!
col=line.split(",")
hcode[col[1].gsub(" ","-").gsub("C0","C").gsub("F0","F").gsub("R0","R")]=col[0]
end
aa.close

name=''
term=''
bb=File.open(ARGV[0]).each_line do |line|
line.chomp!
col=line.split("\t")
if col[2] =~ /^(\w\d\-\w\d+)(.*)/ 
term=$2
name=$1
puts "......merging fastq files from #{col[0]}/fastq_pass/#{col[1]} (sample called #{col[2]}) to 00.raw_reads/#{hcode[$1]}#{$2}.fastq"
	if col[0] =~ /coral/
	`cat #{col[0]}/fastq_pass/#{col[1]}/* > 00.raw_reads/#{hcode[name]}#{term}.fastq`
	else 	`zcat #{col[0]}/fastq_pass/#{col[1]}/* > 00.raw_reads/#{hcode[name]}#{term}.fastq`
	end
else puts "......merging fastq files from #{col[0]}/fastq_pass/#{col[1]} (sample called #{col[2]}) to 00.raw_reads/#{col[2]}.fastq"
       `zcat #{col[0]}/fastq_pass/#{col[1]}/* > 00.raw_reads/#{col[2]}.fastq`
end
end
bb.close


