#!/usr/bin/ruby

files = Dir.glob("npc/*.xml")
regex = "([1-8][0-9]{3})"

files.each do |file|
	aFile = File.open(file, "r")
	aString = aFile.read
	aFile.close

	experience = aString[/experience="([0-9]+)"/, 1].to_i

	if experience > 2000
		doubleFieldSize = aString[/health now="#{regex}" max="#{regex}"/, 1].to_i * 1.2
		doubleFieldSize2 = aString[/health now="#{regex}" max="#{regex}"/, 2].to_i * 1.2

		doubleFieldSize = doubleFieldSize.to_i
		doubleFieldSize2 = doubleFieldSize2.to_i

		aString.gsub!(/health now="#{regex}" max="#{regex}"/, "health now=\"#{doubleFieldSize}\" max=\"#{doubleFieldSize2}\"")
 
	File.open(file, "w") { |file| file << aString }
	end
end