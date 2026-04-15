package rat

import "vendor:raylib"

Renderable :: struct {
	sprite_name:   string,
	image_index:   i32,
	frame_counter: f32,
	image_speed:   f32,
}

// annoying naming i know, but most differentiate from render primitives
render_sprites :: proc(world: ^World) {
	for i in 0 ..< world.renderables.count {
		eid := world.renderables.dense[i]
		render := &world.renderables.data[i]

		// FIXME: branch misfiring!
		if (render.sprite_name == "") {
			continue
		}

		sprite := get_sprite(&world.sprite_lib, render.sprite_name)

		render.frame_counter += render.image_speed
		//update animation
		if (render.frame_counter >= 1.0) {
			render.frame_counter -= 1.0
			render.image_index += 1

			if (render.image_index >= sprite.total_frames) {
				render.image_index = 0
			}
		}

		// draw
		transform, has_transform := get(&world.transforms, eid)
		if has_transform {
			raylib.DrawTextureEx(
				sprite.frames[render.image_index],
				transform.position,
				transform.rotation,
				transform.scale.x,
				raylib.WHITE,
			)
		}
	}
}
