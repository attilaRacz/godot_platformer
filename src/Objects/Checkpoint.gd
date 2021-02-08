extends Area2D

onready var animation_player = $AnimationPlayer

func _on_Checkpoint_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name == 'Player':
		animation_player.play("save_checkpoint")
		body.hit_checkpoint()
