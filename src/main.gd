extends Node2D

const MAX_TURNS = 10

var _rng:RandomNumberGenerator = RandomNumberGenerator.new()

var current_turn:int = 1
var current_score:int = 0

onready var _player = $player
onready var _map = $map
onready var _coins = $CoinService


func _ready():
	_rng.randomize()
	
	_map.connect("map_clicked", self, "_on_map_clicked")
	_player.connect("navigate", self, "_on_navigate")
	_player.connect("movement_complete", self, "_on_player_movement_complete")
	_coins.connect("coin_collected", self, "_on_coin_collected")


func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		end_turn()


func end_turn():
	# TODO: Manage movement phases better
	# StateMachine?
	
	# 1. Process player movement
	_player.move_along_path()
	
	# 2. Process coin movement
	spawn_coin()
	
	# 3. Process enemy movement


func spawn_coin():
	var random_x = _rng.randi_range(1, _map.max_x - 1)
	var coin_position = _map.map_to_world(Vector2(random_x, 0))
	
	var coin = _coins.spawn_coin(coin_position)
	var coin_destination = Vector2(coin_position.x, 400)
	coin.path = _map.get_astar_path(coin_position, coin_destination)


func reset():
	current_turn = 1
	current_score = 0


func _on_map_clicked(origin):
	var path = _map.get_astar_path(_player.position, origin)
	_player.path = path


func _on_navigate(origin, destination):
	var path = _map.get_astar_path(origin, destination)
	_player.path = path


func _on_player_movement_complete():
	_coins.move_coins()
	
	current_turn += 1
	if current_turn > MAX_TURNS:
		print("end of game!")


func _on_coin_collected():
	current_score += 1
