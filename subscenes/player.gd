extends RigidBody2D

@onready var frog_arrow = $FrogArrow
@onready var sprite_2d = $Sprite2D


const FROG_ARROW_CENTER_OFFSET = 70
const SPEED = 400
const JUMP_VELOCITY = -770

var move_keys_just_pressed = false # indicates whether the left or right keys were pressed last frame
	
func _process(delta):
	var mouse_position_relative = get_global_mouse_position() - position
	var mouse_direction = mouse_position_relative.normalized()
	
	if mouse_position_relative.x > 0:
		frog_arrow.rotation_degrees = rad_to_deg(atan(mouse_direction.y / mouse_direction.x)) + 90
	elif mouse_position_relative.x < 0:
		frog_arrow.rotation_degrees = rad_to_deg(atan(mouse_direction.y / mouse_direction.x)) + 270
		
	frog_arrow.position = mouse_direction * FROG_ARROW_CENTER_OFFSET
	
	
func _physics_process(delta):
	var is_grounded = snapped(linear_velocity.y, 0.05) == 0
	
	if is_grounded:
		sprite_2d.animation = "default"
		frog_arrow.show()
	else:
		sprite_2d.animation = "fall"
		frog_arrow.hide()
		
	# handle hopping
	if is_grounded and Input.is_action_just_pressed("left_mouse_click"):
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - position).normalized()
		sprite_2d.flip_h = (direction.x > 0)
		apply_impulse(direction * 1100)

	# handle jumping
	if is_grounded and Input.is_action_just_pressed("jump"):
		linear_velocity.y = JUMP_VELOCITY

	# handle movement and stop the player once key is released
	var direction = Input.get_axis("left", "right")
	if direction:
		sprite_2d.flip_h = (direction == 1)
		linear_velocity.x = direction * SPEED
		move_keys_just_pressed = true
	elif move_keys_just_pressed and linear_velocity.x != 0:
		linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
		move_keys_just_pressed = false
