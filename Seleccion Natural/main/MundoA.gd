extends Node2D

var claras = 0
var melanicas = 0
var nivel = 1
var max_niveles = 3
var tiempo_por_nivel = 10
var time_mundo = tiempo_por_nivel

var rect_width = 40
var rect_height = 15
var rect_margin = 5

var num_polillas_claras = 10
var num_polillas_melanicas = 10
var incremento_polillas = 2  # Incremento por nivel
var min_polillas = 2  # Número mínimo de polillas de cada tipo

onready var ClarasA = preload("res://Polillas/Claras/ClarasA.tscn")
onready var MelanicasA = preload("res://Polillas/MelanicasA/MelanicasA.tscn")

# Define los límites del área de generación asi ya no salen fuera del area
var min_x = 100
var max_x = 950
var min_y = 100
var max_y = 950

# Variable para almacenar las posiciones ocupadas y evitar que se encimen en la generacion
var pos_ocupada = []

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
	# Limpiar las posiciones ocupadas antes de generar nuevas polillas
	pos_ocupada.clear()
	
	generate_polillas(ClarasA, num_polillas_claras)
	generate_polillas(MelanicasA, num_polillas_melanicas)
	
	time_mundo = tiempo_por_nivel
	claras = 0
	melanicas = 0

func generate_polillas(polilla_scene, num_polillas):
	for j in range(num_polillas):
		var polilla_new = polilla_scene.instance()
		add_child(polilla_new)
		
		var pos_rand = pos_unica()
		polilla_new.position = pos_rand
		
		# Almacenar la posición ocupada
		pos_ocupada.append(pos_rand)
		#ver posicion
		#print("Polilla generada en posición: ", pos_rand)

# Función para obtener una posición aleatoria única
func pos_unica():
	while true:
		var pos_rand = Vector2(rand_range(min_x, max_x), rand_range(min_y, max_y))
		var pos_valida = true
		
		# Verificar si la posición generada ya está ocupada
		for pos in pos_ocupada:
			if pos.distance_to(pos_rand) < rect_width:
				pos_valida = false
				break
		
		if pos_valida:
			return pos_rand

func _on_Timer_timeout():
	time_mundo -= 1
	get_node("MarginContainer/VBoxContainer/Tiempo").text = "Tiempo: " + str(time_mundo)
	if time_mundo <= 0:
		get_tree().quit()
		

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
		num_polillas_claras = max(claras_no_capturadas + incremento_polillas, min_polillas)
	else:
		num_polillas_claras = min_polillas

	if melanicas_no_capturadas > 0:
		num_polillas_melanicas = max(melanicas_no_capturadas + incremento_polillas, min_polillas)
	else:
		num_polillas_melanicas = min_polillas

	if nivel > 3:
		incremento_polillas = 1

func _draw():
	for i in range(6):
		draw_rect(Rect2(Vector2(100 + i * (rect_width + rect_margin), 15), Vector2(rect_width, rect_height)), Color("478cbf"))
		draw_rect(Rect2(Vector2(100 + i * (rect_width + rect_margin), 45), Vector2(rect_width, rect_height)), Color("ff0000"))
