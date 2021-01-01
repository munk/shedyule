#|
  This file is a part of shedyule project.
  Copyright (c) 2020 John Downs (john.downs@acm.org)
|#

(defsystem "shedyule-test"
  :defsystem-depends-on ("prove-asdf")
  :author "John Downs"
  :license ""
  :depends-on ("shedyule"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "shedyule"))))
  :description "Test system for shedyule"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
