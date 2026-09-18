extends RigidBody3D

var grounded = false
@export var speed = 0
@export var backSpeed = 5
@export var minSpeed = 0
@export var maxSpeed = 70
@export var jumpHeight = 10
@export var gravity = 10
@export var turnSpeed = 0.02
@export var friction = 0.01

@export var camera: Node3D

func _ready() -> void:
	#$CameraHolder.top_level = true
	pass

func _process(delta: float) -> void:
	#print_debug(angular_velocity)
	print_debug($"../camPivot/Camera3D".fov)
	# get mouse to be used :O
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif Input.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	# gravity
	#if is_on_floor() == false:
		#print_debug($Camera3D.fov)
		#gravity = 1
		#gravity = lerpf(gravity, 50, 0.8 * gravity)
		#if angular_velocity.y <= -0.00000001:
			#$Camera3D.fov = lerpf($Camera3D.fov, 100, 0.0002 * gravity)
		#angular_velocity.y = lerpf(angular_velocity.y, -gravity, 0.002)
	#else:
		#gravity = 0
	#
	# moving script
	var turnDir = Input.get_axis("right", "left")
	if turnDir:
		camera.rotate(Vector3(0, 1, 0).normalized(), turnDir * turnSpeed)
		
	var directionz := -Input.get_axis("slow", "go") * camera.basis.z
	var directionx := Input.get_axis("slow", "go") * camera.basis.x
	#if direction:
		#apply_torque(Vector3(-direction.x * speed , 0, -direction.z * speed))
	#else:
		#angular_velocity.x = lerpf(angular_velocity.x, 0, 0.01)
		#angular_velocity.z = lerpf(angular_velocity.z, 0, 0.01)
	if Input.is_action_pressed("go"):
		#angular_velocity += directionz*speed*delta * 10
		apply_force(directionx*speed)
	if Input.is_action_pressed("slow"):
		apply_force(directionx*speed*delta)
		#angular_velocity += directionz*speed*delta * 10
	if Input.is_action_just_pressed("go"):
		if speed < 5:
			speed += 5
	if Input.is_action_pressed("go"):
		speed = lerpf(speed, maxSpeed, 0.0002 * speed)
	elif Input.is_action_just_pressed("slow"):
		if speed < 5:
			speed += 5
	elif Input.is_action_pressed("slow"):
		speed = lerpf(speed, backSpeed, 0.0002 / speed)
	else:
		speed = lerpf(speed, minSpeed, 0.2)
	
	angular_velocity -= angular_velocity * 0.05
	
	angular_velocity += (linear_velocity * Vector3(1, 0, 1)).rotated(Vector3(0, 1, 0), PI/2) / 2
	
	#apply_force(Vector3(0, -1, 0))
	apply_force(-linear_velocity * 2 * Vector3(1, 0, 1))
	
	# jump
	#if Input.is_action_just_pressed("jump") && is_on_floor():
		#angular_velocity.y = lerpf(angular_velocity.y, jumpHeight, 0.6)
	#
