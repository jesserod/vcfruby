class Vcf
public
  attr_accessor :chrom, :pos, :id, :ref, :alt, :qual, :filter, :info, :format, :samples

  def initialize(line=nil, sample_names=nil)
    @info = {}
    @samples = {}
    parse_line(line, sample_names) if line != nil
  end

  def int_or_raw(x)
    Integer.new(x) rescue x
  end

  def parse_line(line, sample_names=nil)
    f = line.chomp.split("\t", -1)
    raise "VCF lines must have at least 8 fields" if f.size < 8
    @chrom = f[0]
    @pos = f[1].to_i
    @id = f[2]
    @ref = f[3]
    @alt = f[4]
    @qual = int_or_raw(f[5])
    @filter = f[6]

    @info = {}
    info_vec = f[7].split(";")
    info_vec.each do |x|
      keyval = x.split("=", -1)
      if keyval.size == 2 # If it's key=value
        @info[keyval[0]] = keyval[1]
      else # Otherwise, it's just a flag
        @info[x] = ""
      end
    end

    @samples = {}
    return true if f.size == 8  # Has just upto info
    raise "Can't have format with no samples" if f.size == 9
    
    @format = f[8]

    sample_keys = @format.split(":")

    num_samples = f.size - 9 # How many fields are past the format

    if sample_names == nil # Make the sample names just ["1", "2", ... , "num_samples}"
      sample_names = (1..num_samples).to_a.map{|i| i.to_s} 
    elsif sample_names.size != num_samples
      raise "Unexpected number of samples (#{num_samples}) based on the provided sample names (#{sample_names.inspect})"
    end

    sample_names.each_with_index do |sample_name, sample_index|
      i = sample_index + 9 # index into columns (f)
      sample_values = f[i].split(":")
      raise "Expected number of sample values to be <= number of sample keys in FORMAT column Format=#{@format} but sample=#{f[i]}" if sample_values.size > sample_keys.size
      @samples[sample_name] = {}
      sample_keys.each_with_index {|key, value_index| @samples[sample_name][key] = sample_values[value_index] || ""}
    end
    
    return true;
  end

end
