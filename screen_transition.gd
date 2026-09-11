class_name Screen_Transition
extends Node2D

#Crear una referencia de la camara 
@onready var camera_2d: Camera2D = $".."
var moving_camera : bool = false

#Crear referencia del jugador
@onready var player: Player = $"../../Player"


func _on_area_2d_up_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not moving_camera:
		moving_camera = true
		
		#Movimiento automatico del personaje
		await player.move_screen_transition_player(Vector2.UP,20)
		#Nueva position de la camara
		var new_position_camera = camera_2d.position + Vector2(0, -176)
		
		#Crear la transition
		var tween = create_tween()
		tween.tween_property(camera_2d, "position", new_position_camera, 0.8)
		await tween.finished
		
		#Cambiar el estado de la camara
		moving_camera = false
		player.can_move = true
		print("ARRIBA", body.name)


func _on_area_2d_down_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not moving_camera:
		moving_camera = true
		
		#Movimiento automatico del personaje
		await player.move_screen_transition_player(Vector2.DOWN,20)
		#Nueva position de la camara
		var new_position_camera = camera_2d.position + Vector2(0, 176)
		
		#Crear la transition
		var tween = create_tween()
		tween.tween_property(camera_2d, "position", new_position_camera, 0.8)
		await tween.finished
		
		#Cambiar el estado de la camara
		moving_camera = false
		player.can_move = true
		print("ABAJO", body.name)


func _on_area_2d_left_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not moving_camera:
		moving_camera = true
		
		#Movimiento automatico del personaje
		await player.move_screen_transition_player(Vector2.LEFT,20)
		#Nueva position de la camara
		var new_position_camera = camera_2d.position + Vector2(-256, 0)
		
		#Crear la transition
		var tween = create_tween()
		tween.tween_property(camera_2d, "position", new_position_camera, 0.8)
		await tween.finished
		
		#Cambiar el estado de la camara
		moving_camera = false
		player.can_move = true
		print("IZQUIERDA", body.name)


func _on_area_2d_right_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not moving_camera:
		moving_camera = true
		
		#Movimiento automatico del personaje
		await player.move_screen_transition_player(Vector2.RIGHT,20)
		#Nueva position de la camara
		var new_position_camera = camera_2d.position + Vector2(256, 0)
		
		#Crear la transition
		var tween = create_tween()
		tween.tween_property(camera_2d, "position", new_position_camera, 0.8)
		await tween.finished
		
		#Cambiar el estado de la camara
		moving_camera = false
		player.can_move = true
		print("DERECHA", body.name)
