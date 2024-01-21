extends State
class_name PlayerMegaDeath

@onready var player: Player = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func enter():
	animated_sprite_2d.play("death")


func update(_delta: float):
	player.velocity = Vector2(1, -1) * 200
	player.move_and_slide()
