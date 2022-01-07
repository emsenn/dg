;;;; everythings a thing
;; a thing is a table representing some discrete thing within the digital garden.
;; its the construct on which the rest of things are built.

(lambda set-attributes [thing attributes]
  "Sets the given ATTRIBUTES of THING."
  (each [attribute value (pairs attributes)]
    (tset thing attribute value)))

(lambda make [?base]
  "Return a thing, built ontop of ?ATTRS if provided. I.e. (make {:name :Foobert}) returns a thing named Foobert."
  (local thing (or ?base {}))
  (tset thing :set-attributes set-attributes)
  thing)

{: make}
