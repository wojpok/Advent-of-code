#lang racket

(define lines (file->lines "data.in"))

(define (print lines)
    (if (empty? lines) 10 (begin (display (car lines)) (print (cdr lines)))))


;[T]             [P]     [J]        
;[F]     [S]     [T]     [R]     [B]
;[V]     [M] [H] [S]     [F]     [R]
;[Z]     [P] [Q] [B]     [S] [W] [P]
;[C]     [Q] [R] [D] [Z] [N] [H] [Q]
;[W] [B] [T] [F] [L] [T] [M] [F] [T]
;[S] [R] [Z] [V] [G] [R] [Q] [N] [Z]
;[Q] [Q] [B] [D] [J] [W] [H] [R] [J]

; Proper parser would take too much time
(define stack [list
    '("T" "F" "V" "Z" "C" "W" "S" "Q")
    '("B" "R" "Q")
    '("S" "M" "P" "Q" "T" "Z" "B")
    '("H" "Q" "R" "F" "V" "D")
    '("P" "T" "S" "B" "D" "L" "G" "J")
    '("Z" "T" "R" "W")
    '("J" "R" "F" "S" "N" "M" "Q" "H")
    '("W" "H" "F" "N" "R")
    '("B" "R" "P" "Q" "T" "Z" "J")
])

(define commands (cddr (cddddr (cddddr lines))))


(define (take-nth xs n)
    (if (= n 0)
        (car xs)
        (take-nth (cdr xs) (- n 1))))

(define (set-nth xs n val)
    (if (= n 0)
        (cons val (cdr xs))
        (cons (car xs) 
                (set-nth (cdr xs) (- n 1) val))))

(define (parse-line line)
    (let ([arr (string-split line)])
        (list 
            (- (string->number (fourth arr)) 1)
            (- (string->number (sixth  arr)) 1) 
            (string->number (second arr)))))


(define (exec from to count stack)
    (define (iter f t n)
        (if (= n 0)
            (cons f t)
            (iter 
                (cdr f) 
                (cons (car f) t)
                (- n 1))))
    (let* (
        [fs (take-nth stack from)]
        [ts (take-nth stack to)]
        [res (iter fs ts count)])
        
        (set-nth 
            (set-nth stack from (car res))
            to (cdr res))))


(define (first-task commands stack) 
    (if (null? commands)
        stack
        (let (
            [args (parse-line (car commands))])
            (first-task (cdr commands)
                (exec 
                    (car args) 
                    (cadr args) 
                    (caddr args)
                    stack)))))

; (display (first-task commands stack))

(define (sig stack)
    (if (null? stack)
        null
        (cons (caar stack) (sig (cdr stack)))))

(foldr string-append "" (sig (first-task commands stack)))