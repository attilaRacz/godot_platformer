extends Control


func _ready():
	Save.load_data()
	for i in range($Levels.get_child_count()):
		Save.levels.append(i + 1)
	for level in $Levels.get_children():
		if str2var(level.name) in range(Save.unlocked_levels + 1):
			level.disabled = false
			level.connect("pressed", self, "change_level", [level.name])
		else:
			level.disabled = true


func change_level(level_number):
	Save.current_level = level_number
	Save.current_checkpoint = Vector2()
	Save.save_data()
	get_tree().change_scene("res://src/Levels/Level_" + level_number + "/Level_" + level_number + ".tscn")
