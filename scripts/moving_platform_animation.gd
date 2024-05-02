extends AnimationPlayer

func _ready():
	play("platform_move")
	seek(snapped(randf_range(0, 1.5), 0.01), false)
