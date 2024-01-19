extends State
class_name PlayerIdle

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func enter():
	animated_sprite_2d.play("idle")
	pass


func update(_delta: float):
	#transition to walking
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_transition.emit(self, "PlayerWalking")

	#transition to jump squat
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "PlayerJumpSquat")

	#transition to attacking
	if Input.is_action_just_pressed("punch"):
		state_transition.emit(self, "PlayerAttacking")


func exit():
	animated_sprite_2d.stop()
