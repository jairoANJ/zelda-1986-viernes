class_name OCTOROK
extends CharacterBody2D

#Creo una referencia a la escena de la bala - arrastro al editor
@export var proyectile_scene: PackedScene

#Creo la referencia en el punto donde se generara el proyectil
@onready var shoot_point: Marker2D = $ShootPoint

#variable para detener el movimiento de octorok
var is_moving : bool = true


#Crea una referencia al nodo de animaciones
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#Se crean las referencias a los  4 raycast, que detectaran los objetos u obstaculos que tenga el enemigo
@onready var ray_cast_2d_up: RayCast2D = $RayCast2D_UP
@onready var ray_cast_2d_down: RayCast2D = $RayCast2D_DOWN
@onready var ray_cast_2d_left: RayCast2D = $RayCast2D_LEFT
@onready var ray_cast_2d_right: RayCast2D = $RayCast2D_RIGHT

#Timer para elegir una direccion aleatoria
@onready var timer_change_direction: Timer = $Timer_change_direction
@onready var timer_on_shoot: Timer = $Timer_on_shoot
@onready var timer_dalay_shoot: Timer = $Timer_dalay_shoot


#Se crea la variable para aplicar mas velocidad al enemigo
@export var SPEED: float = 60.0

#Se crea la variable para controlar la direccion hacia donde se desplaza y mira el enemigo
var direction : Vector2 = Vector2.DOWN
#Se crea un arreglo para determinar las direcciones hacia donde se puede mover el enemigo.
var array_directions: Array = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]


func _ready() -> void:
	timer_change_direction.start(randf_range(1.0,2.5))
	#Elige una direccion random.
	direction = array_directions.pick_random()
	
		
func _physics_process(delta: float) -> void:
	#Si is_moving es falso, detenemos la velocidad con vector2.zero (0,0)
	#y nos salimos de la funcnion.
	if not is_moving:
		velocity = Vector2.ZERO
		return
	
	#Verificar la direccion de movimiento
	if direction.x > 0:
		animated_sprite_2d.play("walk_right")
	elif direction.x < 0:
		animated_sprite_2d.play("walk_left")
	elif direction.y > 0:
		animated_sprite_2d.play("walk_down")
	elif direction.y < 0:
		animated_sprite_2d.play("walk_up")
	
	velocity = direction * SPEED
	move_and_slide()	
	
	#Tomamos la posicion global de octorok y ubicamos el punto de tiro
	shoot_point.position = direction * 12

		
	#validar la direccion hacia donde se mueve y verifcar si el raycas detecto algo.
	if direction == Vector2.UP and ray_cast_2d_up.is_colliding():
		change_direction()
	elif direction == Vector2.DOWN and ray_cast_2d_down.is_colliding():
		change_direction()
	elif direction == Vector2.LEFT and ray_cast_2d_left.is_colliding():
		change_direction()
	elif direction == Vector2.RIGHT and ray_cast_2d_right.is_colliding():
		change_direction()
	
func change_direction()-> void:
	#Se crea el arreglo para guardar las direccione disponibles para el enemigo.
	var available_directions: Array = []
	
	#verifico los raycas, si alguno no esta collisionando, cuenta como un camino disponilbe
	#Por lo cual lo almacenamos en el arreglo available_directions.
	if not ray_cast_2d_up.is_colliding():
		available_directions.append(Vector2.UP)
	if not ray_cast_2d_down.is_colliding():
		available_directions.append(Vector2.DOWN)
	if not ray_cast_2d_left.is_colliding():
		available_directions.append(Vector2.LEFT)
	if not ray_cast_2d_right.is_colliding():
		available_directions.append(Vector2.RIGHT)
		
	#Elige una nueva direccion disponible.
	direction = available_directions.pick_random()
	


func _on_timer_change_direction_timeout() -> void:
	change_direction()
	timer_change_direction.start(randf_range(0.5,1.1))

#Timer para controlar el tiempo en el cual Octorok lanza su proyectil.
func _on_timer_on_shoot_timeout() -> void:
	#Octorok deja de moverse
	is_moving = false
	
	#Detenemos el cambio automatico de direccion
	timer_change_direction.stop()
	
	#Se espera 1 segundo antes de que dispare
	timer_dalay_shoot.start(1.5)
	
func _on_timer_dalay_shoot_timeout() -> void:
	shoot()
	
	#Dejamos mover le jugador 
	is_moving=true
	
	#Activamos el cambio de direccion
	timer_change_direction.start(randf_range(1.1,3.0))
	
	#Se comienza el ciclo del disparo
	timer_on_shoot.start(randf_range(3.0,5.0))
		
func shoot()-> void:
	#Creamos una variable y guardamos el proyectil de escena
	#Luego accedemos al arbol de nodos de Octorok y vinculamos le proyectil como hijo.
	var proyectile : Shoot_Octorok = proyectile_scene.instantiate()
	get_tree().current_scene.add_child(proyectile)
	
	#El proyectil tomara la posicion global del mundo.
	proyectile.global_position = shoot_point.global_position
	
	#Definimos la direccion del proyectil
	proyectile.direction = direction
	
	is_moving = true


	
