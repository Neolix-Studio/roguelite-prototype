extends Node3D

var damage_per_tick: int

func _on_tick_timer_timeout() -> void:
	var affected_enemy = get_parent()
	affected_enemy.take_damage(damage_per_tick)


func _on_duration_timer_timeout() -> void:
	queue_free()
