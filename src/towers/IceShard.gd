extends Bullet





func _on_ImpactDetector_area_entered(area: Area2D) -> void:
	var new_spot = load("res://src/towers/IceSpot.tscn").instance()
	new_spot.position = Vector2(area.get_parent().get_parent().position.x, area.get_parent().get_parent().position.y)
	get_tree().get_root().get_node("World").add_child(new_spot, true)
	self.queue_free()
