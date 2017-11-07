require_relative 'bloom_filter'

filter = Filters::BloomFilter.new('wordlist.txt',20000000)
n = 10000
positives = []
false_positives = []
(1..n).each do
	w = ('a'..'z').to_a.shuffle[0,5].join
	if filter.contains?(w)
		positives << w
		false_positives << w  if !filter.word_list.include?(w)
	end
end
puts "#{positives.count} positive searches out of #{n}"
# positives.each { |p| puts p }
puts "#{false_positives.count} false positives values out of #{n}"