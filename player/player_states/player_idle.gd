extends State
class_name PlayerIdle


func enter():
	#play idle animation here
	pass


func update(delta: float):
	#transition to walking
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_transition.emit(self, "PlayerWalking")

	#transition to jump squat
	if Input.is_action_just_pressed("ui_accept"):
		state_transition.emit(self, "PlayerJumpSquat")
