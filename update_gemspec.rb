#!/usr/bin/env ruby

if ARGV.first == "-h"
  puts "args: [new version]"
  exit
end

new_version = nil
if ARGV.first != nil
  new_version = ARGV.first
end

file = File.new("vcf.gemspec")
lines = file.readlines.map{|x| x.chomp}

new_lines = []

for line in lines
  f = line.split("=")
  if f.size != 2
    new_lines << line
  elsif f[0] =~ /s.date/
    now = Time.now
    new_lines << "#{f[0]}= #{now.year}-#{now.month}-#{now.day}"
  elsif f[0] =~ /s.version/
    if !new_version
      version = f[1].split(".")
      raise unless version.size == 3
      version.map!{|x| x.to_i}
      version[2] += 1
      new_version = version.join(".")
    end
      new_lines << "#{f[0]}= '#{new_version}'"
  else
    new_lines << line
  end
end

out_file = File.new("vcf.gemspec", "w")
for line in new_lines
  out_file.puts line
end
out_file.close

