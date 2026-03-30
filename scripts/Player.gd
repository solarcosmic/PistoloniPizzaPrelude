extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

@onready var head: Node3D = $Head
@onready var camera = $Head/PitchPivot/Camera3D

@onready var raycast3d = $Head/PitchPivot/Camera3D/RayCast3D
@onready var raycastend = $Head/PitchPivot/Camera3D/RayCast3D/RayCastEnd
@onready var bulletmarker = $Head/PitchPivot/Gun/BulletStartMarker

const bullet = preload("res://scenes/bullet.tscn")

var controller_yaw = 0.0
var controller_pitch = 0.0

@export var max_pitch = 60
@export var min_pitch = -60
@export var camera_sensitivity = 10

var direction: Vector3 = Vector3.ZERO

var SENSITIVITY = camera_sensitivity / 10000.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Globals.set_player($".")
	#Engine.max_fps = 144

var controller_joy_vector = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("trigger"):
		print("shoot")
		_shoot()

	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		$Head/PitchPivot.rotate_x(-event.relative.y * SENSITIVITY)
		$Head/PitchPivot.rotation.x = clamp($Head/PitchPivot.rotation.x, deg_to_rad(-17.5), deg_to_rad(75))
	elif event is InputEventJoypadMotion:
		controller_joy_vector = Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down")
		

func _shoot():
	var bulletClone = bullet.instantiate()
	get_tree().current_scene.add_child(bulletClone)
	print(bulletClone)
	bulletClone.global_position = bulletmarker.global_position
	var dir = _get_shoot_direction()
	bulletClone.direction = dir
	bulletClone.look_at(raycastend.global_position + dir)
	$"../Sounds/Pistol1".play()

func _get_shoot_direction():
	var target: Vector3
	if raycast3d.is_colliding():
		target = raycast3d.get_collision_point()
	else:
		target = raycast3d.to_global(raycast3d.target_position)
	return bulletmarker.global_position.direction_to(target)
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if controller_joy_vector.length() > 0.1:
		print(SENSITIVITY)
		#controller_yaw += 
		#controller_pitch += -joy_input.y * SENSITIVITY * delta

		head.rotate_y(-controller_joy_vector.x * SENSITIVITY * delta * 2500.0)
		camera.rotate_x(-controller_joy_vector.y * SENSITIVITY * delta * 2500.0)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#$Head/Gun.rotation.x = $Head/Camera3D.rotation.x

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	print("[Cosmic/DEBUG] Direction: ", direction, " Velocity: ", velocity)
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	else:
		# Inertia
		velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * SPEED, delta * 2.0)
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	var is_idle = Globals.is_player_idle()
	if is_idle and is_on_floor():
		print("[Cosmic/DEBUG]: " + str(Time.get_unix_time_from_system()) + " is idle")

	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
