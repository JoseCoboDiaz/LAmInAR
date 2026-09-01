
sample=[]
qac=[]
hsample={}
gene=[]
hgene={}
seq_b=''
gen_b=''
samp_b=''
n=0
# My dirty way to avoid problem with the last line:
#`cp #{ARGV[0]} temp.txt`
#`head -n 1 temp.txt >> temp.txt`

forward=[]
reverse=[]
forward2=[]
reverse2=[]
=begin
aa=File.open("blastn_attI_qacE.txt").each_line do |line|
col=line.split("\t")
puts col[0]
if col[1]=="qacE_MN699650.1"
	qac << col[0]
	if col[6].to_i < 500	# it means qacE is at the begining
	reverse2 << col[0]
	else forward2 << col[0]
	end
end
end
aa.close

qq=File.new("qac_temp.txt","w")
qq.puts qac
`grep -f qac_temp.txt blastn_attI_qacE.txt > blastn_attI_qacE_temp.txt`


aa=File.open("blastn_attI_qacE_temp.txt").each_line do |line|
col=line.split("\t")
puts col[0]
if col[1]=="attI_FJ663013.1"
	if col[6].to_i > 500	# it means attI is at the end
	reverse << col[0]
	else forward << col[0]
	end
end
end
aa.close

forward=forward.uniq
reverse=reverse.uniq
both1=forward2&reverse
both2=forward&reverse2

forward=forward-both1-both2
reverse=reverse-both1-both2

puts forward.length()
puts reverse.length()

fo=File.new("int_forward_and.txt","w")
re=File.new("int_reverse_and.txt","w")
fo.puts forward
re.puts reverse

`grep -f int_forward_and.txt #{ARGV[0]} > blastn_forward_and.txt`
`grep -f int_reverse_and.txt #{ARGV[0]} > blastn_reverse_and.txt`


# My dirty way to avoid problem with the last line:
`head -n 1 blastn_forward_and.txt >> blastn_forward_and.txt`
`head -n 1 blastn_reverse_and.txt >> blastn_reverse_and.txt`
=end
hfam={}
bb=File.open("genefam.tsv").each_line do |line|
line.chomp!
col=line.split("\t")
hfam[col[1]]=col[4]
end
bb.close

fam_b=''
fam=[]
hfam2={}
cc=File.open("blastn_forward_and.txt").each_line do |line|
line.chomp!
if line =~ /^\d+\s+((\S+)\_\d+)_\d+\s+((\S+)_\d\_\S+)\s+/
sample << $2	
	if n==0
	seq_b=$1
	gen_b=$4
	samp_b=$2
	fam_b=hfam[$3]
	n+=1
	elsif $1 != seq_b
	puts "#{seq_b}\t#{gen_b}" 
	gene << gen_b
	hfam2[gen_b]=fam_b
	seq_b=$1
	gen_b=$4
	samp_b=$2
	fam_b=hfam[$3]
	else
	gen_b="#{gen_b}\_#{$4}"
	fam_b="#{fam_b}\_#{hfam[$3]}"
	end
end
end
cc.close

n=0
cc=File.open("blastn_reverse_and.txt").each_line do |line|
line.chomp!
if line =~ /^\d+\s+((\S+)\_\d+)_\d+\s+((\S+)_\d\_\S+)\s+/
sample << $2	
	if n==0
	seq_b=$1
	gen_b=$4
	samp_b=$2
	fam_b=hfam[$3]
	n+=1
	elsif $1 != seq_b
	puts "#{seq_b}\t#{gen_b}" 
	gene << gen_b
	hfam2[gen_b]=fam_b
	seq_b=$1
	gen_b=$4
	samp_b=$2
	fam_b=hfam[$3]
	else
	gen_b="#{$4}\_#{gen_b}"
	fam_b="#{hfam[$3]}\_#{fam_b}"
	end
end
end
cc.close


hcount={}
bb=File.open("cluster_counts.txt").each_line do |line|
line.chomp!
#C01-01_165493__7160	1
if line =~ /^(\S+)\_\_\d+\s+(\S+)/
hcount[$1]=$2
end
end
bb.close


sample=sample.uniq
gene=gene.uniq
sample.each_index{|a| hsample[sample[a]] = a}
gene.each_index{|a| hgene[gene[a]] = a}
matrix=Array.new(gene.length()) {|index| Array.new(sample.length()) {|x| 0}}

seq_b=''
gen_b=''
samp_b=''
n=0
cc=File.open("blastn_forward_and.txt").each_line do |line|
line.chomp!
if line =~ /^\d+\s+((\S+)\_\d+)_\d+\s+(\S+)_\d\_/
	if n==0
	seq_b=$1
	gen_b=$3
	samp_b=$2
	n+=1
	elsif $1 != seq_b
	puts seq_b
	puts gen_b
	matrix[hgene[gen_b]][hsample[samp_b]]+=hcount[seq_b].to_i
	seq_b=$1
	gen_b=$3
	samp_b=$2
	else
	gen_b="#{gen_b}\_#{$3}"
	end
end
end
cc.close

n=0
cc=File.open("blastn_reverse_and.txt").each_line do |line|
line.chomp!
if line =~ /^\d+\s+((\S+)\_\d+)_\d+\s+(\S+)_\d\_/
	if n==0
	seq_b=$1
	gen_b=$3
	samp_b=$2
	n+=1
	elsif $1 != seq_b
	puts seq_b
	puts gen_b
	matrix[hgene[gen_b]][hsample[samp_b]]+=hcount[seq_b].to_i
	seq_b=$1
	gen_b=$3
	samp_b=$2
	else
	gen_b="#{$3}\_#{gen_b}"
	end
end
end
cc.close


salida=File.new("matrix_ARGs_integrons_patterns_fam_and.txt", 'w')

mm=-1
salida.print "\t#ARGs"
sample.each {|i| salida.print "\t#{i}"}
salida.print "\n"
matrix.each {|i|  mm+=1
salida.print "#{gene[mm]}\t#{hfam2[gene[mm]]}\t#{gene[mm].split("\_").length()}"
i.each {|value| salida.print "\t#{value}"}
salida.print "\n"
}



