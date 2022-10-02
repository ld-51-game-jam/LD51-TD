extends PathFollow2D

var posx
var posy

var timer_started: bool = false
var human_health: int = 2
var zombie_health: int = 4
var e_state: String = "human"

var _speed: float = 150

# toggle on or off from inspector
export var _demo_mode: bool = false
#for demo purposes only.
var demo_walk_count: int = 0
func _physics_process(delta: float) -> void:
	move(delta)

func move(delta: float) -> void:
	if posx != position.x:
		var diffx = position.x - posx
		if diffx < -1:
			$KinematicBody2D/AnimatedSprite.animation = e_state + "_walking_west"
		if diffx > 1:
			$KinematicBody2D/AnimatedSprite.animation = e_state + "_walking_east"
		posx = position.x
	if posy != position.y:
		var diffy = position.y - posy
		if diffy < -1:
			$KinematicBody2D/AnimatedSprite.animation = e_state + "_walking_south"
		if diffy > 1:
			$KinematicBody2D/AnimatedSprite.animation = e_state + "_walking_north"
		posy = position.y
		
	set_offset(get_offset() + _speed * delta )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KinematicBody2D/AnimatedSprite.animation = "human_walking_south"
	$KinematicBody2D/AnimatedSprite.playing = true
	posx = position.x
	posy = position.y
	
# handle animations finishing
func _on_AnimatedSprite_animation_finished() -> void:
	match $KinematicBody2D/AnimatedSprite.animation:
		"death":
			$KinematicBody2D/AnimatedSprite.animation = "dead"
		"revive":
			$KinematicBody2D/AnimatedSprite.animation = "zombie_walking_south"
			

# detect a bullet hitting enemy player
# bullet_hit(node: Bullet) -> void:
func bullet_hit(damage: int) -> void:
	match e_state:
		"zombie":
			handle_zombie_hit(damage)
		"human":
			handle_human_hit(damage)

# handle zombie being hit
func handle_zombie_hit(damage: int) -> void:
	zombie_health = zombie_health - 1
	if zombie_health == 0:
		$KinematicBody2D/AnimatedSprite.animation = "dead"


# handle human being hit
func handle_human_hit(damage: int) -> void:
	human_health = human_health - 1
	if human_health == 0:
		$KinematicBody2D/AnimatedSprite.animation = "death"
		yield(get_tree().create_timer(10), "timeout")
		e_state = "zombie"
		$KinematicBody2D/AnimatedSprite.animation = "revive"
		
