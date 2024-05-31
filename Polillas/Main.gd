extends Node2D

#func _on_Salir_pressed():
#	print("Sali del juego")
#	get_tree().quit()




func _on_Jugar_pressed():
	get_tree().change_scene("res://Mundo.tscn")


func _on_Salir_pressed():
	get_tree().quit()
