#!/usr/bin/ruby

files = Dir.glob("monster/**/*.xml")

files.each do |file|
	#puts file
	File.open(file).each_line do |line| 
	if line.match /health now="[0-9]+" max="([3-9][0-9]{3})"/
	#puts line
	fieldMatch = line.match /health now="([0-9])+" max="([3-9][0-9]{3})"/
    doubleFieldSize = fieldMatch[2].to_i * 2
    #puts fieldMatch[1].gsub(/health now="[0-9]+" max="([3-9][0-9]{3})/, doubleFieldSize)

   puts doubleFieldSize
		end
	end
end
