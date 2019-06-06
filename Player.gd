extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size
var speed = 200
var JUMP_FORCE = -300
var GRAVITY = 1000
var velocity = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, Vector2(0,-1))
	if velocity.x == 0:
		$AnimationPlayer.stop(false)
func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")
	
	if jump and is_on_floor():
		velocity.y = JUMP_FORCE
		print("Pressed UP")
	if right:
		velocity.x += speed
		$AnimationPlayer.play("Walking")
	if left:
		velocity.x -= speed
		$AnimationPlayer.play("WalkingLeft")

