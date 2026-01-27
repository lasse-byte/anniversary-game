extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D

func _ready():
	# Create a simple colored rectangle as sprite
	sprite.texture = create_player_texture()

func create_player_texture() -> ImageTexture:
	var img = Image.create(32, 48, false, Image.FORMAT_RGBA8)
	img.fill(Color(0.8, 0.4, 0.6, 1))
	return ImageTexture.create_from_image(img)

func _physics_process(delta):
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
