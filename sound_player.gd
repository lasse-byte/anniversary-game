extends AudioStreamPlayer

# This script generates simple sound effects procedurally
# For a real game, you would use actual audio files

func play_walk_sound():
	# Simple click sound for walking
	pitch_scale = randf_range(0.9, 1.1)
	play()

func play_door_sound():
	# Higher pitch for door interaction
	pitch_scale = 1.5
	play()

func play_confetti_sound():
	# Fun sound for confetti
	pitch_scale = 1.8
	play()
