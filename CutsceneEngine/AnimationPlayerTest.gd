extends AnimationPlayer

var q = []

# Called when the node enters the scene tree for the first time.
func _ready():
	self.queue("test1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		
