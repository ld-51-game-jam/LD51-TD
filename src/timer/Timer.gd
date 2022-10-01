extends Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	pass # Replace with function body.


# This method was just a proof of concept for testing the timeout from the time scene
func _on_Timer_timeout() -> void:
	print("10 second timeout")
