extends Node

var player: CharacterBody3D

func set_player(plr: CharacterBody3D):
	player = plr
	return true

func is_player_idle():
	if (!player): return null
	return player.direction.length() == 0 and Vector2(player.velocity.x, player.velocity.z).length() < 0.1
