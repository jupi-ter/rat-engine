package rat

import "vendor:raylib"

Appearance :: struct {
	tint:   raylib.Color,
	offset: [2]f32,
}

SpriteData :: struct {
	sprite_name:   string,
	image_index:   i32,
	frame_counter: f32,
	image_speed:   f32,
}
