extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(get_tree().create_timer(2.0),"timeout")
	self.queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_IceSpot_body_entered(body: Node) -> void:
	var enemy = body.get_parent()
	enemy._speed = 75



func _on_IceSpot_body_exited(body: Node) -> void:
	var enemy = body.get_parent()
	enemy._speed = 150

