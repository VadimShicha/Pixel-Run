extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		game_manager.set_coin_amount(game_manager.coin_amount + 1)
		queue_free()
