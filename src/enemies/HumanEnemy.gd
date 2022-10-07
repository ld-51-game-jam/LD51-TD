extends PathFollow2D

signal add_money


var prev_pos: Vector2
var timer_started: bool = false
var health: int = 3

var _speed: float = 150
var direction = "north"
var in_castle: bool = false

onready var health_bar = get_node("HealthBar")

func _physics_process(delta: float) -> void:
	if in_castle:
		self.queue_free()
		
	if health > 0:
		move(delta)

func move(delta: float) -> void:
	if prev_pos.x != position.x:
		var diffx: float = position.x - prev_pos.x
		if diffx < -1:
			$KinematicBody2D/AnimatedSprite.animation = "human_walking_west"
			direction = "west"
		if diffx > 1:
			$KinematicBody2D/AnimatedSprite.animation = "human_walking_east"
			direction = "east"
		prev_pos.x = position.x
	if prev_pos.y != position.y:
		var diffy: float = position.y - prev_pos.y
		if diffy < -1:
			$KinematicBody2D/AnimatedSprite.animation = "human_walking_north"
			direction = "north"
		if diffy > 1:
			$KinematicBody2D/AnimatedSprite.animation = "human_walking_south"
			direction = "south"
		prev_pos.y = position.y
	
	set_offset(get_offset() + _speed * delta )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedTimer.visible = false
	health_bar.value = health
	health_bar.max_value = health
	$KinematicBody2D/AnimatedSprite.animation = "human_walking_south"
	$KinematicBody2D/AnimatedSprite.playing = true
	prev_pos.x = position.x
	prev_pos.y = position.y
	
# handle animations finishing
func _on_AnimatedSprite_animation_finished() -> void:
	match $KinematicBody2D/AnimatedSprite.animation:
		"human_death":
			$KinematicBody2D/AnimatedSprite.animation = "dead"
			$AnimatedTimer.visible = true
			$AnimatedTimer.frame = 0
			$AnimatedTimer.play()
			yield(get_tree().create_timer(3), "timeout")
			var zombie = load("res://src/enemies/Zombie.tscn").instance()
			zombie.direction = direction
			zombie.offset = offset
			get_parent().add_child(zombie, true)
			self.queue_free()
			
			

func on_hit(damage: int) -> void:
	health = health - damage
	health_bar.value = health
	if health <= 0:
		_speed = 0
		$KinematicBody2D/AnimatedSprite.animation = "human_death"
		emit_signal("add_money")
		$KinematicBody2D/Area2D/CollisionShape2D.set_deferred("disabled", true)
		$KinematicBody2D/Area2D.set_deferred("visible", false)



func _on_CollisionShape2D_child_entered_tree(node):
	pass # Replace with function body.


func _on_HumanEnemy_add_money() -> void:
	GameData.gold += 1
	get_tree().get_root().get_node("World").update_label(GameData.gold, "Gold")
