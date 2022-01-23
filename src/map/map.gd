extends Node2D

signal map_clicked(position)


export(int) var max_x:int = 10
export(int) var max_y:int = 10

onready var _map:TileMap = $TileMap
onready var _a_star:AStar2D = AStar2D.new()
onready var _tiles:Array = []


func _ready():
	generate_tiles()
	add_points()
	connect_points()


func generate_tiles():
	_map.clear()
	_a_star.clear()
	
	for x in range(max_x):
		for y in range(max_y):
			_map.set_cell(x, y, 0)
	
	_tiles = _map.get_used_cells()


func add_points():
	for tile in _tiles:
		var tile_id = get_tile_id(tile)
		_a_star.add_point(tile_id, tile, 1.0)


func connect_points():
	var adjacent_tiles = [
		Vector2.UP,
		Vector2.LEFT,
		Vector2.RIGHT,
		Vector2.DOWN
	]
	
	for tile in _tiles:
		var tile_id = get_tile_id(tile)
		for offset in adjacent_tiles:
			var adjacent_tile = tile + offset
			var adjacent_id = get_tile_id(adjacent_tile)
			if _tiles.has(adjacent_tile):
				_a_star.connect_points(tile_id, adjacent_id)


func get_astar_path(world_start:Vector2, world_end:Vector2):
	var start = _map.world_to_map(world_start)
	var end = _map.world_to_map(world_end)
	
	var start_id = get_tile_id(start)
	var end_id = get_tile_id(end)
	
	var cell_offset = _map.cell_size / 2
	
	var path = []
	var coord_path = _a_star.get_point_path(start_id, end_id)
	coord_path.remove(0)
	for coord in coord_path:
		path.append(_map.map_to_world(coord) + cell_offset)
	
	return path


func map_to_world(position): return _map.map_to_world(position)


func get_tile_id(tile:Vector2):
	return (tile.x + tile.y) * (tile.x + tile.y + 1) / 2 + tile.y


func _on_ClickArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("map_clicked", get_local_mouse_position())
