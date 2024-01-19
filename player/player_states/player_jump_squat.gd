extends State
class_name PlayerJumpSquat

@onready var player: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var frames_left: int


func enter():
	#play jump squat animation here
	animated_sprite_2d.play("squat")
	frames_left = player.stats.JUMP_SQUAT_FRAMES


func update(_delta: float):
	#wait frames_left frames then transition to jump
	frames_left -= 1
	if frames_left == 0:
		state_transition.emit(self, "PlayerJump")


func exit():
	frames_left = player.stats.JUMP_SQUAT_FRAMES
	animated_sprite_2d.stop()
