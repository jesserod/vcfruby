#!/usr/bin/env ruby

load "#{File.dirname(__FILE__)}/../lib/vcf.rb"

lines=[
"20	1230237	.	T	.	47	PASS	NS=3;DP=13;AA=T	GT:GQ:DP:HQ	0|0:54:.:56,60	0|0:48:4:51,51	0/0:61:2:.,.",
"20	1234567	microsat1	G	GA,GAC	50	PASS	NS=3;DP=9;AA=G;AN=6;AC=3,1	GT:GQ:DP	0/1:.:4	0/2:17:2	1/1:40:3",
"20	1235237	.	T	.	.	.	.	GT	0/0	0|0	./.",
"X	10	rsTest	AC	A,ATG	10	PASS	.	GT	0	0/1	0|2",
"X	11	rsTest2	T	A,<DEL:ME:ALU>	10	q10;s50	.	GT:DP:GQ	.:3:10	./.	0|2:3"
]


for line in lines
  v = Vcf.new(line, ['sampleA', 'B', 'C'])

  puts line.gsub("\t", "  \\t  ")
  puts
  puts "CHROM #{v.chrom}"
  puts "POS #{v.pos}"
  puts "ID #{v.id}"
  puts "REF #{v.ref}"
  puts "ALT #{v.alt}"
  puts "QUAL #{v.qual}"
  puts "FILTER #{v.filter}"
  puts "INFO #{v.info.inspect}"
  puts "SAMPLES #{v.samples.inspect}"
  puts
end
