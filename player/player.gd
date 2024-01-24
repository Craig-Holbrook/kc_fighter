extends CharacterBody2D
class_name Player

signal health_changed
signal score_changed
signal game_ended

@onready var state_machine = $PlayerStateMachine as StateMachine
@onready var stats: PlayerStats = PlayerStats.new()
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_sound_player: AudioStreamPlayer2D = $DeathSoundPlayer
@onready var kick_sound_player: AudioStreamPlayer2D = $KickSoundPlayer

@export var health: int = 3

var id: int
var margin = 15
var left_border = 0
var right_border = ProjectSettings.get_setting("display/window/size/viewport_width")
var facing_right = true


func _ready():
	set_multiplayer_authority(id)
	score_changed.emit(id)


func _physics_process(_delta: float) -> void:
	global_position.x = clamp(global_position.x, left_border + margin, right_border - margin)
	detect_enemy_position()


func detect_enemy_position():
	for player in get_tree().get_nodes_in_group("players"):
		if player.id != id:
			var vect = global_position - player.global_position
			if (vect.x > 0 and facing_right) or (vect.x < 0 and !facing_right):
				turn_around()


func turn_around():
	scale.x = -scale.x
	facing_right = !facing_right


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if not area.get_parent() == self:
		player_hit.rpc(area.name)


@rpc("call_local", "any_peer")
func player_hit(area_name: String):
	if health > 0:
		state_machine.trigger_force_change_state("PlayerHitStun")
	health -= 1
	health_changed.emit(str(health), id)
	if health == 0:
		update_score_for_winner.rpc()
		if area_name == "Kick":
			state_machine.trigger_force_change_state("PlayerMegaDeath")
			kick_sound_player.play()
		else:
			state_machine.trigger_force_change_state("PlayerDeath")
	if health <= -1:
		health_changed.emit("HE MEGA DED", id)
		death_sound_player.play()


@rpc("any_peer")
func update_score_for_winner():
	for player in get_tree().get_nodes_in_group("players"):
		if player.id != id:
			GameManager.players[player.id].score += 1
			score_changed.emit(player.id)
			game_ended.emit()
