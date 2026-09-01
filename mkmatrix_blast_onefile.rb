
sample=[]
hsample={}
gene=[]
hgene={}

aa=File.open(ARGV[0]).each_line do |line|
line.chomp!
#C01-01_202_4__1374	ant(3'')-Ia_1_X02340	89.241	883	37	43	63	909	112	972	0.0	1051	1374	972
if line =~ /^((\w\d+-\d+)\_\d+)\_\d+(\_\_\d+)\s+(\S+)_\d\_/
#seq=$1, sample=$2, length=$3, gene=$4
sample << $2
gene << $4
end
end
aa.close

hcount={}
bb=File.open("cluster_counts.txt").each_line do |line|
line.chomp!
col=line.split("\t")
#C01-01_165493__7160	1
hcount[col[0]]=col[1]
end
bb.close

puts hcount

sample=sample.uniq
gene=gene.uniq
sample.each_index{|a| hsample[sample[a]] = a}
gene.each_index{|a| hgene[gene[a]] = a}
matrix=Array.new(gene.length()) {|index| Array.new(sample.length()) {|x| 0}}

seq=''
cc=File.open(ARGV[0]).each_line do |line|
line.chomp!
if line =~ /^((\w\d+-\d+)\_\d+)\_\d+(\_\_\d+)\s+(\S+)_\d\_/
#seq=$1, sample=$2, length=$3, gene=$4
	seq="#{$1}#{$3}"
	matrix[hgene[$4]][hsample[$2]]+=hcount[seq].to_i
end
end
cc.close

salida=File.new("matrix_ARGs_integrons_good.txt", 'w')

mm=-1
sample.each {|i| salida.print "\t#{i}"}
salida.print "\n"
matrix.each {|i|  mm+=1
salida.print "#{gene[mm]}"
i.each {|value| salida.print "\t#{value}"}
salida.print "\n"
}
