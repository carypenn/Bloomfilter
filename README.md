# Bloomfilter

This is an implementation of a Bloom Filter for Ruby.
This uses 4 keys per value using a SHA2 digest and spliting it into 4 16-char strings and using each of those for a k.  

This has been tested using the wordlist file included with 10,000,000 5-char strings and has returned 0 false positives.

Initiazer takes a path to the work library you want to load in.
then calling #contains? with an agrument of the value you want to check for will tests for that items inclusion in the filter.

