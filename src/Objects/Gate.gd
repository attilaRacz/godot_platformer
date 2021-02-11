class_name Gate
extends Area2D

onready var transition_screen = $TransitionScreen

func _on_Gate_body_entered(body):
	State.move_to_next_level()
