extends Node2D

var claras = 0
 
signal ConteoClaras

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	claras+=1
	get_parent().call("_on_ClarasA_pressed")
	print("Botón presionado!")
	queue_free()



func _on_Nivel1_ClarasA():
	if _on_Button_pressed():
		claras+=1
	


func _on_ClarasA_ConteoClaras():
	if _on_Button_pressed():
		claras+=1
	


func _on_Timer_timeout():
	pass # Replace with function body.
