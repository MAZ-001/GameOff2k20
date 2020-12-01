extends ClippedCamera

var rng = RandomNumberGenerator.new()
var shake_amount = 0.0


func _ready():
	rng.randomize()


func _process(_delta):
	if self.shake_amount > 0:
		self.h_offset = rng.randf_range(-0.1, 0.1)*self.shake_amount
		self.v_offset = rng.randf_range(-0.1, 0.1)*self.shake_amount
		self.shake_amount -= 0.1
	else:
		self.h_offset = 0
		self.v_offset = 0

func enable_shake():
	self.shake_amount = 1.5

