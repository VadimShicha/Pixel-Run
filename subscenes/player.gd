extends RigidBody2D

const SPEED = 400
const JUMP_VELOCITY = -770

var move_keys_just_pressed = false # indicates whether the left or right keys were pressed last frame

func _physics_process(delta):
	
	# handle
	if Input.is_action_just_pressed("left_mouse_click"):
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - position).normalized()
		apply_impulse(direction * 1100)

	# handle jumping
	if Input.is_action_just_pressed("jump"):
		linear_velocity.y = JUMP_VELOCITY

	# handle movement and stop the player once key is released
	var direction = Input.get_axis("left", "right")
	if direction:
		linear_velocity.x = direction * SPEED
		move_keys_just_pressed = true
	elif move_keys_just_pressed and linear_velocity.x != 0:
		linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
		move_keys_just_pressed = false
