extends Node2D

export var speed = Vector2.ZERO
var lifetime = 5

func _process(delta):
	position += speed * delta
	lifetime -= delta
	if lifetime < 0:
		queue_free()



func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	queue_free()
	
