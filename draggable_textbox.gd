extends TextEdit

# Static text box for final room (non-draggable, non-editable)

func _ready():
	# Set up the text box appearance and initial text
	text = "Write your message here!\n\nA perfect ending to your journey together!"
	# Make it look nice
	add_theme_color_override("background_color", Color(1.0, 0.95, 0.9, 0.9))
	add_theme_color_override("font_color", Color(0.2, 0.1, 0.15))
	# Make it non-editable
	editable = false
	# Hide cursor
	caret_blink = false
