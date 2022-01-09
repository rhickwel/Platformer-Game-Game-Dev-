extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 300
const ACCEL = 10
const BULLET = preload("res://bullet.tscn")
const TYPE = "player"
var facing_right
var motion = Vector2()
var is_dead = false
onready var control = $CanvasLayer/lives
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	if is_dead == false:
	
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED 
			
		if facing_right == true:
			$Sprite.scale.x = 1
		else:
			$Sprite.scale.x = -1
		motion.x = clamp(motion.x,-MAXSPEED,MAXSPEED)
		
		
		
		if Input.is_action_pressed("right"):
			motion.x += ACCEL
			facing_right = true
			$AnimationPlayer.play("run")
			
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
			
			
				
		elif Input.is_action_pressed("left"):
			motion.x -= ACCEL
			facing_right = false
			$AnimationPlayer.play("run")
			
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
			
			
		else:
			motion.x = lerp(motion.x,0,0.2)
			$AnimationPlayer.play("idle")
		
		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				motion.y = - JUMPFORCE
			
		
		if !is_on_floor():
			if motion.y < 0:
				$AnimationPlayer.play("jump")
			elif motion.y > 0:
				$AnimationPlayer.play("fall")
				
		if get_slide_count() > 0:
				for i in range(get_slide_count()):
					if "enemy" in get_slide_collision(i).collider.name:
						dead()
							
		if Input.is_action_just_pressed("attack"):
			var bullet = BULLET.instance()
			$AnimationPlayer.play("attack")
			
			if sign($Position2D.position.x) == 1:
				bullet.set_bulllet_direction(1)
			else:
				bullet.set_bulllet_direction(-1)
			get_parent().add_child(bullet)
			bullet.position = $Position2D.global_position
			
			
		
			
		motion = move_and_slide(motion, UP)

func dead():
	is_dead = true
	motion = Vector2(0, 0)
	$CollisionShape2D.disabled = true
	$Timer.start()
	
	

func _melee_attack(body):
	if "enemy" in body.name:
		body.dead()
	queue_free()



func _on_Timer_timeout():
	Global.num_lives -= 1
	get_tree().reload_current_scene()
	if Global.num_lives == 0:
		get_tree().change_scene("TitleScreen.tscn")
