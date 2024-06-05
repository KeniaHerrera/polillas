extends Node2D

var claras = 0

signal ConteoClaras

var velocity = Vector2()
var speed = 50

func _ready():
	randomize()
	velocity = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)).normalized() * speed

func _process(delta):
	# Mueve la polilla
	position += velocity * delta
	
	if position.x < 0 or position.x > get_viewport().size.x:
		velocity.x = -velocity.x
	if position.y < 0 or position.y > get_viewport().size.y:
		velocity.y = -velocity.y

func _on_Button_pressed():
	claras += 1
	get_parent().call("_on_ClarasA_pressed")
	print("Botón presionado!")
	queue_free()

func _on_Nivel1_ClarasA():
	if _on_Button_pressed():
		claras += 1

func _on_ClarasA_ConteoClaras():
	if _on_Button_pressed():
		claras += 1

func _on_Timer_timeout():
	pass # Replace with function body.
