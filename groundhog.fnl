(local util (require :util))

(local commands {})
(lambda commands.register-user [client input]
  (local user (client.engine.users:make-user input))
  (client:message (.. "Account named " input " made, pass is " user.pass)))
(lambda commands.make-area [client input]
  (local new-area (client.engine.map:spawn-area
                   (client.engine.map:make-area)))
  (new-area:activate client.engine.map)
  (tset client.location.exits input new-area.id)
  (tset new-area.exits :back client.location.id)
  (client.location:save)
  (new-area:save))                            

                            

(lambda apply [client]
  (client.engine:schedule
   (fn []
     (set client.size 3)
     (util.add-values client.commands commands))))
