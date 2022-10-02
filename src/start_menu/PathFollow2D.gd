extends PathFollow2D

export var _speed = 100

func _ready():
	var enemy_instance = get_tree().get_root().get_node("StartScene").EnemyScene.instance()
	#enemy_instance.scale = Vector2(2, 5)
	#enemy_instance.position = position
	#enemy_instance.offset = get_offset()
	enemy_instance.set_flip_v(true)
	add_child(enemy_instance)

func _physics_process(delta: float) -> void:
	offset = get_offset() + _speed * delta
