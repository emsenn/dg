;;;; digital garden engine bootstraps
;; this is the first file in my digital garden
;; it's here to bootstrap the rest.
;;; o golly here we go!
(local fennel (require :fennel))
;; first, a way to write down our changes
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
;; lets export our functions
{: load-changelog : save-changelog
 : make-changelog-entry : submit-changelog-entry
 : ms-change}
