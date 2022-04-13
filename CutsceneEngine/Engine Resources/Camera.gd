extends Camera

signal xPanComplete
signal yPanComplete
signal zPanComplete
signal panComplete
signal zoomComplete
signal shakeComplete

# Camera offsets
var y_offset = 3.285
var z_offset = 9.171

# Speeds
var slow = 1.0
var medium = 2.5
var fast = 5.0

# Camera shake variables
var shake_active = false
var shake_in_progress = false
var shake_amount = 0.1
var shake_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	if shake_active:
		self.h_offset = rand_range(-1.0, 1.0) * shake_amount
		self.v_offset = rand_range(-1.0, 1.0) * shake_amount

func pan_to(node, mode = "medium", speed = 0):
	var time = 2.0
	var startpoint = self.transform.origin
	var endpoint = Vector3(node.transform.origin.x,
							node.transform.origin.y + y_offset,
							node.transform.origin.z + z_offset)
	var distance = startpoint.distance_to(endpoint)
	
	match mode:
		"slow":
			time = distance / slow
		"medium":
			time = distance / medium
		"fast":
			time = distance / fast
		"instant":
			time = 0
		"manual":
			time = distance / speed
			
	pan_to_x(node, time)
	pan_to_y(node, time)
	pan_to_z(node, time)

func pan_to_x(node, time = 2.0):
	$Tween.interpolate_property(self, "translation/:x", transform.origin.x,
								node.transform.origin.x, time)
	$Tween.start()

func pan_to_y(node, time = 2.0):
	$Tween.interpolate_property(self, "translation/:y", transform.origin.y,
								node.transform.origin.y + y_offset, time)
	$Tween.start()
	
func pan_to_z(node, time = 2.0):
	$Tween.interpolate_property(self, "translation/:z", transform.origin.z,
								node.transform.origin.z + z_offset, time)
	$Tween.start()

func zoom_in(multiplier, time = 2.0):
	$Tween.interpolate_property(self, "fov", self.fov, self.fov / multiplier, time)
	$Tween.start()

func zoom_out(multiplier, time = 2.0):
	$Tween.interpolate_property(self, "fov", self.fov, self.fov * multiplier, time)
	$Tween.start()
	
func shake(time = 4.0):
	shake_active = true
	shake_in_progress = true
	shake_time = time
	shake_amount = 0.1
	$Tween.interpolate_property(self, "shake_amount", 0, shake_amount, time / 2, Tween.EASE_IN)
	$Tween.start()
	

func _on_Tween_tween_completed(object, key):
	if key == ":translation/:x":
		emit_signal("xPanComplete")
	elif key == ":translation/:y":
		emit_signal("yPanComplete")
	elif key == ":translation/:z":
		emit_signal("zPanComplete")
	elif key == ":fov":
		emit_signal("zoomComplete")
	elif key == ":shake_amount":
		if shake_in_progress:
			shake_in_progress = false
			$Tween.interpolate_property(self, "shake_amount", shake_amount, 0, shake_time / 2, Tween.EASE_OUT)
			$Tween.start()
		else:
			emit_signal("shakeComplete")
			shake_active = false

func _on_Tween_tween_all_completed():
	emit_signal("panComplete")
