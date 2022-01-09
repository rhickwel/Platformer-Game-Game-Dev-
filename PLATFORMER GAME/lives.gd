extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var lives_label = $Panel/MarginContainer/HBoxContainer/nlives

# Called when the node enters the scene tree for the first time.
func _ready():
	lives_label.text = String(Global.num_lives)


func reduce_life():
	Global.num_lives -=1
	lives_label.text = String(Global.num_lives)
