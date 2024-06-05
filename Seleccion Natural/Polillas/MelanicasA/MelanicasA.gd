extends Node2D

var melanicas = 0
signal conteoMelanicas
var velocity = Vector2()
var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	velocity = Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0)).normalized() * speed

func _process(delta):
	position += velocity * delta
	if position.x < 0 or position.x > get_viewport().size.x:
		velocity.x = -velocity.x
	if position.y < 0 or position.y > get_viewport().size.y:
		velocity.y = -velocity.y

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
