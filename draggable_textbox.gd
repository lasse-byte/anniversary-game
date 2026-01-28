extends TextEdit

# Draggable text box that can be moved around with the mouse

var dragging = false
var drag_offset = Vector2.ZERO

func _ready():
	# Set up the text box appearance and initial text
	text = "Write your message here!\n\nDrag me around to position me wherever you want!"
	# Make it look nice
	add_theme_color_override("background_color", Color(1.0, 0.95, 0.9, 0.9))
	add_theme_color_override("font_color", Color(0.2, 0.1, 0.15))

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Check if mouse is over the text box
				var mouse_pos = get_global_mouse_position()
				var rect = Rect2(global_position, size)
				if rect.has_point(mouse_pos):
					dragging = true
					drag_offset = global_position - mouse_pos
			else:
				dragging = false
	
	elif event is InputEventMouseMotion and dragging:
		# Move the text box
		global_position = get_global_mouse_position() + drag_offset
