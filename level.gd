extends Node2D

var bullet_scene: PackedScene = preload("res://bullet.tscn")

func _on_player_shot(pos, direction):
	var bullet = bullet_scene.instantiate()
	bullet.position = pos
	bullet.rotation = direction.angle()
	bullet.direction = direction
	$Bullets.add_child(bullet)
