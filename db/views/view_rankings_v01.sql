SELECT	md.this_date target_date,
 		mg.name genre_name,
 		r.rank ranking,
   		mm.artist artist,
   		mm.title title,
   		mm.youtube_url youtube_url,
   		mm.id mst_music_id
FROM	RANKS r,
 			MST_DATES md,
 			MST_GENRES mg,
 			MST_MUSICS mm
WHERE 	r.mst_date_id = md.id
AND 	r.mst_genre_id = mg.id
AND 	r.mst_music_id = mm.id