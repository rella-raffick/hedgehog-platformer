extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animate = get_node("AnimationPlayer")
@onready var sprite = get_node("PlayerSprite")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if velocity.y != 0:
			animate.play("Jump")
			
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		sprite.flip_h = true
	elif direction == 1:
		sprite.flip_h = false
		
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animate.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animate.play("Idle")
			
	if velocity.y > 0:
		animate.play("Fall")
		
	move_and_slide()
