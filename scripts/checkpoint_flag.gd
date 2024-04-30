extends Area2D

@export var checkpoint_index = 0

@onready var game_manager = %GameManager

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		game_manager.set_checkpoint(checkpoint_index)
