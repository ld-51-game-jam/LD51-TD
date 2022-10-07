extends "res://src/enemies/Base.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start() # we would call this method once the player is "killed"


func _on_Timer_timeout() -> void:
	print("timeout for human")
