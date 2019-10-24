extends Node2D

export var speed = Vector2.ZERO
signal asteroid_hit
onready var explosion = preload("res://scenes/explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	speed.x = randf() * 100 - 50
	speed.y = randf() * 100 - 50

func _process(delta):
	position += speed * delta
	# wrap the position
	position.x = wrapf(position.x,0,get_viewport().size.x)
	position.y = wrapf(position.y,0,get_viewport().size.y)	

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	#this will emit a signal that the game script will listen for
	emit_signal("asteroid_hit")
	var e = explosion.instance()
	e.position = position
	get_parent().add_child(e)
	queue_free()

