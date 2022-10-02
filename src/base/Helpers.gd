extends Node2D

class_name EnemySpawner

var map_node

var build_mode = false
var build_valid = false
var build_tile
var build_location
var build_type
var current_wave = 0
var enemies_in_wave = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_node = get_node_or_null("GameMap")
	if map_node == null:
		map_node = self
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", self, "initiate_build_mode", [i.get_name()])
	start_next_wave()


func _process(_delta: float) -> void:
	if build_mode:
		update_tower_preview()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

	
func initiate_build_mode(tower_type: String) -> void:
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "1"
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())


func update_tower_preview() -> void:
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").world_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_world(current_tile)
	
	if map_node.get_node("TowerExclusion").get_cellv(current_tile) == -1:
		get_node("UI").update_tower_preview(tile_position, "ca3aa100")
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		get_node("UI").update_tower_preview(tile_position, "ccf02222")
		build_valid = false

	
func cancel_build_mode() -> void:
	build_mode = false
	build_valid = false
	get_node("UI/TowerPreview").queue_free()

	
func verify_and_build() -> void:
	if build_valid:
		# Check player has enough gold
		var new_tower = load("res://src/towers/" + build_type + ".tscn").instance()
		new_tower.position = build_location
		map_node.get_node("Turrets").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cellv(build_tile, 4)
		# deduct gold
		# update gold

func start_next_wave() -> void:
	var wave_data = retrieve_wave_data()
	yield(get_tree().create_timer(0.2),"timeout")
	spawn_enemies(wave_data)
	
func retrieve_wave_data():
	var wave_data = [["Enemy", 0.7], ["Enemy", 0.1]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data
	
func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://src/enemies/" + i[0] + ".tscn").instance()
		print(map_node)
		map_node.get_node("Path").add_child(new_enemy, true)
		yield(get_tree().create_timer(i[1]),"timeout")
