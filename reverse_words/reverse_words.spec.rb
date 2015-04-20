require 'rspec'
require 'fileutils'

require_relative 'reverse_words'

describe WordReverse do
  
  let :test_file do
    'testfile.txt'
  end
  
  let :word_reverse do
    WordReverse.new
  end
  
  let :content do
    <<-EOS
candy rain
rain coat
EOS
  end
  
  it 'returns a string' do
    reverted = word_reverse.reverse_words test_file
    expect(reverted).not_to be_empty
  end
  
  it 'returns the correct amount of lines' do
    expect(word_reverse.reverse_words(test_file).split("\n").count).to eq 2
  end
  
  it 'ignores empty lines in the file' do
    content << <<-eos

eos
    File.open(test_file, 'w+') do |f|
      f.puts content
    end
    
    expect(word_reverse.reverse_words(test_file).split("\n").count).to eq 2
  end
  
  it 'reverses words per line' do
    reverted = word_reverse.reverse_words(test_file).split("\n")
    expect(reverted[0]).to eq 'rain candy'
    expect(reverted[1]).to eq 'coat rain'
  end
  
  before :each do
    File.open('testfile.txt', 'w+') do |f|
      f.puts content
    end
  end

  after :each do
    FileUtils.rm 'testfile.txt'
  end

  
end