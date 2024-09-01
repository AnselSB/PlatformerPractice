extends Node2D

@export var moveSpeed = 50
var origin
# Called when the node enters the scene tree for the first time.
func _ready():
	origin = self.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x = self.position.x + moveSpeed * delta
	if self.position.x >= (origin.x + 100) or self.position.x <= (origin.x - 100):
		moveSpeed = moveSpeed * -1
