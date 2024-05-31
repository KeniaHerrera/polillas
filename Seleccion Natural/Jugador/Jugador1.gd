extends KinematicBody2D

export (int) var speed = 200

var target = Vector2()
var velocity = Vector2()


func _physics_process(_delta):
	target = get_global_mouse_position()
	velocity = (target - position).normalized() * speed
	
	if (target - position).length() > 5:
		move_and_slide(velocity)

func _ready():
	OS.center_window()
