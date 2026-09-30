extends Node3D

@export var curse_zone: PackedScene

var damage_per_tick: int = 3


func _on_cooldown_timer_timeout() -> void:
	var enemies := get_tree().get_nodes_in_group("enemies")
	
	if enemies.is_empty():
		return
	var closest_enemy = enemies[0]
	var closest_distance := global_position.distance_to(closest_enemy.global_position)
	
	for enemy in enemies:
		var distance_to_enemy := global_position.distance_to(enemy.global_position)
		
		if distance_to_enemy < closest_distance:
			closest_enemy = enemy
			closest_distance = distance_to_enemy

	var new_zone = curse_zone.instantiate()
	new_zone.damage_per_tick = damage_per_tick
	get_tree().current_scene.add_child(new_zone)
	
	var zone_position: Vector3 = closest_enemy.global_position
	zone_position.y = 0.1
	new_zone.global_position = zone_position
	
func upgrade() -> void:
	damage_per_tick += 1
