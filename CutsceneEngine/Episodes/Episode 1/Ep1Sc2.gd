extends Spatial

# Initialize Helper Nodes
onready var DialoguePlayer = get_node("DialoguePlayer")
onready var Nav = get_node("Navigation")
onready var Cam = get_node("Cam")
var Waypoint = []
#var Campoint = []

# Initialize Actors
# Template: onready var Pearl = get_node("Actors/Pearl")
onready var Pearl = get_node("Actors/Pearl")
onready var Ragna = get_node("Actors/Ragna")
onready var Area_ = get_node("Actors/Area")

# Called when the node enters the scene tree for the first time.
func _ready():
	# More Initialization
	for node in $Waypoints.get_children():
		Waypoint.push_back(node)
#	for node in $Campoints.get_children():
#		Campoint.push_back(node)

	# Connect Signals
	DialoguePlayer.connect("sceneComplete", self, "onSceneComplete")
	for node in $Actors.get_children():
		node.connect("moveComplete", self, "onMoveComplete")
	Cam.connect("panComplete", self, "onPanComplete")
	Cam.connect("shakeComplete", self, "onShakeComplete")

	# /////////////////////////// CHOREOGRAPHY ///////////////////////////
	
	SceneChanger.fade_in()
	Pearl.face_right()
	Ragna.face_right()
	Area_.face_right()
	Cam.pan_to(Pearl, "instant")
	
	yield(get_tree().create_timer(2.0), "timeout")

	DialoguePlayer.play_scene("1.2")
	yield(DialoguePlayer, "sceneComplete")

	Cam.shake()
	yield(Cam, "shakeComplete")
	yield(get_tree().create_timer(1.0), "timeout")

#	SceneChanger.fade_out()
#	yield(get_tree().create_timer(2.0), "timeout")
#	SceneChanger.fade_in()
#	yield(get_tree().create_timer(3.0), "timeout")
	
	Ragna.move_to(Waypoint[0], Nav)
	yield(Ragna, "moveComplete")
	yield(get_tree().create_timer(1.0), "timeout")
	
	Cam.pan_to(Ragna)
	yield(Cam, "panComplete")
	yield(get_tree().create_timer(1.0), "timeout")
	
	DialoguePlayer.play_scene("1.3")
	yield(DialoguePlayer, "sceneComplete")
	
	yield(get_tree().create_timer(1.0), "timeout")
	Pearl.face_left()
	yield(get_tree().create_timer(1.0), "timeout")
	
	DialoguePlayer.play_scene("1.4")
	yield(DialoguePlayer, "sceneComplete")
	yield(get_tree().create_timer(1.0), "timeout")
	
	Pearl.face_right()
	yield(get_tree().create_timer(1.0), "timeout")
	DialoguePlayer.play_scene("1.5")
	yield(DialoguePlayer, "sceneComplete")
	
	Ragna.step("left")
	DialoguePlayer.play_scene("1.6")
	yield(DialoguePlayer, "sceneComplete")
	yield(get_tree().create_timer(1.0), "timeout")
	
	Area_.move_to(Waypoint[1], Nav)
	yield(Area_, "moveComplete")
	yield(get_tree().create_timer(1.0), "timeout")
	
	DialoguePlayer.play_scene("1.7")
	yield(DialoguePlayer, "sceneComplete")
	Pearl.face_left()
	yield(get_tree().create_timer(1.0), "timeout")
	DialoguePlayer.play_scene("1.8")
	yield(DialoguePlayer, "sceneComplete")
	
	# ////////////////////////////////////////////////////////////////////

func onSceneComplete():
	pass
	
func onMoveComplete():
	pass
	
func onPanComplete():
	pass

func onFadeComplete():
	pass

func onShakeComplete():
	pass
