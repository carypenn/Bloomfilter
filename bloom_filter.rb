require 'digest'
require 'bitarray'
module Filters
	class BloomFilter
		def initialize(filename, size=100)
			#@h = {}
			@wordlist = []
			@size = size
			@h = BitArray.new(@size)
			read_file(filename)
		end
		def word_list
			@wordlist
		end
		def size
			@h.size
		end
		def add(str)
			i(str).each { |k| @h[k] = 1}
			@wordlist << str
		end
		def contains?(str)
			# r = i(str).detect { |k| !@h[k] }
			r = i(str).detect { |k| @h[k] == 0 }
			return !r
		end
		private
		def i(str)
			num_keys = 8
			key_length = 8
			r = Digest::SHA2.hexdigest str
			(0..(num_keys-1)).map do |j| 
				n = r[(j*key_length)..(key_length+j*key_length)].hex
				(n % @size)
			end
		end
		def read_file(filename)
			File.open(filename, 'r') do |f|
				f.each_line do |l|
					add(l.gsub("\n",''))
				end
			end
		end
	end
end
