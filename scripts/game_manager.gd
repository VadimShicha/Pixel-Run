extends Node

@onready var game_over_panel = %GameOverPanel
@onready var tutorial_panel = %TutorialPanel

@onready var player = %Player

var is_alive = true
var tutorial_open = true

var checkpoint_index = 0
var checkpoint_position = Vector2(-175, 275)

const CHECKPOINT_POSITIONS = [Vector2(-175, 275), Vector2(1951, 275), Vector2(4500, 195)]
	
func _ready():
	get_tree().paused = true
	tutorial_panel.show()
	
func player_die():
	is_alive = false
	get_tree().paused = true
	game_over_panel.show()
	
func player_respawn():
	player.velocity = Vector2.ZERO
	player.position = checkpoint_position
	get_tree().paused = false
	game_over_panel.hide()
	await get_tree().create_timer(0.1).timeout
	is_alive = true
	
func set_checkpoint(index):
	checkpoint_index = index
	checkpoint_position = CHECKPOINT_POSITIONS[index]

func _process(delta):
	if tutorial_open and Input.is_action_just_pressed("jump"):
		tutorial_open = false
		tutorial_panel.hide()
		get_tree().paused = false
	elif !is_alive and Input.is_action_just_pressed("jump"):
		player_respawn()
