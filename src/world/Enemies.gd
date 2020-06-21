extends Node2D

func _on_Endgame_started_cutscene(_ender):
	call_deferred("free")
