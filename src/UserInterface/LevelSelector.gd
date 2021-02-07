extends Control


onready var levels = $LevelContainer/Levels


func _ready():
	State.load_data()
	for i in range(levels.get_child_count()):
		State.levels.append(i + 1)
	for level in levels.get_children():
		if str2var(level.name) in range(State.unlocked_levels + 1):
			level.disabled = false
			level.connect("pressed", self, "change_level", [level.name])
		else:
			level.disabled = true
	levels.get_child(0).grab_focus()


func change_level(level_number):
	State.current_level = level_number
	State.play_from_start_of_stage = true
	State.move_to_level(level_number)


func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://src/UserInterface/MainMenu.tscn")
	queue_free()
