extends KinematicBody

var rng = RandomNumberGenerator.new()
var velocity = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
#	rng.randomize()
#	velocity = rng.randf_range(0.1, 0.3)
	pass

func warp_in():
	var warp_velocity = 350.0
	var time = 50.0 / warp_velocity
	$Tween.interpolate_property(self, "translation/:z", self.translation.z + 50.0,
								self.translation.z, time)
	$Tween.start()
	yield(get_tree().create_timer(0.1), "timeout")
	self.visible = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.translation.z -= velocity * delta


func _on_Tween_tween_completed(object, key):
	pass
