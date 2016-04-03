static func build_tilemap(tilemap, objects, parent):
	var id = tilemap.get_cell( 0, 0)
	
	for pos in tilemap.get_used_cells():
		var tileID = tilemap.get_cell(pos.x, pos.y)
		var name = tilemap.get_tileset().tile_get_name(tileID)
		var world_pos = tilemap.map_to_world(pos)
		var obj_class
		var obj
		
		for key in objects:
			if(name == key):
				obj_class = load( objects[key] )
				obj = obj_class.instance()
				
				# apply tilemap node offset
				world_pos.x+=tilemap.get_pos().x
				world_pos.y+=tilemap.get_pos().y
					
				#tile origin - cant see any difference
				if( tilemap.get_tile_origin()==tilemap.TILE_ORIGIN_TOP_LEFT ):
					# apply center
					world_pos.x+=obj.get_texture().get_width()/2
					world_pos.y+=obj.get_texture().get_height()/2

				elif( tilemap.get_tile_origin()==tilemap.TILE_ORIGIN_CENTER ):
					# apply center
					world_pos.x+=obj.get_texture().get_width()/2
					world_pos.y+=obj.get_texture().get_height()/2
					
				#flip
				obj.set_flip_h( tilemap.is_cell_x_flipped( pos.x,pos.y ) )
				obj.set_flip_v( tilemap.is_cell_y_flipped( pos.x,pos.y ) )
				
				#y sort
				#if( tilemap.is_y_sort_mode_enabled() ):
				#	obj.set_z( world_pos.y )
				
				# TODO rotation
				# TODO ...
				
				obj.set_pos( world_pos )
				parent.add_child( obj )
				
	#remove to test transformation 
	tilemap.queue_free()
	