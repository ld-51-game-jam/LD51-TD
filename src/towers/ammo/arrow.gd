extends RigidBody2D


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func _on_Bullet_hide() -> void:
	queue_free()

func _on_Area2D_body_entered(body: CollisionObject2D) -> void:
	if !("arrow" in str(body)):
		hide()
		# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
