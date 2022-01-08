(local thing (require :thing))

(lambda move [object location]
  (location:receive-object object))

(lambda make [location ?name ?description ?base]
  (local object (or ?base (thing.make)))
  (object:set-attributes {:name (or ?name :object)
                          :description (or ?description "This is an object.")
                          : move})
  (object:move location))

{: make}
