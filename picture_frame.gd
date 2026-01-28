extends ColorRect

# HOW TO ADJUST DESCRIPTION TEXT POSITION:
# By default, description text is automatically positioned UNDER the frame.
# 
# To manually position the description text:
# 1. Open a room scene (e.g., room1.tscn) in Godot
# 2. Select a PictureFrame node (e.g., "PictureFrame1") in the scene tree
# 3. In the Inspector panel, find "Script Variables" section
# 4. Check "Use Custom Description Position" to enable manual positioning
# 5. Expand the PictureFrame node and select the "DescriptionText" child node
# 6. In the Inspector panel, adjust the Layout properties:
#    - offset_top: Controls vertical position (higher = further down)
#    - offset_left: Controls left edge position
#    - offset_right: Controls right edge position
# 7. Save the scene (Ctrl+S or Cmd+S)
# 
# Note: The custom position will be preserved when you drag the text in the editor,
# as long as "Use Custom Description Position" is checked.

const DEFAULT_DESCRIPTION_TEXT = "A beautiful memory from our journey together"

@export var description_text: String = DEFAULT_DESCRIPTION_TEXT
@export var use_custom_description_position: bool = false  # Set to true to preserve manual positioning

@onready var picture = $Picture
@onready var label = $Picture/Label
@onready var up_arrow = $UpArrow
@onready var description_label = $DescriptionText

var fade_tween: Tween

func _ready():
	# Set the description text from the export variable only if the export was customized
	# This allows both: 1) Setting text in the editor on the Label node, and
	# 2) Setting text via the export variable when instantiating programmatically
	if description_label:
		# Only override if export variable was changed from default
		if description_text != DEFAULT_DESCRIPTION_TEXT:
			description_label.text = description_text
	
	# Check if Picture node has a Sprite2D child for custom texture
	var sprite = picture.get_node_or_null("Sprite2D")
	if sprite and sprite.texture:
		# Scale frame to fit texture, which will also reposition description text
		# (unless user has enabled custom positioning)
		scale_frame_to_texture(sprite.texture)
	else:
		# For default-sized frames, auto-position if not using custom position
		if not use_custom_description_position:
			position_description_text_under_frame()

func scale_frame_to_texture(texture: Texture2D):
	if not texture:
		return
	
	# Get texture size
	var tex_size = texture.get_size()
	
	# Safety check for invalid dimensions
	if tex_size.y == 0 or tex_size.x == 0:
		push_warning("Texture has zero dimension - cannot scale frame")
		return
	
	# Additional check for negative dimensions (should never happen, but indicates serious issue)
	if tex_size.y < 0 or tex_size.x < 0:
		push_error("Texture has negative dimensions - this should not happen!")
		return
	
	# Calculate aspect ratio
	var aspect_ratio = tex_size.x / tex_size.y
	
	# Set a max size for the frame (so pictures don't get too big)
	var max_width = 200.0
	var max_height = 200.0
	
	var new_width = max_width
	var new_height = max_width / aspect_ratio
	
	# If height exceeds max, scale by height instead
	if new_height > max_height:
		new_height = max_height
		new_width = max_height * aspect_ratio
	
	# Update frame size
	size = Vector2(new_width + 20, new_height + 20)  # +20 for frame border
	
	# Update picture size (centered in frame)
	picture.offset_left = -new_width / 2
	picture.offset_right = new_width / 2
	picture.offset_top = -new_height / 2
	picture.offset_bottom = new_height / 2
	
	# Hide the emoji label if we have a real texture
	if label:
		label.visible = false
	
	# Reposition arrow and detection area
	if up_arrow:
		up_arrow.offset_left = size.x / 2 - 20
		up_arrow.offset_right = size.x / 2 + 20
		up_arrow.offset_top = size.y + 488
		up_arrow.offset_bottom = size.y + 518
	
	var detection_area = $DetectionArea
	if detection_area:
		detection_area.position.x = size.x / 2
		detection_area.position.y = 488 + 20  # Position on floor level
	
	# Update description text position to be UNDER the frame
	# unless user has set a custom position
	if not use_custom_description_position:
		position_description_text_under_frame()

func position_description_text_under_frame():
	# Position the description text directly under the frame, regardless of frame size.
	# Text width adapts to frame width for better appearance.
	if not description_label:
		return
	
	var text_margin = 10.0  # Space between frame bottom and text
	var text_height = 40.0  # Height of the text area
	
	# Make text width responsive to frame width, but with reasonable limits
	var min_text_width = 200.0  # Minimum width for readability
	var max_text_width = 320.0  # Maximum width to prevent excessive spreading
	var text_width = clamp(size.x + 100.0, min_text_width, max_text_width)
	
	description_label.offset_top = size.y + text_margin
	description_label.offset_bottom = size.y + text_margin + text_height
	description_label.offset_left = (size.x - text_width) / 2
	description_label.offset_right = (size.x + text_width) / 2

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		# Arrow removed - no longer shown
		if body.has_method("add_nearby_frame"):
			body.add_nearby_frame(self)
		# Fade in description text
		fade_in_description_text()

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		# Arrow removed - no longer shown
		if body.has_method("remove_nearby_frame"):
			body.remove_nearby_frame(self)
		# Fade out description text
		fade_out_description_text()

func fade_in_description_text():
	if not description_label:
		return
	
	# Kill any existing tween
	if fade_tween:
		fade_tween.kill()
	
	# Create new tween for fade in (1.5 seconds for slower fade)
	fade_tween = create_tween()
	fade_tween.set_ease(Tween.EASE_OUT)
	fade_tween.set_trans(Tween.TRANS_CUBIC)
	fade_tween.tween_property(description_label, "modulate:a", 1.0, 1.5)

func fade_out_description_text():
	if not description_label:
		return
	
	# Kill any existing tween
	if fade_tween:
		fade_tween.kill()
	
	# Create new tween for fade out (1.5 seconds for slower fade)
	fade_tween = create_tween()
	fade_tween.set_ease(Tween.EASE_IN)
	fade_tween.set_trans(Tween.TRANS_CUBIC)
	fade_tween.tween_property(description_label, "modulate:a", 0.0, 1.5)

