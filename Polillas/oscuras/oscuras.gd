extends Area2D

func pickup():
	#queue_free()
	call_deferred("queue_free")
