extends State
class_name PlayerHitStun

@onready var player: Player = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hit_stun_duration = 36


func enter():
	animated_sprite_2d.play("hit_stun")


func update(delta: float):
	if !player.is_multiplayer_authority():
		return
	player.velocity.y += gravity * delta
	player.velocity.x = -40 if player.facing_right else 40
	player.move_and_slide()
	hit_stun_duration -= 1
	if hit_stun_duration == 0:
		state_transition.emit(self, "PlayerIdle")


func exit():
	player.velocity.x = 0
	hit_stun_duration = 36
	animated_sprite_2d.stop()
