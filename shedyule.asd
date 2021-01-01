#|
  This file is a part of shedyule project.
  Copyright (c) 2020 John Downs (john.downs@acm.org)
|#

#|
  Author: John Downs (john.downs@acm.org)
|#

(defsystem "shedyule"
  :version "0.1.0"
  :author "John Downs"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "shedyule"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "shedyule-test"))))
