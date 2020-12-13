extends DButton

var link = ""

func _pressed():
	OS.clipboard = link
