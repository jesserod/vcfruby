Overview
============

This gem provides a lightweight class, `Vcf`, which can be used to parse VCF files by giving it one VCF line at a time.

To install, just install the `vcf` gem:

    sudo gem install vcf

Usage
=====

To print the DP (read depth) value of each entry, you might do this:
    require 'vcf'

    for line in gets
      next if line[0] == "#" # Skip header if it exists
      puts Vcf.new(line).info["DP"]
    end

You can do something similar with a one-liner at the command line

    cat test.vcf | ruby -r vcf -ne 'next if $_[0] == "#"; puts Vcf.new($_).info["DP"]' 

You can also use the `parse_line` method to reuse the same Vcf object

    require 'vcf'
    v = Vcf.new

    for line in gets
      if v.parse_line(line) # Returns false if line starts with # (a header line)
        puts v.info["DP"]
      end
    end


Details
=======
The `Vcf` class has the following member variables:

* `chrom`: A string such as "chr1".
* `pos`: An integer, 1-based start position of the locus.
* `id`: A string, the name/id of the locus.
* `ref`: A string, the reference allele.
* `alt`: A string, the alternate allele.
* `qual`: An integer or a string ("."), the quality of the locus.
* `filter`: A string, the list of filters that the locus failed.
* `info`: A hash, describing the locus with string keys pointing to string values. For example vcf.info["DP"] == "20".
* `format`: A string or nil, the name of properties for all samples at this locus (nil if no samples are specified).
* `samples`: A hash, {sample name => {property_name => property_value}}. For example vcf.samples["sally"]["GT"] == "0/1". If sample_names were not specified when parsing the line, sample names in this hash will be "1", "2", ... etc. Top level hash is emtpy if no samples are specified.
