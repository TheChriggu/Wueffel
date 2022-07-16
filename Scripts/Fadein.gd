extends ColorRect


signal on_fadeIn_finished

func fadeIn():
	$AnimationPlayer.play("fadeIn")



func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("on_fadeIn_finished")
