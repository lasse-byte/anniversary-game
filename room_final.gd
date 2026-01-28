extends Node2D

# Final room script - static full-screen view with immediate confetti

@export var room_color: Color = Color.WHITE

@onready var confetti_left = $ConfettiLeft
@onready var confetti_right = $ConfettiRight
@onready var text_box = $TextBox

func _ready():
	$ColorRect.color = room_color
	
	# Trigger confetti immediately when room loads
	await get_tree().create_timer(0.5).timeout
	confetti_left.emitting = true
	confetti_right.emitting = true
