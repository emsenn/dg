;;;; maker
;; make new things that are aware of their maker.

(local thing (require :thing))



(lambda add-thing [maker thing]
  (table.insert maker.things thing)
  (set thing.maker maker)
  maker)

(lambda make-thing [maker ?attributes]
  (local thing (thing.make ?attributes))
  (let [fen (require :fennel)] (print (fen.view thing)))
  (maker:add-thing thing)
  thing)

(lambda make [?base]
  (local maker (or ?base (thing.make)))
  (maker:set-attributes {:things {}
                         : add-thing
                         : make-thing})
  maker)

{: make}
