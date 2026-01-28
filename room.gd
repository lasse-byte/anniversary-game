extends Node2D

@export var year_number: int = 1
@export var room_color: Color = Color.WHITE
@export var next_room_scene: PackedScene = null
@export var background_texture: Texture2D = null
@export var floor_texture: Texture2D = null

@onready var confetti = $Confetti
@onready var year_label = $UI/YearLabel

var confetti_played = false

func _ready():
	year_label.text = "Year " + str(year_number)
	
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
	
	# Apply floor texture or color
	var floor_rect = $Floor/ColorRect
	if floor_rect and floor_texture:
		if floor_rect is ColorRect:
			floor_rect = convert_floor_to_texture_rect(floor_rect, floor_texture)
	elif floor_rect and floor_rect is ColorRect:
		# Keep existing color
		pass

func convert_to_texture_rect(color_rect: ColorRect, texture: Texture2D) -> TextureRect:
	"""Convert a ColorRect to a TextureRect with repeating texture"""
	var parent = color_rect.get_parent()
	var rect_pos = color_rect.position
	var rect_size = Vector2(color_rect.offset_right - color_rect.offset_left, 
	                         color_rect.offset_bottom - color_rect.offset_top)
	
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

func convert_floor_to_texture_rect(color_rect: ColorRect, texture: Texture2D) -> TextureRect:
	"""Convert floor ColorRect to TextureRect with repeating texture"""
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

func _on_door_area_body_entered(body):
	if body.name == "Player" and next_room_scene != null:
		# Trigger confetti
		if not confetti_played:
			confetti.emitting = true
			confetti_played = true
		# Small delay before transition
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(next_room_scene)
