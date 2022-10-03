extends KinematicBody2D

var velocity = Vector2()
var speed = 750

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
		
#func _on_impact(normal: Vector2):
#	velocity += velocity.bounce(normal)
#	velocity *= 0.5 + rand_range(-0.05, 0.05)

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func _on_Bullet_hide() -> void:
	queue_free()

func _on_Area2D_body_entered(body: CollisionObject2D) -> void:
	if !("arrow" in str(body)):
		hide()
		# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
