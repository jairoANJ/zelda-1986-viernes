class_name Player
extends CharacterBody2D

#Creo una referencia del hitbox de la espada
@onready var sword_hit_box: Area2D = $SwordHitBox

#Llamar la espada magica
@export var sword_magic_scene : PackedScene




@export var SPEED: float = 60.0
var is_attaking : bool = false

var facing_direction := Vector2.DOWN
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var can_move: bool = true

func _ready() -> void:
	sword_hit_box.monitoring = false

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
		sword_hit_box.position = Vector2(0,14)
		animated_sprite_2d.play("sword_down")
	elif facing_direction == Vector2.UP:
		sword_hit_box.position = Vector2(0,-14)
		animated_sprite_2d.play("sword_up")
	elif facing_direction == Vector2.LEFT:
		sword_hit_box.position = Vector2(-14,0)
		animated_sprite_2d.play("sword_left")
	elif facing_direction == Vector2.RIGHT:
		sword_hit_box.position = Vector2(14,0)
		animated_sprite_2d.play("sword_right")
	#Habilitamos el monitoreo	
	sword_hit_box.monitoring = true
	#Lanzar espada	
	cast_sword()
		
	await animated_sprite_2d.animation_finished
	#Desabilitamos monitoreo
	sword_hit_box.monitoring = false
	
	sword_hit_box.position = Vector2(0,0)
	
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
			

#Detecta
func _on_sword_hit_box_area_entered(area: Area2D) -> void:
	print("AREA DETECTADA" , area.name)
	
	var enemy: OCTOROK = area.get_parent()
	
	print("Padre", enemy.name )
	print("El grupo que pertenece: ", area.get_parent().get_groups())
	
	if enemy.is_in_group("ENEMIGOS"):
		enemy.take_damage()
	
#Crear el metodo para lanzar la espada
func cast_sword()->void:
	
	#Crear una instancia
	var swordMagic : FV_swordMagic_scene = sword_magic_scene.instantiate()
	
	#Posicionamos
	get_parent().add_child(swordMagic)
	
	swordMagic.global_position = global_position
	swordMagic.direction = facing_direction
	swordMagic.rotation = facing_direction.angle() + PI /2
	
	
	
	
	
	
