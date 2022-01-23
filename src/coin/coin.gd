extends Actor


signal collected(coin)


func _on_Area2D_body_entered(body):
	if body.name == "player":
		emit_signal("collected")
		queue_free()
