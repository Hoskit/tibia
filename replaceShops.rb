#!/usr/bin/ruby

files = Dir.glob("npc/*.xml")
regex = "([1-8][0-9]{3})"

files.each do |file|
	aFile = File.open(file, "r")
	aString = aFile.read
	aFile.close


		itemID = aString[/potion,([0-9]+),([0-9]+);"/, 1]
		itemPrice = aString[/potion,([0-9]+),([0-9]+);"/, 2].to_i * 10

		itemPrice = itemPrice.to_i

		aString.gsub!(/potion,([0-9]+),([0-9]+);"/, "potion,#{itemID},#{itemPrice};\"")
 
	File.open(file, "w") { |file| file << aString }
end