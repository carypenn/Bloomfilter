require 'digest'

module Filters
	class BloomFilter
		def initialize(filename)
			@h = {}
			@wordlist = []
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
			r = i(str).detect { |k| !@h[k] }
			return !r
		end
		private
		def i(str)
			r = Digest::SHA2.hexdigest str
			(0..3).map { |j| r[(j*16)..(16+j*16)]}
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
