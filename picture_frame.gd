extends ColorRect

@onready var picture = $Picture
@onready var label = $Picture/Label
@onready var up_arrow = $UpArrow

func _ready():
	# Check if Picture node has a Sprite2D child for custom texture
	var sprite = picture.get_node_or_null("Sprite2D")
	if sprite and sprite.texture:
		scale_frame_to_texture(sprite.texture)

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
		up_arrow.position.x = size.x / 2 - 20
		up_arrow.position.y = size.y + 10
	
	var detection_area = $DetectionArea
	if detection_area:
		detection_area.position.x = size.x / 2
		detection_area.position.y = size.y + 20

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		up_arrow.visible = true
		body.add_nearby_frame(self)

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		up_arrow.visible = false
		body.remove_nearby_frame(self)

