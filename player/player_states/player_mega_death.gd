extends State
class_name PlayerMegaDeath

@onready var player: Player = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var shadow_polygon: Polygon2D = $"../../AnimatedSprite2D/ShadowPolygon"


func enter():
	animated_sprite_2d.play("death")
	#shadow_polygon.visible = false


func update(_delta: float):
	player.velocity = Vector2(-1, -1) * 200 if player.facing_right else Vector2(1, -1) * 200
	player.move_and_slide()
