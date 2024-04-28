extends Area2D

@export var radius: float = 2.5
@export var color: String = "white"

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

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
	position += direction * speed * delta

func _on_body_entered(body):
	queue_free()
