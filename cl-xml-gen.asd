(in-package :cl-user)
(defpackage cl-xml-gen-asd
  (:use :cl :asdf))
(in-package :cl-xml-gen-asd)

(asdf:defsystem #:cl-xml-gen
  :description "Simplistic xml generator"
  :author "Dmitry Petrov <dpetroff@gmail.com>"
  :license "Public Domain"
  :serial t
  :components ((:module "src"
                :components
                (
                 (:file "package")
                 (:file "generator")
                 )))
  :in-order-to ((test-op (test-op cl-xml-gen-test))))

