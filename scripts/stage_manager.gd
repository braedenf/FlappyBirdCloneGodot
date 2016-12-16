#Script: stage_manager

extends CanvasLayer

const STAGE_GAME = "res://stages/game_stage.tscn"

var is_changing = false #Flag for scene change

signal stage_changed

func _ready():
	
	pass

func change_stage(stage_path):
	if is_changing: return 
	
	is_changing = true
	get_tree().get_root().set_disable_input(true) #disable input
	#fade to black
	get_node("anim").play("fade_in")
	yield(get_node("anim"), "finished") #wait here till signal is emmited
	#change to another stage
	get_tree().change_scene(stage_path)
	emit_signal("stage_changed")
	#fade from black
	get_node("anim").play("fade_out")
	yield(get_node("anim"), "finished") 
	
	is_changing = false
	get_tree().get_root().set_disable_input(true) #re-enable input
	pass