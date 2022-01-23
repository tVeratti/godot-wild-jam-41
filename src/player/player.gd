extends KinematicBody2D


signal navigate(origin, destination)
signal movement_complete()

const MOVE_SPEED = 100


var path:Array = []

var velocity:Vector2 = Vector2.ZERO
var target_position:Vector2 = Vector2.ZERO


func _physics_process(delta):
	if target_position.distance_to(position) > 5:
		velocity = position.direction_to(target_position).normalized() * MOVE_SPEED
		move_and_slide(velocity)
	else:
		emit_signal("movement_complete")
		set_physics_process(false)


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("navigate", position, event.position)


func move_along_path():
	if path.empty():
		set_physics_process(false)
	else:
		set_physics_process(true)
		target_position = path.pop_front()
	
