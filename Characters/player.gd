class_name Player
extends CharacterBody2D


@export var SPEED: float = 60.0
var is_attaking : bool = false

var facing_direction := Vector2.DOWN
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var can_move: bool = true

func _physics_process(delta: float) -> void:
	
	if not can_move:
		velocity = Vector2.ZERO
		return
	
	if Input.is_action_just_pressed("ATACAR"):
		attack()
		
	if is_attaking == true:
		return
	
	var direction = Input.get_vector(
		"IZQUIERDA","DERECHA","ARRIBA", "ABAJO")
		
	velocity = direction * SPEED
	
	#Si el player esta quieto, que verifique la direccion hacia donde esta mirando
	#y que pause la animacion hacia esa direccion.
	if direction == Vector2.ZERO:
		if facing_direction == Vector2.DOWN:
			animated_sprite_2d.play("walk_down")
		elif facing_direction == Vector2.UP:
			animated_sprite_2d.play("walk_up")
		elif  facing_direction == Vector2.RIGHT:
			animated_sprite_2d.play("walk_right")
		elif facing_direction == Vector2.LEFT:
			animated_sprite_2d.play("walk_left")
		animated_sprite_2d.pause()
		return
	
	if direction.x > 0:
		facing_direction = Vector2.RIGHT
		animated_sprite_2d.play("walk_right")
	elif direction.x < 0:
		facing_direction = Vector2.LEFT
		animated_sprite_2d.play("walk_left")
	elif  direction.y > 0:
		facing_direction = Vector2.DOWN
		animated_sprite_2d.play("walk_down")
	elif direction.y < 0:
		facing_direction = Vector2.UP
		animated_sprite_2d.play("walk_up")
		
	move_and_slide()
		
	
func attack()->void:
	
	is_attaking = true
	
	if facing_direction == Vector2.DOWN:
		animated_sprite_2d.play("sword_down")
	elif facing_direction == Vector2.UP:
		animated_sprite_2d.play("sword_up")
	elif facing_direction == Vector2.LEFT:
		animated_sprite_2d.play("sword_left")
	elif facing_direction == Vector2.RIGHT:
		animated_sprite_2d.play("sword_right")
	await animated_sprite_2d.animation_finished
	print("Attack finish")
	is_attaking = false
	
func move_screen_transition_player(direction: Vector2, distance: float)-> void:
	can_move = false
	#Verificar la direccion del personaje y hacia esa direccion voy a ejecutar
	#la animacion
	if direction.x >0:
		animated_sprite_2d.play("walk_right")
	elif direction.x <0:
		animated_sprite_2d.play("walk_left")
	elif direction.y >0:
		animated_sprite_2d.play("walk_down")
	elif direction.y <0:
		animated_sprite_2d.play("walk_up")
		
	var tween = create_tween()
	tween.tween_property(self, "position", position + direction * distance, 0.5)
	await tween.finished

	
	
	
	
	

	
	
			
			
			
			
			
