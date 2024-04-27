extends CharacterBody2D

@onready var sprite_2d = $Sprite2D

const SPEED = 400
const JUMP_VELOCITY = -770

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var gravity_direction = 1

func _input(event):
	if event.is_action_pressed("left_mouse_click"):
		if gravity_direction == 1:
			gravity_direction = -1
			sprite_2d.flip_v = true
		else:
			gravity_direction = 1
			sprite_2d.flip_v = false
		

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		if gravity_direction == 1:
			velocity.y += gravity * 2 * delta
	if not is_on_ceiling():
		if gravity_direction == -1:
			velocity.y -= gravity * 2 * delta
		
	# Handle jump
	if Input.is_action_just_pressed("jump"):
		if gravity_direction == 1 and is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif gravity_direction == -1 and is_on_ceiling():
			velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()