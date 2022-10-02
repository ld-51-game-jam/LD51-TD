extends Node2D

class_name LevelHandler

var map_node: Node
var build_mode: bool = false
var build_valid: bool = false
var build_tile: Vector2
var build_location: Vector2
var build_type: String
var current_wave: int = 0
var enemies_in_wave: int = 0
var wave_data: Array
var start: bool = false


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
	
	var max_waves: Label = get_tree().get_root().get_node_or_null("World/UI/HUD/InfoBar/MaxWave")
	var cont: bool = false
	if max_waves != null:
		if current_wave < int(max_waves.text):
			cont = true
		else:
			# load new level
			return
			
	if enemies_in_wave == 0 and start and cont:
		start_next_wave()
		start = false
	


func _unhandled_input(event: InputEvent) -> void:
	if get_tree().get_root().get_node_or_null("StartScene") != null:
		return
	var gold: Label = get_tree().get_root().get_node_or_null("World/UI/HUD/InfoBar/Gold")
	var gold_int: int = 0
	if gold != null:
		gold_int = int(gold.text)
		
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true and gold_int > 0:
		verify_and_build()
		cancel_build_mode()

	
func initiate_build_mode(tower_type: String) -> void:
	if build_mode:
		cancel_build_mode()
	build_type = tower_type + "1"
	build_mode = true
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())


func update_tower_preview() -> void:
	if get_tree().get_root().get_node_or_null("StartScene") != null:
		return
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").world_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_world(current_tile)
	var gold = get_tree().get_root().get_node_or_null("World/UI/HUD/InfoBar/Gold")
	var sufficient_funds = int(gold.text) >= GameData.tower_data[build_type].cost
	
	if map_node.get_node("TowerExclusion").get_cellv(current_tile) == -1 and sufficient_funds:
		get_node("UI").update_tower_preview(tile_position, "ca3aa100", sufficient_funds)
		build_valid = true
		build_location = tile_position
		build_tile = current_tile
	else:
		get_node("UI").update_tower_preview(tile_position, "ccf02222", sufficient_funds)
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
		new_tower.type = build_type
		new_tower.built = true
		map_node.get_node("Turrets").add_child(new_tower, true)
		map_node.get_node("Turrets").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cellv(build_tile, 4)
		var gold: Label = get_tree().get_root().get_node("World/UI/HUD/InfoBar/Gold")
		gold.text = String(int(gold.text) - GameData.tower_data[build_type].cost)


func start_next_wave() -> void:
	current_wave += 1
	yield(get_tree().create_timer(0.2),"timeout")
	spawn_enemies()
	var wave: Label = get_tree().get_root().get_node_or_null("World/UI/HUD/InfoBar/Wave")
	if wave != null:
		wave.text = String(current_wave)

	
func spawn_enemies() -> void:
	for i in wave_data:
		var new_enemy = load("res://src/enemies/" + i[0] + ".tscn").instance()
		map_node.get_node("Path").add_child(new_enemy, true)
		enemies_in_wave = enemies_in_wave + 1
		yield(get_tree().create_timer(i[1]),"timeout")
	start = true
