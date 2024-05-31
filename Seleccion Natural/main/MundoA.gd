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

onready var ClarasA = preload("res://Polillas/Claras/ClarasA.tscn")
onready var MelanicasA = preload("res://Polillas/MelanicasA/MelanicasA.tscn")

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

func _on_Timer_timeout():
	time_mundo -= 1
	get_node("MarginContainer/VBoxContainer/Tiempo").text = "Tiempo: " + str(time_mundo)
	get_node("MarginContainer/VBoxContainer2/Nivel").text = "Nivel: " + str(nivel)
	if time_mundo <= 0:
		actualizar_polillas()
		nivel += 1 
		iniciar_nivel()

func _on_ClarasA_pressed():
	claras += 1
	get_node("MarginContainer/VBoxContainer/Cla").text = "CLARAS: " + str(claras)

func _on_MelanicasA_pressed():
	melanicas += 1
	get_node("MarginContainer/VBoxContainer/Mel").text = "MELANICAS: " + str(melanicas)

func actualizar_polillas():
	var claras_no_capturadas = num_polillas_claras - claras
	var melanicas_no_capturadas = num_polillas_melanicas - melanicas
	
	if claras_no_capturadas > 0:
		num_polillas_claras = claras_no_capturadas + (nivel * 3)
	else:
		num_polillas_claras = 0

	if melanicas_no_capturadas > 0:
		num_polillas_melanicas = melanicas_no_capturadas + (nivel * 3)
	else:
		num_polillas_melanicas = 0

func _draw():
	for i in range(6):
		draw_rect(Rect2(Vector2(100 + i * (rect_width + rect_margin), 15), Vector2(rect_width, rect_height)), Color("478cbf"))
		draw_rect(Rect2(Vector2(100 + i * (rect_width + rect_margin), 45), Vector2(rect_width, rect_height)), Color("ff0000"))

#func _process(delta):
	#$Container/HBoxContainer/VBoxContainer/Tiempo.text = "Tiempo: " + str(time_mundo)
	#$Container/HBoxContainer/VBoxContainer/Claras.text = "Claras:  " + str(claras)
	#$Container/HBoxContainer/VBoxContainer/Melanicas.text = "Melanicas: " + str(melanicas)
#	$Container/HBoxContainer/VBoxContainer/Nivel.text = "Nivel: " + str(nivel)
