extends PathFollow2D

func _start() -> void:
	var enemy = get_tree().get_root().get_node(".").EnemyScene.instance()

	add_child(enemy)
	print(enemy)
