extends MarginContainer

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector


var current_selection = 0


func _ready():
	set_current_selection(0)


func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 2:
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
		print("Add options")
	elif current_selection == 2:
		get_tree().quit()
	


func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"
