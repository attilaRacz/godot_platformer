class_name Bullet
extends RigidBody2D


onready var animation_player = $AnimationPlayer


func _on_body_entered(body):
	set_sleeping(true)
	
	if body is Enemy:
		body.destroy()
		queue_free()
	else:
		animation_player.play("destroy")
