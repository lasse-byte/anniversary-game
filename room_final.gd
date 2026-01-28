extends Node2D

# Final room script with center detection for confetti trigger

@export var room_color: Color = Color.WHITE

@onready var confetti_left = $ConfettiLeft
@onready var confetti_right = $ConfettiRight
@onready var text_box = $DraggableTextBox

var confetti_played = false

func _ready():
	$ColorRect.color = room_color

func _on_center_area_body_entered(body):
	if body.name == "Player" and not confetti_played:
		# Trigger confetti from both sides
		confetti_left.emitting = true
		confetti_right.emitting = true
		confetti_played = true
