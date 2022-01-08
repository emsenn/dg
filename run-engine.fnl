(local engine (require :engine))

(engine.map:start-map)
(set engine.spawn-room (. engine.map.map :2621f38d))

(engine:start-mud-server)
(engine:run-time)
