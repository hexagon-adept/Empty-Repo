extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var co

# Called when the node enters the scene tree for the first time.
func _ready():
	co = play_scene()
	
func play_scene():
	for i in range(0,5):
		print("Line " + str(i))
		yield()
	print("Done!")

func continue_scene():
	if co is GDScriptFunctionState && co.is_valid():
		co = co.resume();

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		continue_scene()
