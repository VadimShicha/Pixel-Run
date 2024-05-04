extends Node

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_shop_button_pressed():
	get_tree().change_scene_to_file("res://scenes/shop.tscn")
