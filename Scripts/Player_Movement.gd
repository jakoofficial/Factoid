extends CharacterBody2D

@export var spd: float = 10.0
@export var jump_force: float = 100
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var grav: float = 10.0
var move: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	move.x = Input.get_axis("LEFT", "RIGHT")
	
	_animation_controller()
	
	if not is_on_floor():
		velocity.y += grav
	elif Input.is_action_just_pressed("JUMP"): velocity.y -= jump_force
	velocity.x = move.x * spd
	move_and_slide()

func _animation_controller():
	if move.x == 1: anim.flip_h = false
	elif move.x == -1: anim.flip_h = true
	
	if velocity.x != 0:
		anim.play("run")
	else:
		anim.play("default")
	
	#if velocity.y > 0 and not is_on_floor(): anim.play("jump")
	if velocity.y > 0 and not is_on_floor(): anim.play("fall")
