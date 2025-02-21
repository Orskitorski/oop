extends RichTextLabel

func _ready():
	pass

func _process(_delta):
	set_text("Score:"+str(get_node("/root/RespawnMenu").Score))
