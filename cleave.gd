extends Area3D

var damage: int = 30

func _on_cooldown_timer_timeout() -> void:
	var bodies_in_range := get_overlapping_bodies()
	
	for body in bodies_in_range:
		if body.is_in_group("enemies"):
			body.take_damage(damage)

func increase_damage(amount: int) -> void:
	damage += amount

func upgrade() -> void:
	increase_damage(10)
