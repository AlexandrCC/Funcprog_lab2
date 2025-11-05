
(in-package :cl-user)


(defun merge-lists-pairs (list1 list2)
  (cond
    ((and (null list1) (null list2)) nil)
    ((null list1) nil)
    ((null list2) (list (list (car list1))))
    (t (cons (list (car list1) (car list2))
             (merge-lists-pairs (cdr list1) (cdr list2))))))



(defun prefix-p (lst1 lst2)
  "Повертає T, якщо lst1 є префіксом lst2."
  (cond
    ((null lst1) t)
    ((null lst2) nil)
    ((equal (car lst1) (car lst2))
     (prefix-p (cdr lst1) (cdr lst2)))
    (t nil)))

(defun sublist-after-p (lst elem sublst)
  "Повертає T, якщо одразу після першого входження elem у lst
   йде послідовність елементів sublst."
  (cond
    ((null lst) nil)
    ((equal (car lst) elem)
     (prefix-p sublst (cdr lst)))
    (t (sublist-after-p (cdr lst) elem sublst))))


(defun check-merge-lists-pairs (name l1 l2 expected)
  (format t "~:[FAILED~;passed~]... ~a~%"
          (equal (merge-lists-pairs l1 l2) expected)
          name))

(defun test-merge-lists-pairs ()
  (check-merge-lists-pairs "pairs: базовий приклад"
    '(1 2 3 4 5) '(a b c d)
    '((1 A) (2 B) (3 C) (4 D) (5)))
  (check-merge-lists-pairs "pairs: другий список довший"
    '(x y) '(1 2 3)
    '((X 1) (Y 2)))
  (check-merge-lists-pairs "pairs: перший список порожній"
    nil '(a b)
    nil))

(defun check-sublist-after-p (name lst elem sublst expected)
  (format t "~:[FAILED~;passed~]... ~a~%"
          (equal (sublist-after-p lst elem sublst) expected)
          name))

(defun test-sublist-after-p ()
  (check-sublist-after-p "after: приклад T"
    '(1 a 2 b 3 c 4 d) 'b '(3 c) t)
  (check-sublist-after-p "after: приклад NIL"
    '(1 a 2 b 3 c 4 d) 'b '(3 c d) nil)
  (check-sublist-after-p "after: елемент на початку"
    '(x 1 2 y 3 4) 'x '(1 2) t)
  (check-sublist-after-p "after: елемент відсутній"
    '(x 1 2 y 3 4) 'z '(3 4) nil))

(defun run-all-tests ()
  (format t "=== Тести merge-lists-pairs ===~%")
  (test-merge-lists-pairs)
  (format t "=== Тести sublist-after-p ===~%")
  (test-sublist-after-p)
  (values))

;; Підказка: для запуску тестів у REPL
;; CL-USER> (load "lab2.lisp")
;; CL-USER> (run-all-tests)
