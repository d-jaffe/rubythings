#!/usr/local/bin/ruby
require 'colorize'
require 'ordinalize'

prompt = '> '
ColorData = Struct.new(:colorName, :percentOfColor, :percentDepthOfShade, :percentDyeStock, :dyeVolume, :carryingCapacity, :waterNeeded)

puts "What is the dry weight in grams?".cyan
print prompt
weightDry = Integer($stdin.gets.chomp)

puts "What is the damp weight in grams?".cyan
print prompt
weightDamp = Integer($stdin.gets.chomp)

puts "What is the saturated weight in grams?".cyan
print prompt
weightSaturated = Integer($stdin.gets.chomp)

totalCapacity = weightSaturated - weightDamp

puts "How many colors are you using?".cyan
print prompt
numColors = Integer($stdin.gets.chomp)

colorDataArray = Array.new
percentageValidation = 0
i = 0
while i < numColors
	puts "What is the #{(Integer(i+1)).ordinalize} color?".cyan
	print prompt
	colorName = $stdin.gets.chomp
	
	puts "What percent of the yarn will be #{colorName}?".cyan
	puts "For example, if 25% of the yarn will be #{colorName}, enter 25".cyan
	print prompt
	percentOfColor = $stdin.gets.chomp.to_f / 100
	percentageValidation = percentageValidation + percentOfColor
	
	puts "What is the depth of shade you want?".cyan
	puts "For example, for a 1% DOS, enter 1. For a 0.5% DOS, enter 0.5".cyan
	print prompt
	percentDepthOfShade = $stdin.gets.chomp.to_f
	
	puts "What is the dye stock's strength?".cyan
	puts "For example, if the dye stock is 1%, enter 1. If it is 0.5%, enter 0.5".cyan
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