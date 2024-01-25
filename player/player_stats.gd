extends Node
class_name PlayerStats

@export var health = 3
@export var JUMP_SQUAT_FRAMES = 3
@export var LANDING_LAG = 3
@export var MOVE_SPEED = 130
@export var JUMP_VELOCITY = -400.0

@export var punch = {"frames_until_active": 24, "frames_active": 6, "recovery_frames": 12}
@export var kick = {"frames_until_active": 30, "frames_active": 12, "recovery_frames": 24}
