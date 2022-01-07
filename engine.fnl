(local thing (require :thing))
(local dimension (require :dimension))
(local mud-server (require :mud-server))
(local rpg-mud-client (require :rpg-mud-client))

(local multiverse
       (mud-server.make
        4242
        [rpg-mud-client.make]
        (dimension.make (thing.make {:name "emsenn's digital garden"}))))

multiverse
