

sample=''
samples=[]
values=[]
out=File.new("mean_amplicon_length.txt","w")

#values.concat(["a"]*5)
#values.concat([5]*3)
#puts values

hcount={}
hlength={}
aa=File.open("cluster_counts.txt").each_line do |line|
line.chomp!
col=line.split("\t")
#C01-01_165493__7160    1
if line =~ /^\S+/ #to avoid problems with "bad" lines
hcount[col[0]]=col[1]
col2=col[0].split("\_\_")
hlength[col2[0]]=col2[1]
end
end
aa.close



bb=File.open("all_integron_protein.fna").each_line do |line|
line.chomp!
#>C01-01_1023_16__1287
if line =~ />((\S+)\_\d+)\_\d+/#\_\_(\d+)/ 
	if $2!=sample and samples.length!=0
	out.puts "#{sample}\t#{values.sum()/values.length()}\t#{values.length()}"
puts "#{sample}\t#{values.sum()/values.length()}\t#{values.length()}"
	values=[]
	nsamples=[]
	values.concat(["#{hlength[$1]}".to_i]*hcount["#{$1}__#{hlength[$1]}"].to_i)
	samples << $2
	sample=$2
	elsif $2!=sample
	values.concat(["#{hlength[$1]}".to_i]*hcount["#{$1}__#{hlength[$1]}"].to_i)
	samples << $2
	sample=$2
#	else values.concat([$3.to_i]*hcount["#{$1}__#{$3}"].to_i)
	else values.concat(["#{hlength[$1]}".to_i]*hcount["#{$1}__#{hlength[$1]}"].to_i)
	end
end
end
bb.close

out.puts "#{sample}\t#{values.sum()/values.length()}\t#{values.length()}"
puts "#{sample}\t#{values.sum()/values.sum()}\t#{values.length()}"


