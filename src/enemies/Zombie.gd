extends PathFollow2D

signal add_money

export var _speed: float = 150
export var health: int = 6

var prev_pos: Vector2
var direction
var in_castle: bool = false

onready var health_bar = get_node("HealthBar")

func _physics_process(delta: float) -> void:
	if in_castle:
		self.queue_free()
		
	if health > 0 && $KinematicBody2D/AnimatedSprite.animation != "revive":
		move(delta)

func move(delta: float) -> void:
	if prev_pos.x != position.x:
		var diffx: float = position.x - prev_pos.x
		if diffx < -1:
			$KinematicBody2D/AnimatedSprite.animation = "zombie_walking_west"
			direction = "west"
		if diffx > 1:
			$KinematicBody2D/AnimatedSprite.animation ="zombie_walking_east"
			direction = "east"
		prev_pos.x = position.x
	if prev_pos.y != position.y:
		var diffy: float = position.y - prev_pos.y
		if diffy < -1:
			$KinematicBody2D/AnimatedSprite.animation = "zombie_walking_north"
			direction = "north"
		if diffy > 1:
			$KinematicBody2D/AnimatedSprite.animation = "zombie_walking_south"
			direction = "south"
		prev_pos.y = position.y
	
	set_offset(get_offset() + _speed * delta )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedTimer.visible = false
	health_bar.value = health
	health_bar.max_value = health
	$KinematicBody2D/AnimatedSprite.animation = "revive"
	$KinematicBody2D/AnimatedSprite.playing = true
	prev_pos.x = position.x
	prev_pos.y = position.y


	
	
# handle animations finishing
func _on_AnimatedSprite_animation_finished() -> void:
	match $KinematicBody2D/AnimatedSprite.animation:
		"zombie_death":
			$KinematicBody2D/AnimatedSprite.animation = "dead"
			emit_signal("add_money")
			yield(get_tree().create_timer(3), "timeout")
			var world: Node = get_tree().get_root().get_node("World")
			world.enemies_in_wave = world.enemies_in_wave - 1
			self.queue_free()
		"revive":
			_speed = 100
			health_bar.value = health
			health_bar.max_value = health
			$KinematicBody2D/AnimatedSprite.animation = "zombie_walking_" + direction
			for tower in $KinematicBody2D/Area2D.get_overlapping_areas():
				print("checking")
				tower.get_parent().check_for_enemies = true

			

func on_hit(damage: int) -> void:
	health = health - damage
	health_bar.value = health
	if health <= 0:
		_speed = 0
		$KinematicBody2D/AnimatedSprite.animation = "zombie_death"


func _on_Enemy_add_money():
	GameData.gold += 1
	get_tree().get_root().get_node("World").update_label(GameData.gold, "Gold")


func _on_CollisionShape2D_child_entered_tree(node):
	pass # Replace with function body.
