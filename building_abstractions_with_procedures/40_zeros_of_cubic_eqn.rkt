#lang racket
;Implementation of cube procedure

(require "../lib.rkt")

(define tolerance 0.00001)
(define dx 0.00001)


(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))


(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))


(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))


(define (cubic a b c)
  (lambda(x) (+ (expt x 3) (* a (sqr x)) (* b x) c)))

(newtons-method (cubic -6 11 -6) 4)
