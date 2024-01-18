extends State
class_name PlayerJumpSquat

var frames_left = 5


func enter():
	#play jump squat animation here
	pass


func update(_delta: float):
	#wait frames_left frames then transition to jump
	frames_left -= 1
	if frames_left == 0:
		state_transition.emit(self, "PlayerJump")


func exit():
	frames_left = 5
