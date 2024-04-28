extends CharacterBody2D

@export var radius: float = 15.0
@export var color: String = "white"

signal shot(pos, direction)
var can_shoot: bool = true
var gun_in_wall: bool = false

func _ready():
	draw_circle_polygon(32, radius)
	$CollisionShape2D.shape.radius = radius
	$Polygon2D.color = color

func draw_circle_polygon(points_nb: int, radius) -> void:
	var points = PackedVector2Array()
	for i in range(points_nb + 1):
		var point = deg_to_rad(i * 360.0 / points_nb - 90)
		points.push_back(Vector2.ZERO + Vector2(cos(point), sin(point)) * radius)
	$Polygon2D.polygon = points

func _process(delta):
	$Aim_Line.look_at(get_global_mouse_position())
	var direction = Input.get_vector("left", "right", "up", "down")
	position += direction * 500 * delta
	move_and_slide()
	if Input.is_action_pressed("shoot") and can_shoot and !gun_in_wall:
		can_shoot = false
		$Timer.start(0.25)
		var player_direction = (get_global_mouse_position() - position).normalized()
		shot.emit($Aim_Line/Marker2D.global_position, player_direction)

func _on_timer_timeout():
	can_shoot = true
	
func _on_aim_line_body_entered(body):
	gun_in_wall = true

func _on_aim_line_body_exited(body):
	gun_in_wall = false
