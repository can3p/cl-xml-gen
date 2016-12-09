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

(is (html '(:html nil
            (:head nil (:title nil "title"))
            (:body nil
             ((:div (:class "section") ("h2" nil "header")
               ((:div (:class "subsection") ("h3" nil "subheader"))))))))
            (format nil "~:
<!DOCTYPE html>
<html>
  <head>
    <title>title</title>
  </head>
  <body>
    <div class=\"section\">
      <h2>header</h2>
      <div class=\"subsection\">
        <h3>subheader</h3>
      </div>
    </div>
  </body>
</html>"))

(finalize)

