#Script: spawner_pipe

extends Node2D

const scn_pipe = preload("res://scenes/pipe.tscn")
const GROUND_HEIGHT = 56
const PIPE_WIDTH = 26
const OFFSET_X = 55
const OFFSET_Y = 55
const AMOUNT_TO_FILL_VIEW = 3

func _ready():
	var bird = utils.get_main_node().get_node("bird")
	
	if bird:
		bird.connect("state_changed", self, "on_bird_state_change", [], CONNECT_ONESHOT)
	pass
	
func on_bird_state_change(bird):
	if bird.get_state() == bird.STATE_FLAPPING:
		start()
	pass

func start():
	go_init_pos()
	
	for i in range(AMOUNT_TO_FILL_VIEW):
		spawn_and_move()
	pass

func go_init_pos():
	randomize() #sets a random seed
	
	var init_pos = Vector2()
	init_pos.x = get_viewport_rect().size.width + PIPE_WIDTH/2 #adds the width of screen to the pipe width / 2
	#Sets a random height within the range between the top + offset and the bottom - the ground and offset
	init_pos.y = rand_range(0 + OFFSET_Y, get_viewport_rect().size.height - GROUND_HEIGHT - OFFSET_Y)
	
	var camera = utils.get_main_node().get_node("camera")
	if camera:
		init_pos.x += camera.get_total_pos().x
	
	set_pos(init_pos) #sets position of pipe to init_pos
	pass
#ensures the pipe spawns then moves position
func spawn_and_move():
	spawn_pipe()
	go_next_pos()
	pass

func spawn_pipe():
	var new_pipe = scn_pipe.instance() #copy of spawner_pipe scene
	new_pipe.set_pos(get_pos()) 
	new_pipe.connect("exit_tree", self, "spawn_and_move") #connects the deletion of pipe to instance of new one
	get_node("container").add_child(new_pipe) #adds new pipe to the container 
	pass

#same as go_init_pos
func go_next_pos():
	randomize()
	
	var next_pos = get_pos()
	next_pos.x += PIPE_WIDTH/2 + OFFSET_X + PIPE_WIDTH/2 #adds next position 
	next_pos.y = rand_range(0 + OFFSET_Y, get_viewport_rect().size.height - GROUND_HEIGHT - OFFSET_Y)
	set_pos(next_pos)
	pass