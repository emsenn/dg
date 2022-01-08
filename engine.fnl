(local thing (require :thing))
(local user-accountant (require :user-accountant))

(local dimension (require :dimension))

(local map (require :map))

(local mud-server (require :mud-server))
(local user-mud-client (require :user-mud-client))
(local rpg-mud-client (require :rpg-mud-client))

(local engine
       (mud-server.make
        4242
        [user-mud-client.make rpg-mud-client.make]
        (dimension.make
         (user-accountant.make
          :data/user-accounts
          :user-accounts
          (thing.make {:name "emsenn's digital garden"})))))
(set engine.map (map.make :data/map :map (engine:make-thing)))

engine
