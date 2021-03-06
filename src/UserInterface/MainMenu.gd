extends Control

onready var play_button = $VBoxContainer/PlayButton


func _ready():
	play_button.grab_focus()


func _on_PlayButton_pressed():
	if State.play_from_start_of_stage:
		State.move_to_level(State.current_level)
	else:
		State.play_from_last_checkpoint()


func _on_LevelsButton_pressed():
	get_tree().change_scene("res://src/UserInterface/LevelSelector.tscn")


func _on_OptionsButton_pressed():
	print("Add options")


func _on_ExitButton_pressed():
	get_tree().quit()
