extends Actor

signal navigate()


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		print(position)
		pass
#		emit_signal("navigate", position, event.position)

