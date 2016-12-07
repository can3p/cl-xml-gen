(in-package :cl-user)
(defpackage cl-xml-gen-test
  (:use :cl
   :cl-xml-gen
        :prove))

(in-package :cl-xml-gen-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-xml-gen)' in your Lisp.

(plan nil)

(is 1 1)

(finalize)

