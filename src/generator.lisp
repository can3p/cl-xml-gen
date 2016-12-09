(in-package #:cl-xml-gen)

(defparameter *indent-step* 2)

(defun make-indent (indent)
  (if (= indent 0) ""
      (concatenate 'string " " (make-indent (- indent 1)))))

(defun xml (struct &optional (indent 0) (is-inline nil))
  (if (stringp struct) struct
      (let* ((tag (normalize-tag-name (car struct)))
             (attrs (cadr struct))
             (children (normalize-children (cddr struct)))
             (s (make-string-output-stream))
             (inline-children-p (or is-inline (not (null (find-if 'stringp children)))))
             (pad (if is-inline "" (make-indent indent)))
             (end-pad (if inline-children-p "" pad))
             (children-separator (if inline-children-p "" #\Newline)))
        (format s "~a<~a~a>" pad tag (compile-attributes attrs))
        (loop for child in children
              do (format s "~a~a" children-separator
                         (xml child (+ indent *indent-step*) inline-children-p)))
        (when (> (length children) 0) (format s "~a" children-separator))
        (format s "~a</~a>" end-pad tag)
        (get-output-stream-string s))))

(defun html (struct)
  (format nil "<!DOCTYPE html>~%~a" (xml struct)))

(defun normalize-tag-name (tag)
  (cond
    ((symbolp tag) (string-downcase (symbol-name tag)))
    (t (error "unknown symbol type ~a" tag))))

(defun normalize-children (children)
  (labels ((combine-two (first second)
             (concatenate 'list
                          first
                          (cond
                            ((stringp second) (list second))
                            ((symbolp (car second)) (list second))
                            (t second)))))
    (reduce #'combine-two children :initial-value ())))

(defun compile-attributes (attrs)
  (let ((key (car attrs))
        (value (cadr attrs)))
    (if (null key) ""
        (concatenate 'string
                     " "
                     (normalize-tag-name key)
                     (cond
                       ((stringp value) (format nil "=\"~a\"" value))
                       ((or (eq value t) (eq value nil)) "")
                       (t (error "unknown type of attribute value")))
                     (compile-attributes (cddr attrs))))))
