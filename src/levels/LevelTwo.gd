extends LevelHandler


func _ready() -> void:
	max_waves = 4
	wave_data = ["Enemy", 5]
	counters_visible = true
	change_labels()
