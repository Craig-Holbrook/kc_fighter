extends CharacterBody2D

@onready var state_machine = $PlayerStateMachine as StateMachine

signal health_changed

@export var health: int = 3:
	set(value):
		health = value
		health_changed.emit(health, 1)

