extends Node

@onready var game_over_panel = %GameOverPanel
@onready var tutorial_panel = %TutorialPanel
@onready var pause_panel = %PausePanel
@onready var pause_panel_return_home_button = %ReturnHomeButton

@onready var player = %Player

var is_alive = true
#var tutorial_open = false

enum UITypeOpen {NONE, TUTORIAL, GAMEOVER, PAUSEMENU}

var ui_open = UITypeOpen.NONE

var checkpoint_index = 0
var checkpoint_position = Vector2(-175, 275)

const CHECKPOINT_POSITIONS = [
	Vector2(-150, 275),
	Vector2(1951, 275),
	Vector2(4600, 195),
	Vector2(7750, -616),
	Vector2(7200, -2250)
	]

func _ready():
	player_die()
	set_checkpoint(4)
	
func show_tutorial():
	ui_open = UITypeOpen.TUTORIAL
	get_tree().paused = true
	tutorial_panel.show()
	
func hide_tutorial():
	ui_open = UITypeOpen.NONE
	get_tree().paused = false
	tutorial_panel.hide()
	
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
	if ui_open == UITypeOpen.TUTORIAL and Input.is_action_just_pressed("jump"):
		hide_tutorial()
	elif ui_open == UITypeOpen.PAUSEMENU and Input.is_action_just_pressed("jump"):
		hide_pause_menu()
	elif !is_alive and Input.is_action_just_pressed("jump"):
		player_respawn()


func _on_pause_button_pressed():
	ui_open = UITypeOpen.PAUSEMENU
	get_tree().paused = true
	pause_panel.show()

func hide_pause_menu():
	ui_open = UITypeOpen.NONE
	get_tree().paused = false
	pause_panel.hide()

func _on_return_home_button_pressed():
	ui_open = UITypeOpen.NONE
	get_tree().paused = false
	pause_panel.hide()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
