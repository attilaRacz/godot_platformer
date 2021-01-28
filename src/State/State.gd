extends Node


var play_from_start_of_stage = true
var current_checkpoint = Vector2()
var current_level = 1
var levels = []
var unlocked_levels = 1


const level_dict = {
	1: "res://src/Levels/Level_1/Level_1.tscn", 
	2: "res://src/Levels/Level_2/Level_2.tscn",
	3: "res://src/Levels/Level_3/Level_3.tscn"
	# todo - expand with levels
	}

func save_data():
	var file = File.new()
	file.open("user://save", File.WRITE)
	var save_dict = {
		"current_level" : current_level,
		"unlocked_levels" : unlocked_levels,
		"pos_x" : current_checkpoint.x,
		"pos_y" : current_checkpoint.y,
		}
	file.store_var(save_dict)
	file.close()


func load_data():
	var file = File.new()
	if not file.file_exists("user://save"):
		return false
	file.open("user://save", File.READ)
	print(file.get_path_absolute())
	var saved_status = file.get_var()
	current_checkpoint = Vector2(saved_status.get("pos_x"), saved_status.get("pos_y"))
	current_level = int(saved_status.get("current_level"))
	unlocked_levels = int(saved_status.get("unlocked_levels"))
	print(saved_status)
	file.close()
	return true

func move_to_next_level():
	current_level = int(current_level)
	current_level += 1
	if unlocked_levels < current_level:
		unlocked_levels = current_level
	save_data()
	move_to_level(current_level)

func move_to_level(_current_level):
	get_tree().change_scene(level_dict.get(int(_current_level)))
