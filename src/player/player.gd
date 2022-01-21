extends Node

signal navigate(origin, destination)


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var player_position = Vector2(150, 150) # TEMP
		emit_signal("navigate", player_position, event.position)
