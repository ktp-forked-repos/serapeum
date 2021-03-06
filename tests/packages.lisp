(in-package :serapeum.tests)

(def-suite packages :in serapeum)
(in-suite packages)

(defpackage :serapeum.tests.p1
  (:use)
  (:nicknames :serapeum.tests.nick1 :serapeum.tests.nick2))

(defpackage :serapeum.tests.p2
  (:use :cl)
  (:export :car :cdr :cons))

(test package-exports
  (is (null (package-exports :serapeum.tests.p1)))
  (is (set-equal '(car cdr cons)
                 (package-exports :serapeum.tests.p2))))

(test package-names
  (is (set-equal (package-names :serapeum.tests.p1)
                 '(:serapeum.tests.p1
                   :serapeum.tests.nick1
                   :serapeum.tests.nick2)
                 :test #'string=)))

(test package-name-keyword
  (is (eql :serapeum.tests.p1
           (package-name-keyword
            (find-package (string :serapeum.tests.p1))))))

(test find-external-symbol
  (is (null (find-external-symbol (string 'list) :serapeum.tests.p2)))
  (is (eql 'car
           (find-external-symbol (string 'car) :serapeum.tests.p2))))
