extends State
class_name PlayerKick

@onready var player: Player = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var hitbox: CollisionShape2D

var frames_until_active: int
var frames_active: int
var recovery_frames: int


func enter():
	#play kick animation
	animated_sprite_2d.play("kick")
	hitbox = $"../../Kick/CollisionShape2D"
	frames_until_active = player.stats.kick["frames_until_active"]
	frames_active = player.stats.kick["frames_active"]
	recovery_frames = player.stats.kick["recovery_frames"]


func update(_delta: float):
	if !player.is_multiplayer_authority():
		return
	frames_until_active -= 1

	if frames_until_active == 0:
		hitbox.disabled = false

	if frames_until_active <= 0:
		frames_active -= 1
		if frames_active == 0:
			hitbox.disabled = true

	if frames_active <= 0:
		recovery_frames -= 1
		if recovery_frames == 0:
			state_transition.emit(self, "PlayerIdle")


func exit():
	if player.is_multiplayer_authority():
		hitbox.set_deferred("disabled", true)
	animated_sprite_2d.stop()
