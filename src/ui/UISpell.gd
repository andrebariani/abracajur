extends VBoxContainer

export(Texture) var nullspell

export var letter = ""

func _ready():
	$Icon/Letter.text = letter

func setup(spell):
	$Label.text = spell["NAME"]
	$Icon.visible = true
	$Icon.texture = spell["ICON"]
	$Icon.material.set_shader_param("color_base", spell["COLORS"].COLOR_BASE)
	$Icon.material.set_shader_param("color_outline", spell["COLORS"].COLOR_OUTLINE)

func reset():
	$Label.text = "?"
	$Icon.texture = nullspell
	$Icon.material.set_shader_param("color_base", Color(0, 0, 0, 1))
	$Icon.material.set_shader_param("color_outline", Color(1, 1, 1, 1))

func set_text(_new):
	$Label.text = _new
