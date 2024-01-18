extends Node2D

@onready var collision_polygon_2d: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d: Polygon2D = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var left_health_number_label: Label = %LeftHealthNumberLabel
@onready var right_health_number_label: Label = %RightHealthNumberLabel
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	polygon_2d.polygon = collision_polygon_2d.polygon
	update_health_label(player.health, 1)
	player.health_changed.connect(update_health_label)


func update_health_label(new_health: int, player_id: int):
	left_health_number_label.text = "health: " + str(new_health)
