extends PathFollow2D


var prev_pos: Vector2
var timer_started: bool = false
var human_health: int = 2
var zombie_health: int = 4
var e_state: String = "HUMAN"
var _speed: float = 150


func _physics_process(delta: float) -> void:
	move(delta)


func move(delta: float) -> void:
	if prev_pos.x != position.x:
		var diffx = position.x - prev_pos.x
		if diffx < -1:
			$KinematicBody2D/AnimatedSprite.animation = "human_walking_west"
		if diffx > 1:
			$KinematicBody2D/AnimatedSprite.animation = "human_walking_east"
		prev_pos.x = position.x
	if prev_pos.y != position.y:
		var diffy = position.y - prev_pos.y
		if diffy < -1:
			$KinematicBody2D/AnimatedSprite.animation = "human_walking_south"
		if diffy > 1:
			$KinematicBody2D/AnimatedSprite.animation = "human_walking_north"
		prev_pos.y = position.y
		
	set_offset(get_offset() + _speed * delta )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KinematicBody2D/AnimatedSprite.animation = "human_walking_south"
	$KinematicBody2D/AnimatedSprite.playing = true
	prev_pos.x = position.x
	prev_pos.y = position.y
	
# handle timer hitting 10 seconds
func _on_Timer_timeout() -> void:
	$KinematicBody2D/AnimatedSprite.animation = "revive"
	e_state = "ZOMBIE"
	timer_started = false

# handle animations finishing
func _on_AnimatedSprite_animation_finished() -> void:
	match $KinematicBody2D/AnimatedSprite.animation:
		"death":
			$KinematicBody2D/AnimatedSprite.animation = "dead"
		"revive":
			$KinematicBody2D/AnimatedSprite.animation = "zombie_walking_north"

# detect a bullet hitting enemy player
# bullet_hit(node: Bullet) -> void:
func bullet_hit(node) -> void:
	if node != null:
		match e_state:
			"ZOMBIE":
				handle_zombie_hit()
			"HUMAN":
				handle_human_hit()

# handle zombie being hit
func handle_zombie_hit() -> void:
	zombie_health = zombie_health - 1
	if zombie_health == 0:
		$KinematicBody2D/AnimatedSprite.animation = "dead"
		if timer_started == false:
			$Timer.start()

# handle human being hit
func handle_human_hit() -> void:
	human_health = human_health - 1
	if human_health == 0:
		$KinematicBody2D/AnimatedSprite.animation = "death"
