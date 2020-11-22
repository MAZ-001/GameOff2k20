extends ClippedCamera

var rng = RandomNumberGenerator.new()
var shake_amount = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.shake_amount > 0:
		self.h_offset = rng.randf_range(-0.1, 0.1)
		self.v_offset = rng.randf_range(-0.1, 0.1)
		self.shake_amount -= 0.1


func enable_shake():
	self.shake_amount = 1.5

