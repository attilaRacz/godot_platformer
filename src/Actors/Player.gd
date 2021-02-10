class_name Player
extends Actor


export(String) var action_suffix = ""

onready var platform_detector = $PlatformDetector
onready var animation_player = $AnimationPlayer
onready var shoot_timer = $ShootAnimation
onready var sprite = $Sprite
onready var gun = sprite.get_node(@"Gun")

const FLOOR_DETECT_DISTANCE = 20.0
const WALL_SLIDE_ACCELERATION = 10
const MAX_WALL_SLIDE_SPEED = 50

var double_jumps = 0
var max_num_double_jumps = 2
var can_double_jump = false
var is_alive = true


func _ready():
	# Static types are necessary here to avoid warnings.
	if !State.play_from_start_of_stage:
		set_global_position(State.current_checkpoint)
	var camera: Camera2D = $Camera
	if action_suffix == "_p1":
		camera.custom_viewport = $"../.."
	elif action_suffix == "_p2":
		var viewport: Viewport = $"../../../../ViewportContainer2/Viewport"
		viewport.world_2d = ($"../.." as Viewport).world_2d
		camera.custom_viewport = viewport


# Physics process is a built-in loop in Godot.
# If you define _physics_process on a node, Godot will call it every frame.

# We use separate functions to calculate the direction and velocity to make this one easier to read.
# At a glance, you can see that the physics process loop:
# 1. Calculates the move direction.
# 2. Calculates the move velocity.
# 3. Moves the character.
# 4. Updates the sprite direction.
# 5. Shoots bullets.
# 6. Updates the animation.

# Splitting the physics process logic into functions not only makes it
# easier to read, it help to change or improve the code later on:
# - If you need to change a calculation, you can use Go To -> Function
#   (Ctrl Alt F) to quickly jump to the corresponding function.
# - If you split the character into a state machine or more advanced pattern,
#   you can easily move individual functions.
func _physics_process(_delta):
	if is_alive:
		if is_on_floor(): double_jumps = max_num_double_jumps
		
		if Input.is_action_just_pressed("jump"):
			if double_jumps > 0:
				double_jumps -= 1
				can_double_jump = true
			else: can_double_jump = false
		
		var direction = get_direction()

		var is_jump_interrupted = Input.is_action_just_released("jump" + action_suffix) and _velocity.y < 0.0
		_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)

		var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
		var is_on_platform = platform_detector.is_colliding()
		_velocity = move_and_slide_with_snap(
			_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false
		)

		# When the character’s direction changes, we want to to scale the Sprite accordingly to flip it.
		# This will make Robi face left or right depending on the direction you move.
		if direction.x != 0:
			sprite.scale.x = 1 if direction.x > 0 else -1

		# We use the sprite's scale to store the players look direction which allows us to shoot
		# bullets forward.
		var is_shooting = false
		if Input.is_action_just_pressed("shoot" + action_suffix):
			is_shooting = gun.shoot(sprite.scale.x)
			
		if is_on_wall() && (Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left")):
			if _velocity.y >= 0.0:
				_velocity.y = min(_velocity.y + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
		
		check_if_collided_with_enemy()
		
		play_animation(is_shooting)

func play_animation(_is_shooting):
	var animation = get_new_animation(_is_shooting)
	if animation != animation_player.current_animation and shoot_timer.is_stopped():
		if _is_shooting:
			shoot_timer.start()
		animation_player.play(animation)

func check_if_collided_with_enemy():
	if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()

func dead():
	is_alive = false
	animation_player.play("dead")
	Game.kill_player()

func get_direction():
	return Vector2(
		Input.get_action_strength("move_right" + action_suffix) - Input.get_action_strength("move_left" + action_suffix),
		-1 if (is_on_floor() || is_on_wall() || can_double_jump) and Input.is_action_just_pressed("jump" + action_suffix) else 0
	)


# This function calculates a new velocity whenever you need it.
# It allows you to interrupt jumps.
func calculate_move_velocity(
		linear_velocity,
		direction,
		speed,
		is_jump_interrupted
	):
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		# Decrease the Y velocity by multiplying it, but don't set it to 0
		# as to not be too abrupt.
		velocity.y *= 0.6
	return velocity


func hit_checkpoint():
	State.current_checkpoint = global_position
	State.play_from_start_of_stage = false
	State.save_data()

func get_new_animation(is_shooting = false):
	var animation_new = ""
	if is_on_floor():
		animation_new = "run" if abs(_velocity.x) > 0.1 else "idle"
	elif is_on_wall():
		animation_new = "wall_slide"
	else:
		animation_new = "falling" if _velocity.y > 0 else "jumping"
	if is_shooting:
		animation_new += "_weapon"
	return animation_new
