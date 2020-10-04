extends KinematicBody

const speed = 8

var velocity = Vector3()

func _physics_process(_delta: float) -> void:
  get_input()
  velocity = move_and_slide(velocity)
  
  if velocity.x != 0 || velocity.z != 0:
    $Sprite.play()
  else:
    $Sprite.stop()

func get_input() -> void:
  velocity.x = 0
  velocity.z = 0
  
  if Input.is_action_pressed("move_forward"):
    velocity.z -= speed
  if Input.is_action_pressed("move_backward"):
    velocity.z += speed
  if Input.is_action_pressed("strafe_right"):
    velocity.x += speed
  if Input.is_action_pressed("strafe_left"):
    velocity.x -= speed
  
  velocity = velocity.normalized() * speed
