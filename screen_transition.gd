class_name Screen_Transition
extends Node2D

@onready var camera_2d: Camera2D = $".."

@onready var player: Player = $"../../Player"

@onready var area_2d_up: Area2D = $Area2D_UP
@onready var area_2d_down: Area2D = $Area2D_DOWN
@onready var area_2d_left: Area2D = $Area2D_LEFT
@onready var area_2d_right: Area2D = $Area2D_RIGHT


func _on_area_2d_up_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_down_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_left_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_right_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
