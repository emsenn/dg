(lambda register [client input]
  (local new-account
         (client.dimension:make-user-account input))
  (client:append-mud-output
   (.. "New account made, password is " new-account.password))
  (client.dimension:submit-user-account input new-account))

(lambda make [client]
  (tset client.mud-commands :register register)
  client)

{: make}
