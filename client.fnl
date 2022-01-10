(local util (require :util))

(local commands {})
(lambda commands.commands [client input]
  (client:message
   (.. "You have access to the following commands: "
       (util.quibble-strings (util.collect-keys client.commands) true))))
(lambda commands.login [client input]
  (local user-list client.engine.users.list)
  (var matched? nil)
  (let [(user pass) (input:match "([^ ]+) ?(.*)")]
    (each [_ profile (pairs user-list)]
      (when (and (= user profile.name)
               (= pass profile.pass))
        (set matched? profile))))
    (if matched?
      (do (set client.commands.login nil)
          (util.add-values client matched?)
          (let [role-funcs []]
            (each [_ role (pairs client.roles)]
              (table.insert role-funcs (util.load-data role)))
            (each [_ func (pairs role-funcs)]
              (func client)))
          (client:message (.. "Logged in as " client.name)))
      (client:message "Invalid user-name or pass.")))
(lambda commands.who [client input]
  (client:message
   (.. "There are " (length client.engine.server.clients)
       " clients currently connected to the server.")))
(lambda commands.whoami [client input]
  (client:message
   (.. "Your name is " (or client.name :unknown) ".")))

(lambda activate [client server connection]
  (set client.engine server.engine)
  (set client.connection connection))

(lambda disconnect [client]
  (util.remove-value client.dimension.server.clients client))

(lambda message [client message]
  (set client.output (.. client.output message "\n")))

(lambda parse [client input]
            (let [(command line) (input:match "([^ ]+) ?(.*)")]
        (var matched? nil)
        (each [key func (pairs client.commands)]
          (when (= command key)
            (set matched? true)
            (func client line)))
        (when (not matched?)
          (client:message "Invalid command; `commands` to list available commands."))))

(lambda send-output [client]
  (client.connection:send client.output)
  (set client.output ""))

{:output "" :input ""
 : activate
 : commands
 : disconnect
 : message
 : parse
 : send-output}
