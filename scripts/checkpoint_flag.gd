extends Area2D

@export var checkpoint_index = 0

@onready var game_manager = %GameManager
@onready var enter_particle_emitter = $EnterParticleEmitter

func _on_body_entered(body):
	if body.get_class() == "CharacterBody2D":
		game_manager.set_checkpoint(checkpoint_index)
		enter_particle_emitter.emitting = true
		await get_tree().create_timer(1).timeout
		enter_particle_emitter.emitting = false

