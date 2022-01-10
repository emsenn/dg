(local util (require :util))

(local client (require :client))

(lambda send-connection-message [client]
  (client:message
   (.. "You've connected to emsenn's MUD. Input commands and press ENTER to interact; `commands` lists your available commands.")))

(lambda accept-connection [server connection]
  (connection:settimeout 0.01)
  (local client (util.clone-table client))
  (client:activate server connection)
  (table.insert server.clients client)
  (send-connection-message client))

(lambda start [server engine]
  (set server.engine engine)
  (set server.mudsocket (assert (util.socket.bind "0.0.0.0" 4242)))
  (server.mudsocket:settimeout 0.01)
  (engine:schedule (partial server.tick server)))

(lambda tick [server]
  (let [new-conn (server.mudsocket:accept)]
    (when new-conn (accept-connection server new-conn)))
  (each [_ client (pairs server.clients)]
    (match (client.connection:receive)
      (nil msg) (when (= msg :closed)
                  (client:disconnect))
      input (client:parse input))
    (when (not (= client.output ""))
      (client:send-output)))
  (server.engine:schedule (partial server.tick server)))

{:clients []
 : start
 : tick}
