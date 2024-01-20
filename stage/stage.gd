extends Node2D

@onready var collision_polygon_2d: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d: Polygon2D = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var left_health_number_label: Label = %LeftHealthNumberLabel
@onready var right_health_number_label: Label = %RightHealthNumberLabel
@onready var player: CharacterBody2D = $Player
@onready var ready_go: ColorRect = %ReadyGo
@onready var ready_go_label: Label = %ReadyGoLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fight_audio_stream_player_2d: AudioStreamPlayer2D = $FightAudioStreamPlayer2D


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	polygon_2d.polygon = collision_polygon_2d.polygon
	update_health_label(player.health, 1)
	player.health_changed.connect(update_health_label)
	fight_audio_stream_player_2d.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_tree().paused = true
	ready_go.visible = true
	animation_player.play("readygo")
	await animation_player.animation_finished
	get_tree().paused = false
	ready_go.visible = false


func update_health_label(new_health: int, player_id: int):
	left_health_number_label.text = " " + str(new_health)
