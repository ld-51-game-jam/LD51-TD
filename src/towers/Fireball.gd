extends Bullet

func _on_BulletArea_body_entered(body: Node) -> void:
	self.queue_free()
