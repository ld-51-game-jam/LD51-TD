extends PathFollow2D
const human_health: int = 4
const zombie_health: int = 8
var prev_pos: Vector2
var timer_started: bool = false
var health: int = human_health

var e_state: String = "human"
var _speed: float = 150
var direction = "north"
onready var health_bar = get_node("HealthBar")

func _physics_process(delta: float) -> void:
	move(delta)


func move(delta: float) -> void:
	if health <= 0:
		return
	if prev_pos.x != position.x:
		var diffx = position.x - prev_pos.x
		if diffx < -1:
			$KinematicBody2D/AnimatedSprite.animation = e_state + "_walking_west"
			direction = "west"
		if diffx > 1:
			$KinematicBody2D/AnimatedSprite.animation = e_state + "_walking_east"
			direction = "east"
		prev_pos.x = position.x
	if prev_pos.y != position.y:
		var diffy = position.y - prev_pos.y
		if diffy < -1:
			$KinematicBody2D/AnimatedSprite.animation = e_state + "_walking_south"
			direction = "south"
		if diffy > 1:
			$KinematicBody2D/AnimatedSprite.animation = e_state + "_walking_north"
			direction = "north"
		prev_pos.y = position.y
		
	set_offset(get_offset() + _speed * delta )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = health
	health_bar.max_value = health
	$KinematicBody2D/AnimatedSprite.animation = "human_walking_south"
	$KinematicBody2D/AnimatedSprite.playing = true
	prev_pos.x = position.x
	prev_pos.y = position.y
	
# handle animations finishing
func _on_AnimatedSprite_animation_finished() -> void:
	match $KinematicBody2D/AnimatedSprite.animation:
		"death":
			$KinematicBody2D/AnimatedSprite.animation = "dead"
			yield(get_tree().create_timer(10), "timeout")
			e_state = "zombie"
			health = zombie_health
			$KinematicBody2D/AnimatedSprite.animation = "revive"
		"revive":
			health_bar.value = zombie_health
			health_bar.max_value = zombie_health
			$KinematicBody2D/AnimatedSprite.animation = "zombie_walking_" + direction
			_speed = 50
			

# detect a bullet hitting enemy player
# bullet_hit(node: Bullet) -> void:
func on_hit(damage: int) -> void:
	match e_state:
		"zombie":
			handle_zombie_hit(damage)
		"human":
			handle_human_hit(damage)

# handle zombie being hit
func handle_zombie_hit(damage: int) -> void:
	health = health - damage
	health_bar.value = health
	print(self.get_name() + " zombie " + String(health) + " hp")
	if health <= 0:
		_speed = 0
		$KinematicBody2D/AnimatedSprite.animation = "dead"
		yield(get_tree().create_timer(3), "timeout")
		self.queue_free()


# handle human being hit
func handle_human_hit(damage: int) -> void:
	health = health - damage
	health_bar.value = health
	print(self.get_name() + " human " + String(health) + " hp")
	if health <= 0:
		_speed = 0
		$KinematicBody2D/AnimatedSprite.animation = "death"
		
