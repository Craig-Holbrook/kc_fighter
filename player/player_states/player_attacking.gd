extends State
class_name PlayerAttacking

@onready var player: CharacterBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var hitbox: CollisionShape2D

var frames_until_active: int
var frames_active: int
var recovery_frames: int


func enter():
	if Input.is_action_just_pressed("punch"):
		#play punch animation
		animated_sprite_2d.play("punch")
		hitbox = $"../../Punch/CollisionShape2D"
		frames_until_active = player.stats.punch["frames_until_active"]
		frames_active = player.stats.punch["frames_active"]
		recovery_frames = player.stats.punch["recovery_frames"]
	if Input.is_action_just_pressed("kick"):
		#play kick animation
		animated_sprite_2d.play("kick")
		hitbox = $"../../Kick/CollisionShape2D"
		frames_until_active = player.stats.kick["frames_until_active"]
		frames_active = player.stats.kick["frames_active"]
		recovery_frames = player.stats.kick["recovery_frames"]


func update(_delta: float):
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
	animated_sprite_2d.stop()
