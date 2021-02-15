extends CanvasLayer

onready var animation_player = $AnimationPlayer

signal transitioned

func _ready():
	get_child(0).hide()

func fade_in():
	get_child(0).show()
	animation_player.play("fade_in")
	

func fade_out():
	animation_player.play("fade_out")


func _on_TransitionScreen_transitioned():
	get_child(0).hide()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_in":
		emit_signal("transitioned")
