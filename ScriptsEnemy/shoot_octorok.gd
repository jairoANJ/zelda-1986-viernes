class_name Shoot_Octorok
extends Area2D

#Aplico velocidad al proyectil del octorok
@export var SPEED: float = 100.0

#Variable para que tenga una direccion
var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
