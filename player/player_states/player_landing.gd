extends State
class_name PlayerLanding

var frames_left = 5


func enter():
	#play landing animation
	pass


func update(delta: float):
	frames_left -= 1
	if frames_left == 0:
		state_transition.emit(self, "PlayerIdle")


func exit():
	frames_left = 5
