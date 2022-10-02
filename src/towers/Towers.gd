extends Node2D
class_name Tower
var type
var enemy_array = []
var built = false
var enemy
var ready = true
func _ready():
	if built:
		$Range/CollisionShape2D.get_shape().radius = 0.5 * GameData.tower_data[type].range
		
func _physics_process(_delta: float) -> void:
	if enemy_array.size() != 0 and built:
		select_enemy()
		turn()
		if ready:
			fire()
	else:
		enemy = null
	

func turn() -> void:
	if is_instance_valid(enemy):
		get_node("Turret").look_at(enemy.position)
	else:
		enemy_array.erase(enemy)
		enemy = null

func select_enemy() -> void:
	var enemy_progress_array = []
	for i in enemy_array:
		if is_instance_valid(i):
			enemy_progress_array.append(i.offset)
			var max_offset = enemy_progress_array.max()
			var enemy_index = enemy_progress_array.find(max_offset)
			enemy = enemy_array[enemy_index]
		else:
			enemy_array.erase(i)
			enemy = null
		
	
func fire() -> void:
	ready = false
	if is_instance_valid(enemy):
		if enemy.health > 0:
			var new_bullet = load("res://src/towers/" + GameData.tower_data[type].ammo + ".tscn").instance()
			new_bullet.enemy = enemy
			new_bullet.tower_type = type
			self.add_child(new_bullet, true)
			enemy.on_hit(GameData.tower_data[type]["damage"])
			yield(get_tree().create_timer(GameData.tower_data[type]["rof"]), "timeout")
	else:
		enemy_array.erase(enemy)
		enemy = null
	ready = true
	
	
func _on_Range_body_entered(body: Node) -> void:
	enemy_array.append(body.get_parent())
	
	
func _on_Range_body_exited(body: Node) -> void:
	enemy_array.erase(body.get_parent())
