extends Node2D

@export var year_number: int = 1
@export var room_color: Color = Color.WHITE
@export var next_room_scene: PackedScene = null

@onready var confetti = $Confetti
@onready var year_label = $UI/YearLabel

var confetti_played = false

func _ready():
	year_label.text = "Year " + str(year_number)
	$ColorRect.color = room_color

func _on_door_area_body_entered(body):
	if body.name == "Player" and next_room_scene != null:
		# Trigger confetti
		if not confetti_played:
			confetti.emitting = true
			confetti_played = true
		# Small delay before transition
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(next_room_scene)
