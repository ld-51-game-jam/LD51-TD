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
		self.look_at(enemy.position)
		t += delta * 0.1
		self.position = self.position.linear_interpolate(enemy.position, t )
	else:
		self.queue_free()
		
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

