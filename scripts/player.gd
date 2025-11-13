extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_attacking: bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("attack"):
		is_attacking = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	var anim = "idle"

	if direction != 0:
		anim = "run"

	if not is_on_floor():
		anim = "jump"

	if is_attacking:
		anim = "attack"
		# is_attacking = false

	animated_sprite_2d.play(anim)
	
	
	# flip sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
 


func _on_animated_sprite_2d_animation_finished() -> void:
	is_attacking = false


func _on_attack_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemie"):
		print(body.name)
