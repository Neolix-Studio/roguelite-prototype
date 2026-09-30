extends Area3D

var target: Node3D
var move_speed: float = 10.0
var splash_damage: int
var direct_damage: int


func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		queue_free()
		return
		
	var distance := move_speed * delta
	
	global_position = global_position.move_toward(target.global_position, distance)
	
	var distance_to_target := global_position.distance_to(target.global_position)
	if distance_to_target < 0.1:
		explode()
		return
			
			
func explode() -> void:
	if is_instance_valid(target):
		target.take_damage(direct_damage)
		
	var bodies_in_range := get_overlapping_bodies()
	
	for body in bodies_in_range:
		if body.is_in_group("enemies") and body != target:
			body.take_damage(splash_damage)
			
	queue_free()
			
			
