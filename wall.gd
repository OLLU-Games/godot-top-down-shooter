extends StaticBody2D

@export var width: float = 40.0
@export var color: String = "white"

func _ready():
	$Line2D.width = width
	for i in $Line2D.points.size() - 1:
		$CollisionShape2D.position = ($Line2D.points[i] + $Line2D.points[i + 1]) / 2
		$CollisionShape2D.rotation = $Line2D.points[i].direction_to($Line2D.points[i + 1]).angle()
		var length = $Line2D.points[i].distance_to($Line2D.points[i + 1])
		$CollisionShape2D.shape.extents = Vector2(length / 2, width / 2)
