#!/usr/local/bin/ruby

prompt = '> '
ColorData = Struct.new(:colorName, :percentOfColor, :percentDepthOfShade, :percentDyeStock, :dyeVolume, :carryingCapacity, :waterNeeded)

puts "What is the dry weight in grams?"
print prompt
weightDry = Integer($stdin.gets.chomp)

puts "What is the damp weight in grams?"
print prompt
weightDamp = Integer($stdin.gets.chomp)

puts "What is the saturated weight in grams?"
print prompt
weightSaturated = Integer($stdin.gets.chomp)

totalCapacity = weightSaturated - weightDamp

puts "How many colors are you using?"
print prompt
numColors = Integer($stdin.gets.chomp)

colorDataArray = Array.new
percentageValidation = 0
i = 0
while i < numColors
	puts "What is yarn # #{i+1}'s color?"
	print prompt
	colorName = $stdin.gets.chomp
	
	puts "What percent of the yarn will be #{colorName}?"
	puts "For example, if 25% of the yarn will be #{colorName}, enter 25"
	print prompt
	percentOfColor = $stdin.gets.chomp.to_f / 100
	percentageValidation = percentageValidation + percentOfColor
	
	puts "What is the depth of shade you want?"
	puts "For example, for a 1% DOS, enter 1. For a 0.5% DOS, enter 0.5"
	print prompt
	percentDepthOfShade = $stdin.gets.chomp.to_f
	
	puts "What is the dye stock's strength?"
	puts "For example, if the dye stock is 1%, enter 1. If it is 0.5%, enter 0.5"
	print prompt
	percentDyeStock = $stdin.gets.chomp.to_f
	
	dyeVolume = ((percentOfColor * weightDry) * percentDepthOfShade) / percentDyeStock
	carryingCapacity = percentOfColor * totalCapacity
	waterNeeded = carryingCapacity - dyeVolume
	
	colorData = ColorData.new(colorName, percentOfColor, percentDepthOfShade, percentDyeStock, dyeVolume, carryingCapacity, waterNeeded)
	colorDataArray.push(colorData)
	
	i += 1
end

if percentageValidation == 1
	i = 0
	while i < numColors
		puts "For #{colorDataArray[i][:colorName]}, add #{colorDataArray[i][:waterNeeded]} mL of water to #{colorDataArray[i][:dyeVolume]} mL of #{colorDataArray[i][:percentDyeStock]}% dye stock"
		i += 1
	end
else
	puts "The percentage of colors is not 100%"
end

puts "Press enter to exit."
gets.chomp