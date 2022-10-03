extends Bullet





func _on_BulletArea_body_entered(body: Node) -> void:
	var new_spot = load("res://src/towers/IceSpot.tscn").instance()
	new_spot.position = Vector2(body.get_parent().position.x, body.get_parent().position.y)
	get_tree().get_root().get_node("World").add_child(new_spot, true)
	self.queue_free()
