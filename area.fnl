(local thing (require :thing))

(lambda receive-object [area object]
  (table.insert area.objects object)
  (set object.location area))

(lambda make [?map-item ?base]
  (local area (or ?base (thing.make)))
  (when ?map-item (area:set-attributes ?map-item))
  (area:set-attributes {:objects []
                        : receive-object})
  area)

{: make}
