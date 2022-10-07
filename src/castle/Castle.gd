extends Area2D

func _ready() -> void:
	$AnimatedSprite.frame = 5 - GameData.hp

func _on_Castle_body_entered(enemy: KinematicBody2D) -> void:
	$AnimationPlayer.play("castle_shake")
	$AnimatedSprite.frame = $AnimatedSprite.frame + 1
	var root = get_tree().get_root().get_node('World')
	root.enemies_in_wave = root.enemies_in_wave - 1
	if GameData.hp > 0:
		GameData.hp -= 1
	root.update_label(GameData.hp, "Health")
	enemy.get_parent().queue_free()
	if GameData.hp <= 0:
		yield(get_tree().create_timer(2.0),"timeout")
		get_tree().change_scene("res://src/game_over/GameOver.tscn")
