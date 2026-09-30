extends Node3D

@export var projectile_scene: PackedScene

var direct_damage: int = 30


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
	
	var new_projectile = projectile_scene.instantiate()
	new_projectile.direct_damage = direct_damage
	new_projectile.splash_damage = roundi(direct_damage * 0.5)
	new_projectile.target = closest_enemy
	get_tree().current_scene.add_child(new_projectile)
	new_projectile.global_position = global_position
	
func upgrade() -> void:
	direct_damage += 10
