(require :uiop)

(defparameter data (coerce (uiop:read-file-string "data.in") 'list))

(defun correct (acc)
    (not (or 
        (eq (first acc)  (second acc))
        (eq (first acc)  (third acc))
        (eq (first acc)  (fourth acc))
        (eq (second acc) (third acc))
        (eq (second acc) (fourth acc))
        (eq (third acc)  (fourth acc)))))
 
(defun iter (acc xs pos)
    (if (null xs)
        (print "End of input")
        (if (correct acc)
            pos
            (iter (cons (car xs) acc) (cdr xs) (+ pos 1))
            )))

; (defparameter data (coerce "nppdvjthqldpwncqszvftbrmjlhg" 'list))

(print (iter 
    (list (car data) (cadr data) (caddr data) (cadddr data))
    (cddddr data)
    4))

(defun run (data)
    (iter 
        (list (car data) (cadr data) (caddr data) (cadddr data))
        (cddddr data)
        4))

(defun id (x) x)

(defparameter true (= 0 0))
(defparameter false (= 0 1))

(defun unique (acc)
    (defun compare (x acc n)
        (if (= n 0)
            true
            (if (eq (car acc) x)
                false
                (compare x (cdr acc) (- n 1)))))
    (defun iter (acc n)
        (if (= n 0)
            true
            (if (compare (car acc) (cdr acc) n)
                (iter (cdr acc) (- n 1))
                false)))
    (iter acc 13))

(defun iter2 (acc xs pos)
    (if (null xs)
        (print "EOF")
        (if (unique acc)
            pos
            (iter2 (cons (car xs) acc) (cdr xs) (+ pos 1))
            )))

; (defparameter data (coerce "mjqjpqmgbljsphdztnvjfqwrcgsmlb" 'list))

(print (iter2 (list #\a #\a #\a #\a #\a #\a #\a #\a #\a #\a #\a #\a #\a #\a) data 0))