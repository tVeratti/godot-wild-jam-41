extends Node2D

class_name Actor

signal movement_complete()

const MOVE_SPEED = 10


var path:Array = []
var velocity:Vector2 = Vector2.ZERO
var target_position:Vector2 = Vector2.ZERO

func _ready():
	set_physics_process(false)


func _physics_process(delta):
	if target_position.distance_to(position) > 5:
		position = Vector2(
			lerp(position.x, target_position.x, MOVE_SPEED * delta),
			lerp(position.y, target_position.y, MOVE_SPEED * delta)
		)
	else:
		emit_signal("movement_complete")
		set_physics_process(false)


func move_along_path():
	if path.empty():
		set_physics_process(false)
	else:
		set_physics_process(true)
		target_position = path.pop_front()
	
