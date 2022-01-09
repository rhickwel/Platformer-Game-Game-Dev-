extends KinematicBody2D




func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "player":
		get_tree().change_scene("res://Level1.tscn")

func _on_Timer_timeout():
	queue_free()
