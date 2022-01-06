;;;; digital garden engine bootstraps
;; this is the first file in my digital garden
;; it's here to bootstrap the rest.
;;; o golly here we go!
(local fennel (require :fennel))
;; utilities
(lambda load-data [path]
  "Load the .fnl file at PATH, as data"
  (fennel.eval
   (: (io.open (.. path ".fnl") :r)
      :read "*all")))
(lambda save-data [data path]
  "Save DATA to a .fnl file at PATH."
  (let [src (io.open (.. path ".fnl") :w)]
    (src:write (fennel.view data))
    (src:close)))
;; changelog stuff
(lambda load-changelog []
  (let [src (io.open :data/changelog.fnl :r)
        loaded-data (src:read "*all")]
    (fennel.eval loaded-data)))
(lambda save-changelog [entries]
  (let [src (io.open :data/changelog.fnl :w)]
    (src:write (fennel.view entries))
    (src:close)))
(lambda make-changelog-entry [author status element ?note]
  {:time (os.time) : author : status : element
   :note (or ?note nil)}) ; setting a table value to nil drops it from the table
(lambda submit-changelog-entry [entry]
  (let [changelog (load-changelog)]
    (table.insert changelog.entries entry)
    (save-changelog changelog)))
(lambda ms-change [author status element ?note]
  (submit-changelog-entry
   (make-changelog-entry author status element ?note)))
;; next, a way to write down plans!
(lambda ms-plan [author urgency description]
  "Make a plan of URGency and IMPortance with DESCription by AUTHOR"
  (let [plans (load-data :data/plans)]
    (table.insert plans {:time (os.time) : author : urgency : description})
    (save-data plans :data/plans)))
;; lets export our functions
{: load-changelog : save-changelog
 : make-changelog-entry : submit-changelog-entry
 : ms-change
 : ms-plan }
