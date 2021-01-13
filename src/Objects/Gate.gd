class_name Gate
extends Area2D

func _on_Gate_body_entered(body):
	get_tree().change_scene("res://src/Levels/Level_02/Level_02.tscn")
