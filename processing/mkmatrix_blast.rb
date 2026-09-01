

sample=[]
hsample={}
gene=[]
hgene={}

aa=File.open("list_blast.txt").each_line do |file|
file.chomp!
puts "...reading genes from #{file}"
	if file =~ /resfinder_(.*)\.fasta/
	sample << $1
	bb=File.open("blast/#{file}").each_line do |line|
	line.chomp!
		if line =~ /^\S+\s+(\w+)\_\d\_/
		gene << $1
		end
	end
	bb.close
	end
end
aa.close

gene=gene.uniq
sample.each_index{|a| hsample[sample[a]] = a}
gene.each_index{|a| hgene[gene[a]] = a}
matrix=Array.new(gene.length()) {|index| Array.new(sample.length()) {|x| 0}}

samp=''
aa=File.open("list_blast.txt").each_line do |file|
file.chomp!
puts "...counting genes from #{file}"
        if file =~ /resfinder_(.*)\.fasta/
        samp=$1
        bb=File.open("blast/#{file}").each_line do |line|
        line.chomp!
                if line =~ /^\S+\s+(\w+)\_\d\_/
		matrix[hgene[$1]][hsample[samp]]+=1
                end
        end
        bb.close
        end
end
aa.close

salida=File.new("matrix_ARGs_integrons.txt", 'w')

mm=-1
sample.each {|i| salida.print "\t#{i}"}
salida.print "\n"
matrix.each {|i|  mm+=1
salida.print "#{gene[mm]}"
i.each {|value| salida.print "\t#{value}"}
salida.print "\n"
}
