extends Node

var path:PoolVector2Array = []

onready var _map:TileMap = $TileMap
onready var _a_star:AStar2D = AStar2D.new()
onready var _tiles:Array = _map.get_used_cells()


func _ready():
	add_points()
	connect_points()


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
	
	path = _a_star.get_point_path(start_id, end_id)
	return path


func get_tile_id(tile:Vector2):
	return (tile.x + tile.y) * (tile.x + tile.y + 1) / 2 + tile.y


func _on_navigate(origin, destination):
	print(get_astar_path(origin, destination).size())

