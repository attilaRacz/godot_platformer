extends Control


func _ready():
	State.load_data()
	for i in range($Levels.get_child_count()):
		State.levels.append(i + 1)
	for level in $Levels.get_children():
		if str2var(level.name) in range(State.unlocked_levels + 1):
			level.disabled = false
			level.connect("pressed", self, "change_level", [level.name])
		else:
			level.disabled = true


func change_level(level_number):
	State.current_level = level_number
	State.current_checkpoint = Vector2()
	State.save_data()
	State.move_to_level(level_number)
