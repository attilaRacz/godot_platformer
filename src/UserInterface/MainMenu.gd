extends Control

onready var play_button = $VBoxContainer/PlayButton


func _ready():
	play_button.grab_focus()


func init_level():
	State.load_data()
	set_global_position(State.current_checkpoint) #todo - törölhető?
	State.move_to_level(State.current_level)


func _on_PlayButton_pressed():
	State.load_data()
	State.play_from_start_of_stage = false
	init_level()


func _on_LevelsButton_pressed():
	get_tree().change_scene("res://src/UserInterface/LevelSelector.tscn")


func _on_OptionsButton_pressed():
	print("Add options")


func _on_ExitButton_pressed():
	get_tree().quit()
