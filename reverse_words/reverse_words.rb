#!/usr/bin/ruby

class WordReverse
  
  def reverse_words(filename)
    reverted = ''
    File.open(filename, 'r').each_line do |line|
      line.strip!
      next if(line.nil? || line.empty?)
      
      line.split(' ').reverse.each do |word| 
        reverted << "#{word.strip} "
      end
      reverted.gsub!(/ $/, "\n")
    end
    reverted
  end
  
end

raise ArgumentError.new('Please provide a filename as first parameter') if ARGV[0].nil?

puts WordReverse.new.reverse_words(ARGV[0])