extends Node2D

# Final room script - static full-screen view with immediate confetti

@export var room_color: Color = Color.WHITE
@export var background_texture: Texture2D = null

@onready var confetti_left = $ConfettiLeft
@onready var confetti_right = $ConfettiRight
@onready var text_box = $TextBox

func _ready():
	# Apply background texture or color
	var bg_rect = $ColorRect
	if background_texture:
		# Convert ColorRect to TextureRect if needed
		if bg_rect is ColorRect:
			bg_rect = convert_to_texture_rect(bg_rect, background_texture)
	else:
		# Use solid color
		if bg_rect is ColorRect:
			bg_rect.color = room_color
	
	# Trigger confetti immediately when room loads
	await get_tree().create_timer(0.5).timeout
	confetti_left.emitting = true
	confetti_right.emitting = true

func convert_to_texture_rect(color_rect: ColorRect, texture: Texture2D) -> TextureRect:
	"""Convert a ColorRect to a TextureRect with repeating texture"""
	var parent = color_rect.get_parent()
	
	# Create new TextureRect
	var texture_rect = TextureRect.new()
	texture_rect.texture = texture
	texture_rect.stretch_mode = TextureRect.STRETCH_TILE
	texture_rect.offset_left = color_rect.offset_left
	texture_rect.offset_top = color_rect.offset_top
	texture_rect.offset_right = color_rect.offset_right
	texture_rect.offset_bottom = color_rect.offset_bottom
	
	# Replace in scene tree
	parent.add_child(texture_rect)
	parent.move_child(texture_rect, color_rect.get_index())
	color_rect.queue_free()
	
	return texture_rect
