extends Node2D

var speed = Vector2.ZERO
#bullet prefab
onready var bullet = preload("res://scenes/bullet.tscn")
#explosion prefab
onready var explosion = preload("res://scenes/explosion.tscn")
#the player hit signal
signal player_hit

#main process
func _process(delta):
	if Input.is_action_pressed("left"):
		rotate(-5 * delta)
	if Input.is_action_pressed("right"):
		rotate(5 * delta)
	if Input.is_action_pressed("thrust"):
		speed += Vector2(200 * delta,0).rotated(rotation)
	#decay the speed
	speed = lerp(speed,Vector2.ZERO,1*delta)
	#and move
	position += speed * delta
	#now shooting
	if Input.is_action_just_pressed("shoot"):
		#shoot
		var b = bullet.instance()
		b.position = position
		b.speed = Vector2(500,0).rotated(rotation)
		get_tree().root.add_child(b)
	# wrap the position
	position.x = wrapf(position.x,0,get_viewport().size.x)
	position.y = wrapf(position.y,0,get_viewport().size.y)	

	
	
#the signal for the area 2d to test the collisions
func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	#make an explosion
	var e = explosion.instance()
	e.position = position
	get_tree().root.add_child(e)
	#and delete the player
	queue_free()
	emit_signal("player_hit")
