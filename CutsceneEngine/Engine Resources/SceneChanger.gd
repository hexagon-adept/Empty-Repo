extends Control
signal fadeComplete
signal sceneChanged

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func fade_in():
	
	$AnimationPlayer.play_backwards("Fade Out")
	yield($AnimationPlayer, "animation_finished")
	
func fade_out():
	
	$AnimationPlayer.play("Fade Out")
	yield($AnimationPlayer, "animation_finished")
	
func change_scene(path):
	fade_out()
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene(path)
	fade_in()
	yield($AnimationPlayer, "animation_finished")
	emit_signal("sceneChanged")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fadeComplete")
	$AnimatedSprite/AnimationPlayer.stop(true)
