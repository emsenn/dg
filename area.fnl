;;;; area
;; An area represents an abstract amount of space in which objects can exist. It might represent a starsystem, a bathroom, or a sector of ocean.

(local thing (require :thing))

(lambda receive-object [area object]
  (table.insert area.objects object)
  (set object.location area))

(lambda save-area [area]
  (local map area.map)
  (map:submit-map-item
   (map:make-map-item area.name area.description)))

(lambda make [?map-item ?base]
  (local area (or ?base (thing.make)))
  (when ?map-item (area:set-attributes ?map-item))
  (area:set-attributes {:objects []
                        : receive-object
                        : save-area})
  area)

{: make}
