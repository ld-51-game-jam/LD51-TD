extends "res://src/enemies/Base.gd"

var timer_started: bool = false
var human_health: int = 2
var zombie_health: int = 4
var e_state: String = "HUMAN"

 
# toggle on or off from inspector
export var _demo_mode: bool = false
#for demo purposes only.
var demo_walk_count: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite.animation = "human_walking_south"
	$AnimatedSprite.playing = true
	
# handle timer hitting 10 seconds
func _on_Timer_timeout() -> void:
	$AnimatedSprite.animation = "revive"
	e_state = "ZOMBIE"
	timer_started = false

# handle animations finishing
func _on_AnimatedSprite_animation_finished() -> void:
	match $AnimatedSprite.animation:
		"death":
			$AnimatedSprite.animation = "dead"


func set_flip_v(val: bool) -> void:
	$AnimatedSprite.set_flip_v(val)


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
		$AnimatedSprite.animation = "dead"
		if timer_started == false:
			$Timer.start()

# handle human being hit
func handle_human_hit() -> void:
	human_health = human_health - 1
	if human_health == 0:
		$AnimatedSprite.animation = "death"
