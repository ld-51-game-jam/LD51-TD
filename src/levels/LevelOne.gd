extends LevelHandler


func _ready():
	wave_data = [["Enemy", 0.9], ["Enemy", 0.4], ["Enemy", 0.6], ["Enemy", 0.1]]
	var max_wave_label: Label = get_tree().get_root().get_node_or_null("World/UI/HUD/InfoBar/MaxWave")
	if max_wave_label != null:
		max_wave_label.text = "5"
