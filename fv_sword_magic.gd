class_name FV_swordMagic_scene
extends Area2D

#Darle una velocidad
@export var SPEED: float = 100.0

var direction : Vector2 = Vector2.RIGHT

#Aplicar el desplazamiento de la espada
func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta


func _on_area_entered(area: Area2D) -> void:
	print("AREA DETECTADA" , area.name)
	
	var enemy = area.get_parent()
	
	print("Padre", enemy.name )
	print("El grupo que pertenece: ", area.get_parent().get_groups())
	
	if enemy.is_in_group("ENEMIGOS"):
		enemy.take_damage()
		queue_free()

#Cuando este fuera de la pantalla que la destruya
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
