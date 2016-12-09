#Script: utils

extends Node

func _ready():

	pass

func get_main_node():
	var root_node = get_tree().get_root() #get root node
	return root_node.get_child(root_node.get_child_count()-1) # return last child
	
func get_digits(number):
	var str_number = str(number)
	var digits = []
	
	for i in range(str_number.length()):
		digits.append(str_number[i].to_int())
		
	return digits
	pass