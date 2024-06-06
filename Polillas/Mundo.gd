extends Node2D

var claras = 0
var melanicas = 0
var nivel = 1
var max_niveles = 5
var tiempo_por_nivel = 20
var time_mundo = tiempo_por_nivel

var rect_width = 40
var rect_height = 15
var rect_margin = 5

var num_polillas_claras = 10
var num_polillas_melanicas = 10

onready var ClarasA = preload("res://PolillasMelanicas/polillaMelanica.tscn")
onready var MelanicasA = preload("res://PolillasOscuras/polillaOscura.tscn")

func _ready():
	OS.center_window()
	iniciar_nivel()

func iniciar_nivel():
	if nivel > max_niveles:
		get_tree().quit()
		return
	
	# Obtener el tamaño del viewport correctamente
	var viewport_size = get_viewport().size
	randomize()
	
	generate_polillas(ClarasA, num_polillas_claras, viewport_size)
	generate_polillas(MelanicasA, num_polillas_melanicas, viewport_size)
	
	time_mundo = tiempo_por_nivel
	claras = 0
	melanicas = 0

func generate_polillas(polilla_scene, num_polillas, viewport_size):
	for j in range(num_polillas):
		var polilla_new = polilla_scene.instance()
		add_child(polilla_new)
		var random_position = Vector2(rand_range(0, viewport_size.x), rand_range(0, viewport_size.y))
		polilla_new.position = random_position
		# Impresión de depuración para verificar posiciones
		print("Polilla generada en posición: ", random_position)

