
`ls 00.reads_quality > list.txt`
`mkdir 00.reads_quality_fixname`

sample=''

aa=File.open("list.txt").each_line do |file|
file.chomp!
sample=file.gsub(".fasta","")
puts "--- transforming #{file} file"
out=File.new("00.reads_quality_fixname/#{file}","w")
	bb=File.open("00.reads_quality/#{file}").each_line do |line|
	line.chomp!
	if line =~ /read=(\d+)\s+/
	out.puts ">#{sample}_#{$1}"#\sread=#{$1} sample=#{sample}"
	else out.puts line
	end
	end
	bb.close
end
aa.close
