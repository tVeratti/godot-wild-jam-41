extends Node


class_name CoinService

signal coin_collected()

const CoinScene = preload("res://coin/coin.tscn")



var rng = RandomNumberGenerator.new()



func spawn_coin(position):
	var new_coin = CoinScene.instance()
	add_child(new_coin)
	
	new_coin.position = position + Vector2(50, 50)
	new_coin.connect("collected", self, "_on_coin_collected")
	
	return new_coin


func move_coins():
	for coin in get_children():
		coin.move_along_path()


func _on_coin_collected():
	emit_signal("coin_collected")
