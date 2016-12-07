(in-package :cl-user)
(defpackage cl-xml-gen-test
  (:use :cl
   :cl-xml-gen
        :prove))

(in-package :cl-xml-gen-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-xml-gen)' in your Lisp.

(plan nil)

(is (xml '(div)) "<div></div>")
(is (xml '(:div)) "<div></div>")
(is (xml '("div")) "<div></div>")

(is (xml '(:div (:class "xml-feed"))) "<div class=\"xml-feed\"></div>")
(is (xml '(:div (:enabled t))) "<div enabled></div>")

(is (xml '(:div (:enabled t)
           (:p (:class "test") "test string"))) (format nil "~:
<div enabled>
  <p class=\"test\">test string</p>
</div>"))

(is (xml '(:div (:enabled t)
           (:p (:class "test") "test string")
           (
            (:p (:class "test") "test string")
            (:p (:class "test") "test string")
            )
           )) (format nil "~:
<div enabled>
  <p class=\"test\">test string</p>
  <p class=\"test\">test string</p>
  <p class=\"test\">test string</p>
</div>"))

(is (html '(html nil
            (body nil "we're good")))
    (format nil "~:
<!DOCTYPE html>
<html>
  <body>we're good</body>
</html>"))

(finalize)

