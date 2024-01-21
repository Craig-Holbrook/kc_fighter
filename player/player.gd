extends CharacterBody2D
class_name Player

@onready var state_machine = $PlayerStateMachine as StateMachine
@onready var stats: PlayerStats = PlayerStats.new()
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_sound_player: AudioStreamPlayer2D = $DeathSoundPlayer
@onready var kick_sound_player: AudioStreamPlayer2D = $KickSoundPlayer

signal health_changed

@export var health: int = 3


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if not area.get_parent() == self:
		if health > 0:
			state_machine.force_change_state("PlayerHitStun")
		health -= 1
		health_changed.emit(health)
		if health == 0:
			if area.name == "Kick":
				state_machine.force_change_state("PlayerMegaDeath")
				kick_sound_player.play()
			else:
				state_machine.force_change_state("PlayerDeath")
		if health <= -1:
			health_changed.emit("HE MEGA DED")
			death_sound_player.play()
