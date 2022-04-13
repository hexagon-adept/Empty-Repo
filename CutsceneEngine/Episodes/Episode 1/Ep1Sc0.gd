extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var waypoint = get_node("Waypoints/Waypoint")
onready var Ship = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	for node in $Ships.get_children():
		Ship[node.name] = node
		node.visible = false
	
	SceneChanger.fade_in()
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	Ship["LandianBeacon"].warp_in()
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	for ship in Ship.values():
		if ship.name != "LandianBeacon":
			ship.warp_in()
		var rng1 = RandomNumberGenerator.new()
		rng1.randomize()
		yield(get_tree().create_timer(rng1.randf_range(0.1, 0.3)), "timeout")

#func _process(delta):
#	pass
