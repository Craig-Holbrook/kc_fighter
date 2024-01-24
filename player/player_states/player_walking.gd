extends State
class_name PlayerWalking

@onready var player: Player = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var speed: int


func enter():
	if (
		(Input.is_action_pressed("move_left") and player.facing_right)
		or (Input.is_action_pressed("move_right") and !player.facing_right)
	):
		#play walking backward
		animated_sprite_2d.play("walk_backwards")

	else:
		animated_sprite_2d.play("walk_forward")
		#play walking forward

	speed = player.stats.MOVE_SPEED


func update(_delta: float):
	if !player.is_multiplayer_authority():
		return
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

	player.move_and_slide()

	#transition to jump squat
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "PlayerJumpSquat")

	#transition to idle if no direction is pressed or holding both at the same time
	if (
		!(Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"))
		or (Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"))
	):
		state_transition.emit(self, "PlayerIdle")

	#transition to attacking
	if Input.is_action_just_pressed("punch"):
		state_transition.emit(self, "PlayerPunch")

	if Input.is_action_just_pressed("kick"):
		state_transition.emit(self, "PlayerKick")
