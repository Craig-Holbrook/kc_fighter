extends CharacterBody2D

@onready var state_machine = $PlayerStateMachine as StateMachine
@onready var stats: PlayerStats = PlayerStats.new()

signal health_changed

@export var health: int = 3:
	set(value):
		health = value
		health_changed.emit(health, 1)


func _ready():
	print(stats.JUMP_SQUAT_FRAMES)
