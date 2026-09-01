
#cat 01.cdhit_outputs/fasta_good/* > all_clusters.fna
#`grep "protein" 02.integron_finder/*/*/*integrons | cut -f 2 >> integron_reads_sept.names`
names=[]

aa=File.open("integron_reads_sept.names").each_line do |line|
line.chomp!
names << line
end
aa.close 

puts names.length()
names=names.uniq
puts names.length()

out=File.new("integron_reads_sept_unique.names","w")
names.each {|x| out.puts x}
out.close
`seqtk subseq all_clusters.fna integron_reads_sept_unique.names > all_integron_protein.fna`
