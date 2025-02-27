#lang racket
;Infinite continued fraction

(define (cont-frac n d k)
  (define (iter i)
    (if (> i k)
      0
      (/ (n i) (+ (d i) (iter (+ i 1))))))
  (iter 1))



;; verified psi
(/ 1 (cont-frac (lambda (i) 1.0) (lambda(i) 1.0) 10))

(define (find-k given k)
  (define current given)
  (define next (cont-frac identity identity (+ k 1)))
  (if (< (abs (- current next)) 0.00005)
    (+ k 1)
    (find-k next (+ k 1))))


(find-k 1 1)

;8 iterations required
