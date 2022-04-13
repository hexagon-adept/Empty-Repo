# Promise.gd
extends Node

func resolve(coroutine: GDScriptFunctionState):
	var valid_count = 0
	if coroutine.is_valid():
		valid_count += 1
		yield(coroutine, "completed")

	if valid_count == 0:
		yield(get_tree(), "idle_frame")


func all(coroutines: Array):
	var valid_count = 0
	print(coroutines)
	for coroutine in coroutines:
		if coroutine.is_valid():
			valid_count += 1
			yield(coroutine, "completed")
	
	if valid_count == 0:
		yield(get_tree(), "idle_frame")
