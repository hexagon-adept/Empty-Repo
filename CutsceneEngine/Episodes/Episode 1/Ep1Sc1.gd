extends Spatial

# Initialize Helper Nodes
onready var DialoguePlayer = get_node("DialoguePlayer")
onready var Nav = get_node("Navigation")
onready var Cam = get_node("Cam")
var Waypoint = []

# Initialize Actors
onready var Baron = get_node("Actors/Baron")
onready var LandianM = get_node("Actors/LandianM")
onready var Knight = get_node("Actors/Knight")

# Called when the node enters the scene tree for the first time.
func _ready():
	# More Initialization
	for node in $Waypoints.get_children():
		Waypoint.push_back(node)
	
	# Connect Signals
	DialoguePlayer.connect("sceneComplete", self, "onSceneComplete")
	for node in $Actors.get_children():
		node.connect("moveComplete", self, "onMoveComplete")
	Cam.connect("panComplete", self, "onPanComplete")
	
	# CHOREOGRAPHY
	
	Cam.pan_to(Baron, "instant")
	SceneChanger.fade_in()
	yield(get_tree().create_timer(1.0), "timeout")
	LandianM.move_to(Waypoint[0], Nav)
	yield(LandianM, "moveComplete")
	yield(get_tree().create_timer(1.0), "timeout")
	DialoguePlayer.play_scene("1.1")
	yield(DialoguePlayer, "sceneComplete")
	yield(get_tree().create_timer(1.0), "timeout")
	SceneChanger.change_scene("res://Episodes/Episode 1/Ep1Sc2.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func onSceneComplete():
	pass
	
func onMoveComplete():
	pass
	
func onPanComplete():
	pass

func onFadeComplete():
	pass
