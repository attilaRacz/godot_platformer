class_name Gate
extends Area2D


func _on_Gate_body_entered(body):
	Save.current_level += 1
	Save.current_checkpoint = Vector2()
	if Save.unlocked_levels < Save.current_level:
		Save.unlocked_levels = Save.current_level
	get_tree().change_scene(str("res://src/Levels/Level_", Save.current_level, "/Level_", Save.current_level, ".tscn"))
	Save.save_data()
