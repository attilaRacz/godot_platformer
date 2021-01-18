class_name Gate
extends Area2D


func _on_Gate_body_entered(body):
	State.move_to_next_level()
