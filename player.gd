extends CharacterBody3D
signal passive_choice_requested
signal health_changed(current_health: int, max_health: int)
signal experience_changed(current_experience: int, experience_to_next_level: int, level: int)
signal died
signal skill_choice_requested

var move_speed = 10.0
var max_health = 100
var current_health: int
var is_dead: bool = false
var current_experience: int = 0
var level: int = 1
var experience_to_next_level: int = 30

@onready var camera: Camera3D = get_viewport().get_camera_3d()

func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)
	experience_changed.emit(current_experience, experience_to_next_level, level)

func _physics_process(delta: float) -> void:
	if is_dead:
		return
		
	var input_direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backward"
	)

	var camera_forward := -camera.global_transform.basis.z
	var camera_right := camera.global_transform.basis.x

	camera_forward.y = 0.0
	camera_right.y = 0.0

	camera_forward = camera_forward.normalized()
	camera_right = camera_right.normalized()

	var direction := (
		camera_right * input_direction.x
		+ camera_forward * -input_direction.y
	)

	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func active_skill(skill_name: String) -> void:
	var skill := get_node(skill_name)
	
	if skill.process_mode == Node.PROCESS_MODE_DISABLED:
		skill.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		skill.upgrade()

func take_damage(amount: int) -> void:
	if is_dead:
		return
	
	current_health -= amount
	
	if current_health <= 0:
		current_health = 0
		die()
		
	health_changed.emit(current_health, max_health)
	print("Your current HP is: ", current_health)
		
func die() -> void:
	is_dead = true
	died.emit()

func gain_experience(amount: int) -> void:
	current_experience += amount
	if current_experience >= experience_to_next_level:
		current_experience -= experience_to_next_level
		level_up()
	experience_changed.emit(current_experience, experience_to_next_level, level)
	print("Your Current XP is: ", current_experience)

func level_up() -> void:
	level += 1
	experience_to_next_level = roundi(experience_to_next_level * 1.25)
	if level % 5 == 0:  #% 5 == 0 → every fifth level
						#% 2 == 0 → every second level
						#% 10 == 0 → every tenth wave
		skill_choice_requested.emit()
	else:
		passive_choice_requested.emit()
		

func increase_max_health(amount: int) -> void:
	max_health += amount
	current_health += amount
	health_changed.emit(current_health, max_health)

func increase_move_speed(amount: float) -> void:
	move_speed += amount

func increase_cleave_damage(amount: int) -> void:
	$Cleave.increase_damage(amount)
