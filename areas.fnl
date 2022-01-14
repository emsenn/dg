 :foyer {:description "This is the foyer to the GAZ-MUD; a quiet space where folk are encouraged to get situated before heading `out` into the wider MUD."
         :exits {:out "hub"}
         :id "foyer"
         :name "the foyer"}
 :hub {:description "This is the current hub of the GAZ-MUD. There is literally nothing here. Yet somehow, there is an exit to what is obviously the west, leading to the virtual makerspace."
       :exits {:west "virtual-makerspace"}
       :id "hub"
       :name "the hub"}
 :virtual-makerspace {:description "This is the virtual makerspace of the GAZ-MUD, a place where those with the `maker` role are encouraged to mess around. Please note, if you don't have that role, while you're allowed to roam the space, you might get stuck."
                      :exits {:east "hub"}
                      :id "virtual-makerspace"
                      :name "the virtual makerspace"}}
