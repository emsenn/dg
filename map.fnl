(local util (require :util))

(local area (require :area))

(lambda start [map]
  (each [id map-item (pairs (map:load))]
    (let [map-area (util.clone-table area)]
      (map-area:activate map)
      (tset map.areas id map-area))))

(lambda load [map]
  (util.load-data :areas {}))

(lambda start [map]
  (each [id area-data (pairs (map:load))]
    (let [area (map:spawn-area area-data)]
      (area:activate map)
      (tset map.areas id area))))

(lambda make-area [map ?name ?description ?id]
  (local area-data {:id (or ?id (util.make-id (util.collect-keys (map:load))))
                    :name (or ?name :area)
                    :description (or ?description "This is an area.")})
  area-data)

(lambda spawn-area [map area-data]
  (util.add-values area-data area)
  area-data)

(lambda save [map data]
  (util.save-data data :areas))

{:areas {} :start-area :d6cce35c
 : load
 : make-area
 : save
 : spawn-area
 : start}
