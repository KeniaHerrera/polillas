extends Area2D

export (int) var speed = 200

var rest_point
var rest_nodes = []
var selected = false
signal hit
var target = Vector2()
var velocity = Vector2()

func _physics_process(_delta):
	target = get_global_mouse_position()
	velocity = (target - position).normalized() * speed
	
	if (target - position).length() > 5:
		move_and_slide(velocity)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			var shortest_dist = 75
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist:
					child.select()
					rest_point = child.global_position
					shortest_dist = distance

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()
	OS.center_window()
