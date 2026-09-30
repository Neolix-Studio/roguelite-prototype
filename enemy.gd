extends CharacterBody3D

@export var target: Node3D
@export var experience_reward: int = 10

var move_speed = 3.0
var damage: int = 10
var attack_range: float = 1.5
var max_health: int = 100
var current_health: int
var is_dead: bool = false


func _ready() -> void:
	current_health = max_health

func _physics_process(delta: float) -> void:
	if target:
		var direction
		direction = target.global_position - global_position
		
		direction.y = 0.0
		direction = direction.normalized()
		
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func configure_for_wave(wave_number: int) -> void:
	var bonus_wave := wave_number - 1
	max_health += bonus_wave * 10
	damage += bonus_wave

func _on_attack_timer_timeout() -> void:
	if target:
		var offset_to_target := target.global_position - global_position
		offset_to_target.y = 0.0
		var distance_to_target := offset_to_target.length()

		if distance_to_target <= attack_range:
			target.take_damage(damage)

func take_damage(amount: int) -> void:
	if is_dead:
		return
	
	current_health -= amount
	
	if current_health <= 0:
		current_health = 0
		die()
		
		
func die() -> void:
	is_dead = true
	if target:
		target.gain_experience(experience_reward)
	queue_free()
