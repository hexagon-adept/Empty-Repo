extends Control
signal sceneComplete

var scene = []
var scenes = {}
var portraitFile = []
var portraits = {}
var nameFile = []
var names = {}

var nameToColor = {
	"Pearl" : "GreenRibbon.png",
	"Area" : "CyanRibbon.png",
	"Ragna" : "PurpleRibbon.png",
	"Crew" : "RedRibbon.png",
	"Baron" : "RedRibbon.png",
	"Augustine" : "GreenRibbon.png",
	"Adjutant" : "GreenRibbon.png",
	"Soldier" : "WhiteRibbon.png",
	"Captain" : "WhiteRibbon.png",
	"" : "Empty.png"
}

var sceneIndex = 0
var lineFinished = false
var sceneFinished = false

export var EpisodeToLoad = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	var result = global.load_chapter("Text/" + EpisodeToLoad + ".txt")
	scenes = result[0]
	portraits = result[1]
	names = result[2]
	
func play_scene(sceneName):
	self.visible = true
	scene = scenes[sceneName]
	portraitFile = portraits[sceneName]
	nameFile = names[sceneName]
	print("play_scene calls load_dialogue")
	load_dialogue()
	
func _process(delta):
	$DialogueBox.visible = not sceneFinished
	if Input.is_action_just_pressed("ui_accept") and not sceneFinished and lineFinished:
		load_dialogue()

func load_dialogue():
	print("sceneIndex: " + str(sceneIndex))
	print("Scene size: " + str(scene.size()))
	print("sceneFinished: " + str(sceneFinished))
	print("\n")
	if sceneIndex < scene.size():
		print("sceneIndex is less than scene size")
		lineFinished = false
		$DialogueBox/TextureRect/TextBox.bbcode_text = scene[sceneIndex]
		print("Display should be: " + scene[sceneIndex])
		$DialogueBox/TextureRect/TextBox.percent_visible = 0
		$DialogueBox/Tween.interpolate_property(
			$DialogueBox/TextureRect/TextBox, "percent_visible", 0, 1, scene[sceneIndex].length() * 0.02,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$DialogueBox/Tween.start()
		
		# Change Portrait
		$DialogueBox/Portrait.texture = load("res://Portraits/" + portraitFile[sceneIndex])
		
		# Change color of ribbon
		$DialogueBox/Ribbon.texture = load("res://DialogueBox/Ribbons/" + nameToColor[nameFile[sceneIndex]])
		
		# Change nametag
		$DialogueBox/Ribbon/NamePlate.bbcode_text = "[right]\n" + nameFile[sceneIndex] + "[/right]"
		
		
	if sceneIndex == scene.size():
		sceneFinished = true
		sceneIndex = 0
		emit_signal("sceneComplete")
		print("sceneIndex == scene size, reset scene index to 0\n")
	else:
		sceneFinished = false
		sceneIndex += 1
		print("sceneIndex != scene size, sceneIndex += 1\n")
		

func _on_Tween_tween_completed(object, key):
	lineFinished = true
