extends Tower

var projectile
var speed = 100
var velocity = Vector2()
onready var arrow = preload("res://src/towers/arrow.tscn")

func fire() -> void:
	ready = false
	if is_instance_valid(enemy):
		var a = arrow.instance()
		a.start($Turret/Arrow.global_position, rotation)
		get_parent().add_child(a)
		if enemy.health > 0:
			enemy.on_hit(GameData.tower_data[type]["damage"])
			yield(get_tree().create_timer(GameData.tower_data[type]["rof"]), "timeout")
	else:
		enemy_array.erase(enemy)
		enemy = null
	ready = true
	
func _physics_process(delta):
	var dir = $Turret/Arrow.global_position - global_position
