
`ls samples_100ng/ > list_fastq.txt`

aa=File.open("list_fastq.txt").each_line do |line|
line.chomp!
puts "...... transforming #{line} to #{line.gsub("fastq","fasta")}"
`sed -n '1~4s/^@/>/p;2~4p' samples_100ng/"#{line}" > fasta_files/"#{line.gsub("fastq","fasta")}"`
end
aa.close
