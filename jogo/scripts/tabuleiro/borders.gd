extends Control

@export var border_thickness_ratio: float = 0.02

@onready var top_border: ColorRect = $TopBorder
@onready var right_border: ColorRect = $RightBorder
@onready var left_border: ColorRect = $LeftBorder
@onready var bottom_border: ColorRect = $BottomBorder

func set_borders(parent_size: int, show_top: bool, show_bottom: bool, show_left: bool, show_right: bool):
	var border_thickness = parent_size * border_thickness_ratio

	top_border.visible = show_top
	bottom_border.visible = show_bottom
	left_border.visible = show_left
	right_border.visible = show_right

	top_border.position = Vector2(0, 0)
	bottom_border.position = Vector2(0, parent_size - border_thickness)
	left_border.position = Vector2(0, 0)
	right_border.position = Vector2(parent_size - border_thickness, 0)
	top_border.size = Vector2(parent_size, border_thickness)
	bottom_border.size = Vector2(parent_size, border_thickness)
	left_border.size = Vector2(border_thickness, parent_size)
	right_border.size = Vector2(border_thickness, parent_size)
