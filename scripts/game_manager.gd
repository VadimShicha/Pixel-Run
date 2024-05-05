extends Node

@export var checkpoint4_coins: Array[Node2D] = []
@export var checkpoint5_coins: Array[Node2D] = []

@onready var game_over_panel = %GameOverPanel
@onready var tutorial_panel = %TutorialPanel
@onready var pause_panel = %PausePanel
@onready var pause_panel_return_home_button = %ReturnHomeButton
@onready var coin_amount_label = %CoinAmountLabel

@onready var game_coins = %GameCoins

@onready var player = %Player

var is_alive = true
var coin_amount = 0
var collected_coins = []

enum UITypeOpen {NONE, TUTORIAL, GAMEOVER, PAUSEMENU}

var ui_open = UITypeOpen.NONE

var checkpoint_index = 0
var checkpoint_position = Vector2(-175, 275)

#var last_coin_id = -1


const CHECKPOINT_POSITIONS = [
	Vector2(-150, 275),
	Vector2(1951, 275),
	Vector2(4600, 195),
	Vector2(7750, -616),
	Vector2(7200, -2250)
]

func _ready():
	player_die()
	set_checkpoint(3)
	
	
#func init_coin_id():
	#last_coin_id += 1
	#return last_coin_id
	
#func collect_coin(checkpoint_index, coin_index):
	#collected_coins.append([checkpoint_index, coin_index])
	
func collect_coin(coin_self):
	collected_coins.append(coin_self)
	
func set_coin_amount(amount):
	coin_amount = amount
	coin_amount_label.text = str(coin_amount)
	
#func get_checkpoint_coin_list(checkpoint_index):
	#if checkpoint_index == 3:
		#return checkpoint4_coins
	#elif checkpoint_index == 4:
		#return checkpoint5_coins
	#else:
		#return null
	#var coins_children = game_coins.get_children()
	#for i in range(len(coins_children)):
		#var checkpoint_node = coins_children[i]
		#var checkpoint_node_children = checkpoint_node.get_children()
		#
		#if checkpoint_node.name == "Checkpoint" + str(checkpoint_index + 1):
			#for j in range(len(checkpoint_node_children)):
				#if checkpoint_node_children[i].name == "Coin" + str(coin_index + 1):
					#return checkpoint_node_children[i]
	#return null
	
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
	for i in range(len(collected_coins)):
		collected_coins[i].show()
		#get_checkpoint_coin_list(collected_coins[i])[collected_coins[i][1]].show()
		#var coin_node = get_coin_node(collected_coins[i][0], collected_coins[i][1])
		#if coin_node != null:
			#coin_node.show()
		#else:
			#print(collected_coins)
		
	collected_coins = []
	
func set_checkpoint(index):
	# if the checkpoint reached is higher than last checkpoint
	if checkpoint_index < index:
		set_coin_amount(coin_amount + len(collected_coins))
	else:
		for i in range(len(collected_coins)):
			collected_coins[i].show()
			#get_checkpoint_coin_list(collected_coins[i][0])[collected_coins[i][1]].show()
			
	collected_coins = []
		
	checkpoint_index = index
	checkpoint_position = CHECKPOINT_POSITIONS[index]

func _process(delta):
	print(collected_coins)
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
