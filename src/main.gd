extends Node2D


onready var _player = $player
onready var _map = $map


func _ready():
	_player.connect("navigate", _map, "_on_navigate")
