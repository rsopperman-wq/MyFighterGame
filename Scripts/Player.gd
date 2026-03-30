extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = 4.0
@export var punch_cooldown = 0.5

var can_punch = true

func _physics_process(delta):
    var input_dir = Vector3.ZERO
    if Input.is_action_pressed("move_forward"):
        input_dir.z -= 1
    if Input.is_action_pressed("move_back"):
        input_dir.z += 1
    if Input.is_action_pressed("move_left"):
        input_dir.x -= 1
    if Input.is_action_pressed("move_right"):
        input_dir.x += 1

    input_dir = input_dir.normalized()
    velocity.x = input_dir.x * speed
    velocity.z = input_dir.z * speed

    if not is_on_floor():
        velocity.y -= 9.8 * delta
    elif Input.is_action_just_pressed("jump"):
        velocity.y = jump_velocity

    move_and_slide()

    if Input.is_action_just_pressed("punch") and can_punch:
        punch()

func punch():
    can_punch = false
    print("Punch!")
    # Here you can add blood particles later
    yield(get_tree().create_timer(punch_cooldown), "timeout")
    can_punch = true
