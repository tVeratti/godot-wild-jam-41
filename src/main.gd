extends Node2D


onready var _player = $player
onready var _map = $map


const MAX_TURNS = 10

var current_turn:int = 1

func _ready():
	_player.connect("navigate", self, "_on_navigate")
	_player.connect("movement_complete", self, "_on_player_movement_complete")


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		end_turn()


func end_turn():
	# TODO: Manage movement phases better
	# StateMachine?
	
	# 1. Process player movement
	_player.move_along_path()
	
	# 2. Process coin movement
	# 3. Process enemy movement


func reset():
	current_turn = 1


func _on_navigate(origin, destination):
	var path = _map.get_astar_path(origin, destination)
	_player.path = path


func _on_player_movement_complete():
	current_turn += 1
	if current_turn > MAX_TURNS:
		print("end of game!")
