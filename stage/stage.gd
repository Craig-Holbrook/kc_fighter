extends Node2D

@onready var collision_polygon_2d: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d: Polygon2D = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var left_health_number_label: Label = %LeftHealthNumberLabel
@onready var right_health_number_label: Label = %RightHealthNumberLabel
@onready var ready_go: ColorRect = %ReadyGo
@onready var ready_go_label: Label = %ReadyGoLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fight_audio_stream_player_2d: AudioStreamPlayer2D = $FightAudioStreamPlayer2D
@onready var left_score_label: Label = %LeftScoreLabel
@onready var right_score_label: Label = %RightScoreLabel
@onready var spawn_1 = $Spawn1
@onready var spawn_2 = $Spawn2


func _ready() -> void:
	fight_audio_stream_player_2d.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	polygon_2d.polygon = collision_polygon_2d.polygon
	spawn_players()
	start_round()


func update_health_label(new_health: String, player_id: int):
	if player_id == 1:
		left_health_number_label.text = new_health
	else:
		right_health_number_label.text = new_health


func update_score_label(player_id: int):
	if player_id == 1:
		left_score_label.text = str(GameManager.players[player_id].score)
	else:
		right_score_label.text = str(GameManager.players[player_id].score)


func game_over():
	await get_tree().create_timer(3.0).timeout
	reset_game.rpc()


@rpc("any_peer", "call_local")
func reset_game():
	call_deferred("restart_stage")


func restart_stage():
	var stage = load("res://stage/stage.tscn").instantiate()
	get_tree().root.add_child(stage)
	get_tree().root.remove_child(self)


func spawn_players():
	for i in GameManager.players:
		var current_player: Player = load("res://player/player.tscn").instantiate()
		current_player.id = GameManager.players[i].id
		current_player.health_changed.connect(update_health_label)
		current_player.score_changed.connect(update_score_label)
		current_player.game_ended.connect(game_over)
		add_child(current_player)
		if current_player.id == 1:
			current_player.global_position = spawn_1.global_position
		else:
			current_player.global_position = spawn_2.global_position
			current_player.turn_around()


func start_round():
	get_tree().paused = true
	ready_go.visible = true
	animation_player.play("readygo")
	await animation_player.animation_finished
	get_tree().paused = false
	ready_go.visible = false
