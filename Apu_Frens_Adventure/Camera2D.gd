extends Camera2D

# bueno esto es para la camara aca asigno los limites de la camara en el editor si
# seleccionan camera2d en la parte de editor a la derecha van a ajustar segun el limite del
# background en mi caso lo asigne asi y en la pestaña editor estan las lineas de limite
# amarillas las marcan y modifican los valores de limit para que se ajuste al background 
#limit
#left -40
#top -20
#right 3340
#bottom 730

func _auto_set_limits():
		limit_left = 0
		limit_right = 0
		limit_bottom = 0
		
		var tilemaps = get_tree().get_nodes_in_group("tilemap")
		for tilemap in tilemaps:
			if tilemap is TileMap:
				var used = tilemap.get_used_rect()
				limit_left = min(used.position.x * tilemap.cell_size.x , limit_left)
				limit_right = max(used.end.x * tilemap.cell_size.x , limit_right)
				limit_bottom = max(used.end.y * tilemap.cell_size.y , limit_bottom)

### tilemap y tilemap2

#bueno en el codigo anterior de apu body puse que si toca el suelo camina o se queda quieto
#para esto seleccionan el tilemap que van a usar de suelo y le dan al lado de inspector en node
#en groups y ponen la palabra suelo es la que use para asignar el suelo y que apu pueda caer 
#al piso
#
