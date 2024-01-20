extends CharacterBody2D
class_name Player

@onready var state_machine = $PlayerStateMachine as StateMachine
@onready var stats: PlayerStats = PlayerStats.new()
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal health_changed

@export var health: int = 3


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if not area.get_parent() == self:
		health -= 1
		health_changed.emit(health)
		if health == 0:
			animated_sprite_2d.play("death")
		if health <= -1:
			health_changed.emit("HE MEGA DED")
