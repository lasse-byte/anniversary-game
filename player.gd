extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D
@onready var camera = $Camera2D

var viewing_frame = false
var current_frame: Node2D = null
var nearby_frames = []

func _ready():
	# Create a simple colored rectangle as sprite
	sprite.texture = create_player_texture()

func create_player_texture() -> ImageTexture:
	var img = Image.create(32, 48, false, Image.FORMAT_RGBA8)
	img.fill(Color(0.8, 0.4, 0.6, 1))
	return ImageTexture.create_from_image(img)

func _physics_process(delta):
	# Handle frame viewing
	if viewing_frame:
		# When viewing a frame, don't move but allow exit
		if Input.get_axis("move_left", "move_right") != 0 or Input.is_action_just_pressed("ui_accept"):
			exit_frame_view()
		return
	
	# Check if we can view a frame
	if nearby_frames.size() > 0 and Input.is_action_just_pressed("ui_up"):
		enter_frame_view(nearby_frames[0])
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		# Flip sprite based on direction
		sprite.flip_h = direction < 0
		if is_on_floor():
			animation_player.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animation_player.play("idle")
	
	if not is_on_floor():
		animation_player.play("jump")

	move_and_slide()

func enter_frame_view(frame: Node2D):
	viewing_frame = true
	current_frame = frame
	
	# Smoothly move camera to frame
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	# Calculate frame position in global coordinates
	var frame_global_pos = frame.global_position
	# Adjust for frame center (frames are positioned by top-left)
	var frame_size = frame.size if frame.has_method("get_size") or "size" in frame else Vector2(120, 160)
	frame_global_pos += frame_size / 2
	
	# Calculate offset needed (frame position - player position)
	var offset = frame_global_pos - global_position
	tween.tween_property(camera, "offset", offset, 0.5)

func exit_frame_view():
	viewing_frame = false
	current_frame = null
	
	# Return camera to player
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(camera, "offset", Vector2.ZERO, 0.5)

func add_nearby_frame(frame: Node2D):
	if frame not in nearby_frames:
		nearby_frames.append(frame)

func remove_nearby_frame(frame: Node2D):
	nearby_frames.erase(frame)

func has_nearby_frames() -> bool:
	return nearby_frames.size() > 0

