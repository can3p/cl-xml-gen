(in-package :cl-user)
(defpackage cl-xml-gen-test-asd
  (:use :cl :asdf))
(in-package :cl-xml-gen-test-asd)

(asdf:defsystem #:cl-xml-gen-test
  :author "Dmitry Petrov"
  :license "Public Domain"
  :depends-on (:cl-xml-gen
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "generator"))))
  :description "Test system for cl-xml-gen"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))

