extends Node2D

onready var asteroid = preload("res://scenes/asteroid.tscn")
var num_asteroids = 10
var score = 0
var wave = 0


func _ready():
	add_asteroids(num_asteroids)
	$Label.text = "Score: "+str(score)



func add_asteroids(n):
	for i in range(n):
		var a = asteroid.instance()
		a.position = Vector2( randf() * get_viewport().size.x, randf() * get_viewport().size.y)
		a.rotation = randf() * 360
		#add it to the game scene
		add_child(a)
		#add a litener for this asteroid emiting a signal
		a.connect("asteroid_hit",self,"_on_asteroid_hit")


func _on_asteroid_hit():
	score += 1
	$Label.text = "Score: "+str(score)

func _on_player_player_hit():
	print("player hit")
	yield(get_tree().create_timer(2),"timeout")
	get_tree().reload_current_scene()
	


func _on_Timer_timeout():
	add_asteroids(num_asteroids + wave)
	wave += 1
