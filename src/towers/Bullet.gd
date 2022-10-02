extends Node2D
class_name Bullet

var enemy
var tower_type
var t = 0.0

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
 
func _physics_process(delta: float) -> void:
	
	if is_instance_valid(enemy):
		t += delta + 0.02
		$AnimatedSprite.position = self.position.linear_interpolate(enemy.position, t)
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _on_BulletArea_body_entered(body: Node) -> void:
	self.queue_free()
	pass # Replace with function body.
