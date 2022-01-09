extends Area2D

const SPEED = 100
var velocity = Vector2()
var DIRECTION = 1

func _ready():
	pass # Replace with function body.


func set_bulllet_direction(dir):
	DIRECTION = dir
	if dir == -1:
		$Sprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * DIRECTION
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_bullet_body_entered(body):
	if "enemy" in body.name:
		body.dead()
	queue_free()
