extends Area3D

@export var curse_debuff: PackedScene

var damage_per_tick: int

func _on_apply_timer_timeout() -> void:
	var bodies_in_range := get_overlapping_bodies()
	
	for body in bodies_in_range:
		if body.is_in_group("enemies"):
			var new_debuff = curse_debuff.instantiate()
			new_debuff.damage_per_tick = damage_per_tick
			body.add_child(new_debuff)
			
	queue_free()
