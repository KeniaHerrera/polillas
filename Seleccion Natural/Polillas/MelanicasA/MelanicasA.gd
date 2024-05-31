extends Node2D

var melanicas = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal conteoMelanicas

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	melanicas+=1
	get_parent().call("_on_MelanicasA_pressed")
	print("Botón presionado!")
	queue_free()


func _on_Nivel1_MelanicasA():
	if _on_Button_pressed():
		melanicas+=1

func _on_MelanicasA_conteoMelanicas():
	if _on_Button_pressed():
		melanicas+=1
