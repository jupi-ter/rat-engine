package rat

import "core:fmt"
import "vendor:raylib"

Sprite :: struct {
	frames:       []raylib.Texture2D,
	total_frames: i32,
	path:         string,
}

ImageParamType :: enum {
	Sprite,
	Primitive,
}

// Temporary transfer object for the merger of sprite and renderable data.
// Not to be used anywhere else than the create_object API function.
ImageParams :: struct {
	type:        ImageParamType,
	// if Sprite
	sprite_name: string,
	image_index: i32,
	image_speed: f32,
	// if Primitive
	shape:       Primitive,
	color:       raylib.Color,
}

get_sprite :: proc(lib: ^SpriteLibrary, name: string) -> ^Sprite {
	id, exists := lib.path_to_id[name]
	assert(exists, "Sprite name not found in library manifest!")

	spr := &lib.sprites[id]

	if len(spr.frames) == 0 {
		spr.frames = make([]raylib.Texture2D, spr.total_frames)

		for i in 0 ..< spr.total_frames {
			path: string
			if spr.total_frames > 1 {
				path = fmt.tprintf("assets/%s_%d.png", spr.path, i)
			} else {
				path = fmt.tprintf("assets/%s.png", spr.path)
			}

			spr.frames[i] = raylib.LoadTexture(fmt.ctprintf(path))
		}
	}

	return spr
}
