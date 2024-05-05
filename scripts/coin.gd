extends Area2D

@onready var game_manager = %GameManager

@export var coin_checkpoint_index = 0
@export var coin_index = 0

var collected = false
##var coin_id = -1

#func _ready():
	#coin_id = game_manager.init_coin_id()
	#print(coin_id)

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D" and is_visible_in_tree():
		print("COLLECT " + str(coin_checkpoint_index) + " : " + str(coin_index))
		#game_manager.collect_coin(coin_checkpoint_index, coin_index)
		game_manager.collect_coin(self)
		hide()
