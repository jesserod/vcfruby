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

for line in lines
  f = line.split("=")
  if f.size != 2
    puts line
  elsif f[0] =~ /s.date/
    now = Time.now
    puts "#{f[0]}= #{now.year}-#{now.month}-#{now.day}"
  elsif f[0] =~ /s.version/
    if !new_version
      version = f[1].split(".")
      raise unless version.size == 3
      version.map!{|x| x.to_i}
      version[2] += 1
      new_version = version.join(".")
    end
      puts "#{f[0]}= #{new_version}"
  else
    puts line
  end
end

