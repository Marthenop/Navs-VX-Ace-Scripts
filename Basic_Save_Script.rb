#Okay then, this script is meant to be paired with a titlescreen skip and an event that calls the load function ("Csave.load") if the event detects a save file.
#I'm not going to go over how to do that, if you're even trying to use this script from a nobody, then you should really just learn how to do some advanced eventing. (Also a tiny bit of Ruby code, it's really not that hard.)
#This script is also so fucking simple that I'm not going to be upset if you use this without credit, though why would you even want to use this? (Though credit is always appreciated, seeing as I do these wacky experiments for fun.)

module Csave
	
	def self.sdata
	contents = {}
	contents[:vars] = $game_variables #Wish that the game variables object name didn't show up in the save, but unless I rewrite a lot of fundamental shit I just have to stomach it.
	contents[:pos] = [$game_map.map_id,$game_player.x,$game_player.y,$game_player.direction] #Technically didn't need to make this part, but I wanted to plan for the future.
	contents
	end
	
	def self.ldata(contents)
	$game_variables = contents[:vars]
	$game_variables[0] = contents[:pos] #This just works apparently. Wanted to use a custom var, but it errored. And I use zero as unless the person using this script is doing some wackass scripting, temp loading the position data to this variable will never conflict.
	end

	def self.save
		File.open("Saves/Save01.rvdata2", "wb") do |file|
		Marshal.dump(data, file) #Marshal is what Ace already uses for saves and other general game data, and because it obfuscates it for 99% of people it's a lot cleaner than the v1 script.
		end
	end
	
	def self.load
		File.open("Saves/Save01.rvdata2", "r") do |file|
		ldata(Marshal.load(file))
		$game_player.reserve_transfer(*$game_variables[0]) #The star in this case is called a splat, and it uses all the elements in the array so we can just load all that juicy data nicely.
		end
		$game_variables[0] = 0 #Need to remember to reset it, just in case anyone using this script actually writes code and needs this variable after loading... So only myself.
	end
end