filename = ARGV[0]
text_as_string = File.read(filename)
text_as_string = text_as_string.gsub(/-/, " ")
text_as_array = text_as_string.split

frequencies = Hash.new(0)

stop_words = File.readlines("stop_words.txt")

stop_words.map! {|word| word.chomp}
# puts stop_words

text_as_array.each do |word|
  clean_word = word.gsub(/[\(\);:.,!\\\?"\*]/, "").downcase
  # puts clean_word
  frequencies[clean_word] += 1 unless stop_words.include?(clean_word)
end

frequency_array = []

frequencies.each do |word, count|
  frequency_array << [word, count]
end

frequency_array.sort! {|x,y| y[1] <=> x[1]}

frequency_array[0..(ARGV[1].to_i - 1)].each do |entry|
  puts "#{entry[0]}: #{entry[1]}"
end
