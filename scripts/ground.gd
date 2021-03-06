#Script: ground

extends StaticBody2D

onready var bottom_right = get_node("bottom_right")
onready var camera = utils.get_main_node().get_node("camera")

func _ready():
	set_process(true)
	add_to_group(game.GROUP_GROUNDS)
	pass

func _process(delta):
	if camera == null: return #returns if there is no isntance of camera
	
	if bottom_right.get_global_pos().x <= camera.get_total_pos().x:
		queue_free() #remove ground when it's x pos is less then camera's x pos 
	pass

