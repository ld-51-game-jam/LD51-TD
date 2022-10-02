extends Tower

signal hit

var arrow = preload("res://src/towers/ammo/arrow.tscn").instance()

#export var speed = 10 # How fast the player will move (pixels/sec).
export var arrow_speed = 150

func fire() -> void:
	var a = arrow
	a.position = get_global_position()
	a.rotation = get_angle_to(get_global_mouse_position())
	a.apply_impulse(Vector2(), Vector2(arrow_speed, 0).rotated(a.rotation))
	get_tree().get_root().call_deferred("add_child", a)
	
	ready = false
	if enemy.health > 0:
		enemy.on_hit(GameData.tower_data[type]["damage"])
		yield(get_tree().create_timer(GameData.tower_data[type]["rof"]), "timeout")
	ready = true
