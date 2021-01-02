#|
  This file is a part of shedyule project.
  Copyright (c) 2020 John Downs (john.downs@acm.org)
|#

(defsystem "shedyule-test"
  :author "John Downs"
  :license "MIT"
  :depends-on ("shedyule"
	       "rove")
  :components ((:module "tests"
		:components
		((:file "shedyule"))))
  :description "Test system for shedyule"
  :perform (test-op (op c) (symbol-call :rove :run c)))
