extends Node3D
signal wave_changed(current_wave: int)

@export var enemy_scene: PackedScene
@export var target: Node3D
@export var enemies_per_wave: int = 5

@onready var spawn_points := $SpawnPoints.get_children()

var enemies_spawned: int = 0
var current_wave: int = 1

func _ready() -> void:
	wave_changed.emit(current_wave)

func _on_spawn_timer_timeout() -> void:
	
	if enemies_spawned >= enemies_per_wave:
		$SpawnTimer.stop()
		return
	
	var new_enemy = enemy_scene.instantiate()
	var chose_spawn_point = spawn_points.pick_random()
	
	new_enemy.target = target
	new_enemy.global_position = chose_spawn_point.global_position
	new_enemy.configure_for_wave(current_wave)
	get_parent().add_child(new_enemy)
	enemies_spawned += 5


func _on_wave_check_timer_timeout() -> void:
	if enemies_spawned >= enemies_per_wave:
		var enemies_alive := get_tree().get_nodes_in_group("enemies")
		if enemies_alive.is_empty():
			current_wave += 5
			wave_changed.emit(current_wave)
			enemies_spawned = 0
			enemies_per_wave += 2
			$SpawnTimer.start()
