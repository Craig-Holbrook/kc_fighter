extends State
class_name PlayerLanding

@onready var shadow_polygon: Polygon2D = $"../../AnimatedSprite2D/ShadowPolygon"
@onready var player: Player = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var frames_left: int


func enter():
	#play landing animation
	animated_sprite_2d.play("squat")
	player.velocity.x = 0
	frames_left = player.stats.LANDING_LAG
	shadow_polygon.visible = true


func update(_delta: float):
	if !player.is_multiplayer_authority():
		return
	frames_left -= 1
	if frames_left == 0:
		state_transition.emit(self, "PlayerIdle")


func exit():
	frames_left = player.stats.LANDING_LAG
	animated_sprite_2d.stop()
