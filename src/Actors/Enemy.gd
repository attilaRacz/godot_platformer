class_name Enemy
extends Actor


enum EnemyState {
	WALKING,
	ATTACK,
	DEAD,
}

var _state = EnemyState.WALKING

onready var platform_detector = $PlatformDetector
onready var floor_detector_left = $FloorDetectorLeft
onready var floor_detector_right = $FloorDetectorRight
onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

# This function is called when the scene enters the scene tree.
# We can initialize variables here.
func _ready():
	_velocity.x = speed.x

# Physics process is a built-in loop in Godot.
# If you define _physics_process on a node, Godot will call it every frame.

# At a glance, you can see that the physics process loop:
# 1. Calculates the move velocity.
# 2. Moves the character.
# 3. Updates the sprite direction.
# 4. Updates the animation.

# Splitting the physics process logic into functions not only makes it
# easier to read, it help to change or improve the code later on:
# - If you need to change a calculation, you can use Go To -> Function
#   (Ctrl Alt F) to quickly jump to the corresponding function.
# - If you split the character into a state machine or more advanced pattern,
#   you can easily move individual functions.
func _physics_process(_delta):
	# If the enemy encounters a wall or an edge, the horizontal velocity is flipped.
	if not floor_detector_left.is_colliding():
		_velocity.x = speed.x
	elif not floor_detector_right.is_colliding():
		_velocity.x = -speed.x

	if is_on_wall():
		_velocity.x *= -1

	# We only update the y value of _velocity as we want to handle the horizontal movement ourselves.
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

	# We flip the Sprite depending on which way the enemy is moving.
	sprite.scale.x = 1 if _velocity.x > 0 else -1
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if get_slide_collision(i).collider is Player:
				attack(get_slide_collision(i).collider)

	var animation = get_new_animation()
	if animation != animation_player.current_animation:
		animation_player.play(animation)


func destroy():
	_state = EnemyState.DEAD
	_velocity = Vector2.ZERO

func attack(_player):
	_state = EnemyState.ATTACK
	_velocity = Vector2.LEFT if sprite.scale.x == 1 else Vector2.RIGHT
	_player.dead()


func get_new_animation():
	var animation_new = ""
	if _state == EnemyState.WALKING:
		animation_new = "walk" if abs(_velocity.x) > 0 else "idle"
	elif _state == EnemyState.ATTACK:
		animation_new = "attack"
	else:
		animation_new = "destroy"
	return animation_new
