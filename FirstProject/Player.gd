extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size
export var speed = 400



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var velocity = Vector2.ZERO # players movement vector 
	
	if Input.is_action_pressed("move_right"): 
		velocity.x += 1;
	
	if Input.is_action_pressed("move_left"): 
		velocity.x -= 1;
	
	if Input.is_action_pressed("move_up"): 
		velocity.y -= 1;
	
	if Input.is_action_pressed("move_down"): 
		velocity.y += 1;
			
	if velocity.length() > 0: 
		velocity = velocity.normalized() * speed # makes sure that when going diagnally the velocity is always the same
		$AnimatedSprite.play()
	else: 
		$AnimatedSprite.stop()
	
	position += velocity * delta # on every machine the item will move the same speed. 
	
	# makes sure that the player cannot leave the screen 
	position.x = clamp(position.x, 0, screen_size.x) 
	
	position.y = clamp(position.y, 0, screen_size.y) 
	 
	if velocity.x != 0: 
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false 
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0: 
		$AnimatedSprite.animation = "up" 
		$AnimatedSprite.flip_v = velocity.y > 0
		$AnimatedSprite.flip_h = false 
	
