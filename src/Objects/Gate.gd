class_name Gate
extends Area2D


func _on_Gate_body_entered(body):
	Save.current_level += 1
	Save.unlocked_levels += 1
	get_tree().change_scene(str("res://src/Levels/Level_", Save.current_level, "/Level_", Save.current_level, ".tscn"))
	Save.save_data()
