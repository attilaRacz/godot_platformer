extends Control


onready var resume_button = $VBoxContainer/ResumeButton


func _ready():
	visible = false


func close():
	visible = false


func open():
	visible = true
	resume_button.grab_focus()


func _on_ResumeButton_pressed():
	get_tree().paused = false
	visible = false


func _on_MainMenuButton_pressed():
	State.save_data()
	get_tree().paused = false
	get_tree().change_scene("res://src/UserInterface/MainMenu.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
