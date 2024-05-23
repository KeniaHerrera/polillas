extends Node2D

var level = 0
#carga la escena claras
export(PackedScene) var claras


#funcion centrar pantalla
func _ready():
	randomize()
	OS.center_window()
	position.x = clamp(position.x, 0, 1080)
	position.y = clamp(position.y, 0, 1080)
	aparecer_claras()

func aparecer_claras():
	for index in range (5 + level):
		var Clara = claras.instance()
		Clara.position = Vector2 (rand_range(0, 1080),rand_range(0, 1080))
	$GemContainer.add_child(Clara)



