extends CanvasLayer


func set_tower_preview(tower_type: String, mouse_position: Vector2):
	var drag_tower = load("res://src/towers/" + tower_type + ".tscn").instance()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("ca3aa100")
	var range_texture = Sprite.new()
	range_texture.position = Vector2(32,32)
	var scaling = GameData.tower_data[tower_type].range / 500.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://assets/ui/range_preview.png")
	range_texture.texture = texture
	range_texture.modulate = Color("ca3aa100")
	
	var control = Control.new()
	
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.rect_position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)

	move_child(get_node("TowerPreview"), 0)
	
func update_tower_preview(new_position, color):
	get_node("TowerPreview").rect_position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/Sprite").modulate = Color(color)
