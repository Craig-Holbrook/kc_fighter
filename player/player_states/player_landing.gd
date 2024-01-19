extends State
class_name PlayerLanding

@onready var player: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var frames_left: int


func enter():
	#play landing animation
	animated_sprite_2d.play("squat")
	player.velocity.x = 0
	frames_left = player.stats.LANDING_LAG


func update(_delta: float):
	frames_left -= 1
	if frames_left == 0:
		state_transition.emit(self, "PlayerIdle")


func exit():
	frames_left = player.stats.LANDING_LAG
	animated_sprite_2d.stop()
