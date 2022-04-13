extends KinematicBody
signal moveComplete

var path = []
var path_ind = 0
var move_speed = 1.5
var continuous
var move_to_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite3D.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if move_to_active:
		if path_ind < path.size():
			var move_vec = (path[path_ind] - global_transform.origin)
			if move_vec.length() < 0.1:
				path_ind += 1
				if $AnimatedSprite3D.animation != "Walking":
					$AnimatedSprite3D.play("Walking")
			else:
				move_and_slide(move_vec.normalized() * move_speed, Vector3(0,1,0))
				
		if path_ind == path.size():
			if not continuous:
				$AnimatedSprite3D.play("Idle")
			move_to_active = false
			emit_signal("moveComplete")

func move_to(waypoint, nav, cont = false):
	move_to_active = true
	continuous = cont
	path = nav.get_simple_path(global_transform.origin, waypoint.global_transform.origin)
	path_ind = 0
	if waypoint.global_transform.origin.x - global_transform.origin.x > 0:
		face_right()
	else:
		face_left()
		
func step(direction):
	var distance = 1.0
	var time = distance/move_speed
	match direction:
		"up":
			$Tween.interpolate_property(self, "translation/:z", transform.origin.z,
								transform.origin.z - distance, time)
		"down":
			$Tween.interpolate_property(self, "translation/:z", transform.origin.z,
								transform.origin.z + distance, time)
		"left":
			$Tween.interpolate_property(self, "translation/:x", transform.origin.x,
								transform.origin.x - distance, time)
			face_left()
		"right":
			$Tween.interpolate_property(self, "translation/:x", transform.origin.x,
								transform.origin.x + distance, time)
			face_right()
	
	$AnimatedSprite3D.play("Walking")
	$Tween.start()
	
func step_backwards(direction):
	var distance = 1.0
	var time = distance/move_speed
	match direction:
		"up":
			$Tween.interpolate_property(self, "translation/:z", transform.origin.z,
								transform.origin.z - distance, time)
		"down":
			$Tween.interpolate_property(self, "translation/:z", transform.origin.z,
								transform.origin.z + distance, time)
		"left":
			$Tween.interpolate_property(self, "translation/:x", transform.origin.x,
								transform.origin.x - distance, time)
			face_right()
		"right":
			$Tween.interpolate_property(self, "translation/:x", transform.origin.x,
								transform.origin.x + distance, time)
			face_left()
	
	$AnimatedSprite3D.play("Walking_Reverse")
	$Tween.start()
	
func appear_at(node):
	self.transform.origin.x = node.transform.origin.x
	self.transform.origin.z = node.transform.origin.z

func face_right():
	$AnimatedSprite3D.set_flip_h(true)
	
func face_left():
	$AnimatedSprite3D.set_flip_h(false)

func _on_Tween_tween_completed(object, key):
	$AnimatedSprite3D.play("Idle")
	emit_signal("moveComplete")
