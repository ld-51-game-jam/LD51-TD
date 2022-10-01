extends "res://src/enemies/Base.gd"

var timer_started: bool = false

# toggle on or off from inspector
export var _demo_mode = false
#for demo purposes only.
var demo_walk_count: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite.animation = "human_walking_south"
	$AnimatedSprite.playing = true
	

func _on_Timer_timeout() -> void:
	$AnimatedSprite.animation = "revive"
	timer_started = false
	
	
func _process(delta: float) -> void:
	if $AnimatedSprite.animation == "dead" and timer_started == false:
		$Timer.start()
		timer_started = true


func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "death":
		$AnimatedSprite.animation = "dead"
		
	if $AnimatedSprite.animation == "human_walking_south":
		if _demo_mode:
			demo_walk_count = demo_walk_count + 1
			if demo_walk_count > 3:
				$AnimatedSprite.animation = "death"
				demo_walk_count = 0
			
	if $AnimatedSprite.animation == "revive":
		if _demo_mode:
			$AnimatedSprite.animation = "human_walking_south"
			
