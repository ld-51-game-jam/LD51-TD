extends Area2D


func _on_Castle_body_entered(enemy: KinematicBody2D) -> void:
	$AnimatedSprite.frame = $AnimatedSprite.frame + 1
	var root = get_tree().get_root().get_node('World')
	root.enemies_in_wave = root.enemies_in_wave - 1
	GameData.hp -= 1
	root.update_label(GameData.hp, "Health")
	enemy.get_parent().queue_free()
	if GameData.hp <= 0:
		get_tree().change_scene("res://src/game_over/GameOver.tscn")
