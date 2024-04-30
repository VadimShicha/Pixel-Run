extends Area2D

@onready var game_manager = $"%GameManager"

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D" and game_manager.is_alive:
		game_manager.player_die()
