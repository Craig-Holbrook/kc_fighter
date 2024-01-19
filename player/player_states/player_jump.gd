extends State
class_name PlayerJump

@onready var player: CharacterBody2D = $"../.."
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func enter():
	player.velocity.y = player.stats.JUMP_VELOCITY
	#play jump animation


func update(delta: float):
	player.velocity.y += gravity * delta
	player.move_and_slide()

	#transition to idle when player hits the ground
	if player.is_on_floor():
		state_transition.emit(self, "PlayerLanding")
