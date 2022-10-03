extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
var random_number_gen = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0,500):
		var type = "Human"
		if i % 2 == 0:
			type = "Zombie"
		var dancer = load("res://src/enemies/" + type + "Dancer.tscn").instance()

		var dancer_position = Vector2(random_number_gen.randf_range(32,1400), random_number_gen.randf_range(32,840))
		dancer.position = dancer_position
		self.add_child(dancer, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
