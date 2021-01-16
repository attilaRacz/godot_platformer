extends Node


onready var current_checkpoint = Vector2()


func save_data():
	var file = File.new()
	file.open("user://save", File.WRITE)
	file.store_var(current_checkpoint)
	file.close()


func load_data():
	var file = File.new()
	if not file.file_exists("user://save"):
		return false
	file.open("user://save", File.READ)
	current_checkpoint = file.get_var()
	file.close()
	return true
