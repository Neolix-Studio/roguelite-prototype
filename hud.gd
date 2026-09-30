extends CanvasLayer


func _on_player_health_changed(current_health: int, max_health: int) -> void:
	$MarginContainer/VBoxContainer/HealthLabel.text = ("Health: " + str(current_health) + " / " + str(max_health))

func _on_player_experience_changed(current_experience: int, experience_to_next_level: int, level: int) -> void:
	$MarginContainer/VBoxContainer/ExperienceLabel.text = ("Experience: " +str(current_experience) + " / " + str(experience_to_next_level))
	$MarginContainer/VBoxContainer/LevelLabel.text = ("Level: " + str(level))

func _on_enemy_spawner_wave_changed(current_wave: int) -> void:
	$MarginContainer/VBoxContainer/WaveLabel.text = ("Wave: " + str(current_wave))
