extends State
class_name PlayerWalking

const SPEED = 150
@onready var player: CharacterBody2D = $"../.."


func enter():
	#play walking animation
	pass


func update(_delta: float):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

	player.move_and_slide()

	#transition to jump squat
	if Input.is_action_just_pressed("ui_accept"):
		state_transition.emit(self, "PlayerJumpSquat")

	#transition to idle
	if player.velocity.x == 0:
		state_transition.emit(self, "PlayerIdle")


func exit():
	pass
