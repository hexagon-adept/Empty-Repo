extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	load_chapter("Text/Ch1.txt")

#	for key in scenes:
#		var lines = scenes[key]
#		print("\n" + key + "\n")
#		for line in lines:
#			print(line)
#		print("_______________")
#
#	for key in portraits:
#		var images = portraits[key]
#		print("\n" + key + "\n")
#		for image in images:
#			print(image)
#		print("_______________")

func toFilename(x):
	return x + ".png"

func load_chapter(filename):
	
	var scenes = {}

	var portraits = {}
	
	var names = {}
	
	# Accumulator array containing lines of dialogue for a single text file, 
	# where each index corresponds to a line number
	var dialogueArray = []
	
	# Accumulator array of portraits.png, where each index corresponds to a line
	# of dialogue
	var portraitArray = []
	
	# Accumulator array of character names corresponding to each line of
	# dialogue.
	var nameArray = []
	
	var f = File.new()
	f.open(filename, 1)
	
	var sceneName = f.get_line()
	
	while not f.eof_reached():
		var line = f.get_line()
		var isComment = line.begins_with("(")
		var isChoreo = line.begins_with("[")
		var isNewline = line == ""
		var isSceneHeader = (line.find(":", 0) == -1 and line.find("<", 0) == -1
							and line.find(">", 0) == -1 and not isNewline
							and not isComment and not isChoreo)
		
		# v COMMENT OUT THIS SECTION BELOW TO SKIP CHOREOGRAPHY NOTES v
#		if isChoreo:
#			dialogueArray.push_back(line)
#			portraitArray.push_back("Empty.png")
#			nameArray.push_back("")
#			continue
		# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		
		if isSceneHeader:
			print("header found")
			# Push results to the scene/portrait/name dictionaries
			scenes[sceneName] = dialogueArray.duplicate(true)
			portraits[sceneName] = portraitArray.duplicate(true)
			names[sceneName] = nameArray.duplicate(true)
			
			# Reset the accumulator arrays
			sceneName = line
			dialogueArray = []
			portraitArray = []
			nameArray = []
		
		elif not isNewline and not isComment and not isChoreo:
			var portraitStart = line.find("<")
			var portraitEnd = line.find(">")
			var line1 = line.substr(0, line.left(portraitStart).length())
			var line2 = line1.replace("[", "{!").replace("]", "!}")
			var line3 = line2.replace("{!", "[color=red]").replace("!}", "[/color]")
			
			var sub = line.substr(portraitStart, portraitEnd - portraitStart)
			var sub1 = sub.replace("<", "").replace(">", "")
			var sub2 = toFilename(sub1)
			
			var colonPos = line3.find(":")
			var name1 = line3.substr(0, line3.left(colonPos).length())
			var line4 = line3.trim_prefix(name1 + ": ")
			
			# Turning PEARL into Pearl
			var firstLetter = name1.substr(0, 1)
			var name2 = firstLetter + name1.substr(1, -1).to_lower()
			
			dialogueArray.push_back(line4)
			portraitArray.push_back(sub2)
			nameArray.push_back(name2)
			print(line3)
	f.close()
	
	# Push results of last line to the scene/portrait/name dictionaries
	scenes[sceneName] = dialogueArray
	portraits[sceneName] = portraitArray
	names[sceneName] = nameArray
	
	return [scenes, portraits, names]
