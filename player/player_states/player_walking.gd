extends State
class_name PlayerWalking

@onready var player: CharacterBody2D = $"../.."
var speed: int


func enter():
	if (
		(Input.is_action_just_pressed("ui_left") and player.scale.x > 0)
		or (Input.is_action_just_pressed("ui_right") and player.scale.x < 0)
	):
		#play walking backward
		pass
	else:
		#play walking forward
		pass

	speed = player.stats.MOVE_SPEED


func update(_delta: float):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

	player.move_and_slide()

	#transition to jump squat
	if Input.is_action_just_pressed("ui_accept"):
		state_transition.emit(self, "PlayerJumpSquat")

	#transition to idle
	if player.velocity.x == 0:
		state_transition.emit(self, "PlayerIdle")


func exit():
	pass
