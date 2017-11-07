# Bloomfilter

This is an implementation of a Bloom Filter for Ruby.

In order to confirm the false positives, the filter includes an array of the words in the file.  This is not needed by the algorithm and does effect the space requirements.  It can easily removed to make this implementation more stream-lined.

Initial implementation used 4 keys per value using a SHA2 digest and spliting it into 4 16-char strings and using each of those for a k.
This has been tested using the wordlist file included with 10,000,000 5-char strings and has returned 0 false positives.

Test results are as follows:

94 positive searches out of 100000
0 false positives values out of 100000

920 positive searches out of 1000000
0 false positives values out of 1000000

9014 positive searches out of 10000000
0 false positives values out of 10000000

This is expected since the hash is not constrained thus is can grow to have as many entries as needed.

A second attempt introduced a BitArray which constrains the size of the hash and means that all keys MUST be an integer.  This restriction meant that more false positives would be expected but we should get much faster performance.  This proved to be true if the size of the BitArray was smaller than the size of the list of words.  Once these reversed, the results were very positive for this implementation and it is much faster than the previous one.

Results:

BloomFilter > ruby bloom_filter_test.rb
Array Size = 100000
5807 positive searches out of 10000
5796 false positives values out of 10000

Array Size = 100000000
13 positive searches out of 10000
0 false positives values out of 10000

Array Size = 2000000
925 positive searches out of 10000
918 false positives values out of 10000

Array Size = 20000000
6 positive searches out of 10000
0 false positives values out of 10000


Requirement:
BitArray gem from https://github.com/peterc/bitarray

Description:
Initiazer takes a path to the work library you want to load in and a size for the Bit Array
then calling #contains? with an agrument of the value you want to check for will tests for that items inclusion in the filter.



