extends VBoxContainer


func setup(spell):
	$Label.text = spell["NAME"]
	$Icon.visible = true
	$Icon.texture = spell["ICON"]
	$Icon.material.set_shader_param("color_base", spell["COLORS"].COLOR_BASE)
	$Icon.material.set_shader_param("color_outline", spell["COLORS"].COLOR_OUTLINE)

func set_text(_new):
	$Label.text = _new
