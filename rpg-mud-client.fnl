(local thing (require :thing))

(local object (require :object))

(lambda make [client]
  (object.make client.dimension.spawn-room :client "This is a client" client)
  (lambda client.mud-commands.look [client input]
    (client:append-mud-output client.location.name))
  client)

{: make}
