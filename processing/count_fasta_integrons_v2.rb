
samples=[]
hsample={}

aa=File.open("all_integron_slen.fna").each_line do |line|
line.chomp!
#C01-01_1023_16__1287
if line =~ />((\S+)\_\d+)\_\d+(\_\_\d+)/
samples << $2
end
end
aa.close

hcount={}
bb=File.open("cluster_counts.txt").each_line do |line|
line.chomp!
col=line.split("\t")
#C01-01_165493__7160    1
hcount[col[0]]=col[1]
end
bb.close

samples=samples.uniq
samples.each_index{|a| hsample[samples[a]] = a}
matrix=Array.new(samples.length()){|x| 0}

seq=''
aa=File.open("all_integron_slen.fna").each_line do |line|
line.chomp!
if line =~ />((\S+)\_\d+)\_\d+(\_\_\d+)/
seq="#{$1}#{$3}"
hsample[$2]+=hcount[seq].to_i
end
end
aa.close

salida=File.new("counts_total_integrons_v2.txt","w")
samples.each {|i| salida.puts "#{i}\t#{hsample[i]}"}
