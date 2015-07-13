
extends Timer

var ready = true

func _on_Timer_timeout():
	ready = true
	self.stop()
	#print("timeout")
	
func _init():
	#print("init")
	self.connect("timeout", self, "_on_Timer_timeout")

