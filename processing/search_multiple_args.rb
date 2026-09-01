

pre=''
qpre=''
spre=''
aa=File.open(ARGV[0]).each_line do |line|
line.chomp!
col=line.split("\t")
#C01-01_202_4__1374	ant(3'')-Ia_1_X02340	89.241	883	37	43	63	909	112	972	0.0	1051	1374	972
#C01-01_241_5__1854	ant(3'')-Ia_1_X02340	94.183	808	22	19	460	1252	968	171	0.0	1208	1854	972
#C01-01_241_5__1854	ant(3'')-Ia_1_X02340	98.413	63	1	0	1787	1849	174	112	1.05e-24	111	1854	972
if col[0]==qpre and col[1]!=spre
puts pre
puts line
end
if col[3].to_i > 100 and col[3].to_i/col[13].to_i > 0.8 and col[0]!=qpre
puts line
end
pre=line
qpre=col[0]
spre=col[1]
end
aa.close
