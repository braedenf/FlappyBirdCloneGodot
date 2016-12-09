#Script: spawner_ground

extends Node2D

const scn_ground = preload("res://scenes/ground.tscn") #load ground scene
const GROUND_WIDTH = 168
const AMOUNT_TO_FILL_VIEW = 2

func _ready():
	for i in range(AMOUNT_TO_FILL_VIEW):
		spawn_and_move()
	pass

#ensures that the functions are called in the right order
func spawn_and_move():
	spawn_ground()
	go_next_pos()
	pass

#makes an instance of ground scene; sets position to gound position
#adds new ground as child of container to correct position
func spawn_ground():
	var new_ground = scn_ground.instance()
	new_ground.set_pos(get_pos())
	
	new_ground.connect("exit_tree", self, "spawn_and_move") #connects destroyed signal to spawner and move

	
	get_node("container").add_child(new_ground)
	pass
	
func go_next_pos():
	set_pos(get_pos() + Vector2(GROUND_WIDTH, 0))
	pass