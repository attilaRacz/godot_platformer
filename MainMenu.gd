extends MarginContainer

onready var play_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/PlayContainer/Selector
onready var levels_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/LevelsContainer/HBoxContainer/Selector
onready var options_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/OptionsContainer/HBoxContainer/Selector
onready var exit_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/ExitContainer/HBoxContainer/Selector


var current_selection = 0


func _ready():
	set_current_selection(0)


func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 3:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)


func init_level():
	Save.load_data()
	set_global_position(Save.current_checkpoint)

	if Save.current_level == 1:
		get_tree().change_scene("res://src/Levels/Level_1/Level_1.tscn")
		queue_free()
	if Save.current_level == 2:
		get_tree().change_scene("res://src/Levels/Level_2/Level_2.tscn")
		queue_free()


func handle_selection(current_selection):
	if current_selection == 0:
		init_level()
	elif current_selection == 1:
		print("Select level")
	elif current_selection == 2:
		print("Add options")
	elif current_selection == 3:
		get_tree().quit()
	


func set_current_selection(_current_selection):
	play_selector.text = ""
	levels_selector.text = ""
	options_selector.text = ""
	exit_selector.text = ""
	if _current_selection == 0:
		play_selector.text = ">"
	elif _current_selection == 1:
		levels_selector.text = ">"
	elif _current_selection == 2:
		options_selector.text = ">"
	elif _current_selection == 3:
		exit_selector.text = ">"
