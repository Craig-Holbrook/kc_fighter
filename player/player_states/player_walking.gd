extends State
class_name PlayerWalking

@onready var player: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var speed: int


func enter():
	if (
		(Input.is_action_pressed("move_left") and player.scale.x > 0)
		or (Input.is_action_pressed("move_right") and player.scale.x < 0)
	):
		#play walking backward
		animated_sprite_2d.play("walk_backwards")

	else:
		animated_sprite_2d.play("walk_forward")
		#play walking forward

	speed = player.stats.MOVE_SPEED


func update(_delta: float):
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

	player.move_and_slide()

	#transition to jump squat
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "PlayerJumpSquat")

	#transition to idle
	if not (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		state_transition.emit(self, "PlayerIdle")


func exit():
	pass
