extends State
class_name PlayerJump

@onready var shadow_polygon: Polygon2D = $"../../AnimatedSprite2D/ShadowPolygon"
@onready var player: Player = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func enter():
	player.velocity.y = player.stats.JUMP_VELOCITY
	#play jump animation
	animated_sprite_2d.play("jump")
	shadow_polygon.visible = false

	player.collision_layer = 8
	player.collision_mask = 3


func update(delta: float):
	if !player.is_multiplayer_authority():
		return
	player.velocity.y += gravity * delta
	player.move_and_slide()

	#transition to idle when player hits the ground
	if player.is_on_floor():
		state_transition.emit(self, "PlayerLanding")


func exit():
	animated_sprite_2d.stop()
	player.collision_layer = 9
	player.collision_mask = 11
	pass
