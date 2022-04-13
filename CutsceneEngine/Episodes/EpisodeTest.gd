extends Spatial

# Initialize Helper Nodes
onready var DialoguePlayer = get_node("DialoguePlayer")
onready var Nav = get_node("Navigation")
onready var Cam = get_node("Camera")
var Waypoint = []
var Campoint = []

# Initialize Actors
onready var Pearl = get_node("Actors/Pearl")
# onready var Adjutant4 = get_node("Actors/Adjutant4")
onready var Adjutant4 = get_node("Actors/Adjutant4")
onready var Area_ = get_node("Actors/Area")
onready var Ragna = get_node("Actors/Ragna")

# Called when the node enters the scene tree for the first time.
func _ready():
	# More Initialization
	for node in $Waypoints.get_children():
		Waypoint.push_back(node)
	for node in $Campoints.get_children():
		Campoint.push_back(node)
	
	DialoguePlayer.visible = false
	
	# Connect Signals
	DialoguePlayer.connect("sceneComplete", self, "onSceneComplete")
	for node in $Actors.get_children():
		node.connect("moveComplete", self, "onMoveComplete")
	Cam.connect("panComplete", self, "onPanComplete")
		
	# CHOREOGRAPHY
	
#	Cam.pan_to(Pearl)
#	yield(Cam, "panComplete")
#	yield(get_tree().create_timer(1.0), "timeout")
#	Pearl.step("down")
#	yield(Pearl, "moveComplete")
#	yield(get_tree().create_timer(1.0), "timeout")
#	Cam.pan_to(Adjutant4)
#	yield(Cam, "panComplete")
#	yield(get_tree().create_timer(1.0), "timeout")
#	Cam.pan_to(Area_)
#	yield(Cam, "panComplete")
#	yield(get_tree().create_timer(1.0), "timeout")
#	Cam.pan_to(Campoint[0])
#	yield(Cam, "panComplete")
#	yield(get_tree().create_timer(1.0), "timeout")
#	Cam.zoom_in(1.3)
#	yield(Cam, "zoomComplete")
#	yield(get_tree().create_timer(1.0), "timeout")
#	Cam.zoom_out(1.3)
#	yield(Cam, "zoomComplete")
#	yield(get_tree().create_timer(1.0), "timeout")
	
#	SceneChanger.fade_in()
#	yield(get_tree().create_timer(1.0), "timeout")
#	Cam.shake()
#	yield(Cam, "shakeComplete")
#	yield(get_tree().create_timer(1.0), "timeout")

#	DialoguePlayer.play_scene("2 The Board calls in")
#	Cam.shake()
	SceneChanger.fade_in()
	var track1 = [track1_a(), track1_b(), track1_c()]
	yield(track1[1], "completed")

	yield(get_tree().create_timer(1.0), "timeout")
	Cam.pan_to(Area_)
	yield(Cam, "panComplete")
	
	Cam.pan_to(Adjutant4)
	yield(Cam, "panComplete")
	Ragna.move_to(Waypoint[0], Nav)
	yield(Ragna, "moveComplete")
	Cam.pan_to(Ragna)
	yield(Cam, "panComplete")
	yield(get_tree().create_timer(1.0), "timeout")
	Cam.pan_to(Adjutant4)
	yield(Cam, "panComplete")

	yield(get_tree().create_timer(1.0), "timeout")
	DialoguePlayer.play_scene("2 The Board calls in")
#   _________________________________________________________
	
#	yield(get_tree().create_timer(2.0), "timeout")
#	Pearl.move_to(Waypoint[0], Nav, true)
#	yield(get_tree().create_timer(1.0), "timeout")
#	Adjutant4.move_to(Waypoint[3], Nav)
#	yield(Adjutant4, "moveComplete")
#	Adjutant4.face_right()
#	yield(Pearl, "moveComplete")
#	Pearl.move_to(Waypoint[1], Nav, true)
#	yield(Pearl, "moveComplete")
#	Pearl.move_to(Waypoint[2], Nav)
#	yield(Pearl, "moveComplete")
#	yield(get_tree().create_timer(1.0), "timeout")
#	DialoguePlayer.play_scene("2 The Board calls in")
#	yield(DialoguePlayer, "sceneComplete")

	#$DialoguePlayer.play_scene("2 The Board calls in")
	#yield(DialoguePlayer, "sceneComplete")
	#$DialoguePlayer.play_scene("3 Pearl tries to convince Ragna to cooperate")
	
func track1_a():
	Pearl.move_to(Waypoint[0], Nav, true) #move Pearl to Waypoint 0
	yield(Pearl, "moveComplete") #wait for Pearl to finish moving
	Pearl.move_to(Waypoint[1], Nav) #move Pearl to Waypoint 1
	yield(Pearl, "moveComplete") #wait for Pearl to finish moving
	yield(get_tree().create_timer(0.5), "timeout")
	Pearl.move_to(Waypoint[2], Nav) #move Pearl to Waypoint 2
	yield(Pearl, "moveComplete") #wait for Pearl to finish moving
	
func track1_b():
	yield(get_tree().create_timer(1.0), "timeout")
	Adjutant4.move_to(Waypoint[0], Nav) #move Adjutant4 to Waypoint 3
	yield(Adjutant4, "moveComplete")
	yield(get_tree().create_timer(1.0), "timeout")
	Adjutant4.face_right()
	yield(get_tree().create_timer(7.0), "timeout")
	Adjutant4.move_to(Waypoint[3], Nav) #move Adjutant4 to Waypoint 3
	yield(Adjutant4, "moveComplete")
	Adjutant4.face_right()
	
func track1_c():
#	for i in range(0,8):
#		Area_.face_right()
#		yield(get_tree().create_timer(0.5), "timeout")
#		Area_.face_left()
#		yield(get_tree().create_timer(0.5), "timeout")
		
	Area_.move_to(Waypoint[4], Nav) #move Area_ to Waypoint 2
	yield(Area_, "moveComplete")

func play_all_scenes():
	for key in $DialoguePlayer.scenes.keys():
		$DialoguePlayer.play_scene(key)
		yield(DialoguePlayer, "sceneComplete")

func onSceneComplete():
	pass
	
func onMoveComplete():
	pass
	
func onPanComplete():
	pass

func onFadeComplete():
	pass
