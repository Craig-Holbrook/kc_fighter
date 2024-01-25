extends State
class_name PlayerIdle

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var player: Player = $"../.."


func enter():
	animated_sprite_2d.play("idle")


func update(_delta: float):
	if !player.is_multiplayer_authority():
		return
	#transition to walking if only pressing one of the directions
	if (
		!(Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"))
		and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"))
	):
		state_transition.emit(self, "PlayerWalking")

	#transition to jump squat
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "PlayerJumpSquat")

	#transition to attacking
	if Input.is_action_just_pressed("punch"):
		state_transition.emit(self, "PlayerPunch")

	if Input.is_action_just_pressed("kick"):
		state_transition.emit(self, "PlayerKick")


func exit():
	animated_sprite_2d.stop()
