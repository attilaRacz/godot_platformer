class_name Bullet
extends RigidBody2D


onready var animation_player = $AnimationPlayer


func destroy():
	animation_player.play("destroy")


func _on_body_entered(body):
	print(body)
	if body is Enemy:
		print("enemy")
		body.destroy()
