(local util (require :util))

(lambda apply [client]
  (print (util.fennel.view client))
  (client.engine:schedule (fn [] (tset client.commands :bing (lambda bing [client input] (client:message input))))))
