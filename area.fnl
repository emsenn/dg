(local util (require :util))

(lambda activate [area map]
  (set area.map map))

(lambda receive-object [area object]
  (when object.location
    (object.location:remove-object object))
  (table.insert area.contents object)
  (set object.location area))

(lambda remove-object [area object]
  (set area.contents (util.remove-value area.contents object))
  (set object.location nil))

(lambda save [area]
  (local map-data (area.map:load))
  (tset map-data area.id {:id area.id
                          :name area.name
                          :description area.description
                          :exits area.exits})
  (area.map:save map-data))

{:contents []
 : activate
 : receive-object
 : remove-object
 : save}
