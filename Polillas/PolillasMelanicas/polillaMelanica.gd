extends KinematicBody2D

# Velocidad del personaje
var speed = 100
# Tiempo mínimo y máximo para cambiar de dirección
var min_change_direction_time = 1.0
var max_change_direction_time = 3.0
var time_counter = 0.0

# Vector de dirección actual
var direction = Vector2.ZERO

func _ready():
	get_node("AnimatedSprite").play("Alas")
	randomize()
	change_direction()
	set_process_input(true)  # Habilitar la detección de entrada
	var collision_shape_2d = $CollisionShape2D.shape
	
	
func _process(delta):
	time_counter -= delta
	if time_counter <= 0:
		change_direction()
		# Establece un nuevo tiempo aleatorio para el próximo cambio de dirección
		time_counter = rand_range(min_change_direction_time, max_change_direction_time)

	move_and_slide(direction * speed)

func change_direction():
	# Cambia la dirección a un vector aleatorio normalizado
	direction.x = randf() * 2 - 1
	direction.y = randf() * 2 - 1
	direction = direction.normalized()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		# Obtener el AnimatedSprite
		var sprite = get_node("AnimatedSprite")
		# Obtener el tamaño de la textura actual del AnimatedSprite
		var sprite_frame = sprite.frames.get_frame(sprite.animation, sprite.frame)
		var sprite_size = sprite_frame.get_size()
		# Crear un rectángulo con la posición y tamaño del AnimatedSprite
		var sprite_rect = Rect2(sprite.global_position - sprite_size / 2, sprite_size / 1.8)
		if sprite_rect.has_point(event.global_position):
			# Ocultar el KinematicBody2D
			hide()
