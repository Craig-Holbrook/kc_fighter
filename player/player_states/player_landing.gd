extends State
class_name PlayerLanding

@onready var player: CharacterBody2D = $"../.."

var frames_left: int


func enter():
	#play landing animation
	player.velocity.x = 0
	frames_left = player.stats.LANDING_LAG


func update(_delta: float):
	frames_left -= 1
	if frames_left == 0:
		state_transition.emit(self, "PlayerIdle")


func exit():
	frames_left = player.stats.LANDING_LAG
