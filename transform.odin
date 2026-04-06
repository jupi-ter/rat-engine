package rat

import "vendor:raylib"

// name collision with raylib
transform_t :: struct {
	position: raylib.Vector2,
	scale:    raylib.Vector2,
	hflip:    i32, // (-1, 1)
	vflip:    i32, // (-1, 1)
	rotation: f32,
}
