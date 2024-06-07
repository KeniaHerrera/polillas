extends Node2D

func _on_Jugar_pressed():
	get_tree().change_scene("res://mundo/mundo.tscn")


func _on_Salir_pressed():
	get_tree().quit()

