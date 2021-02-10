
					;Representing sets as binary tree

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
	((= x (entry set)) true)
	((< x (entry set))
	 (element-of-set? x (left-branch set)))
	((> x (entry set))
	 (element-of-set? x (right-branch set)))))


(define (adjoin-set x set)
  (cond ((null? set) (list x '() '()))
	((= (entry set) x) set)
	((< x (entry set))
	 (make-tree (entry set)
		    (adjoin-set x (left-branch set))
		    (right-branch set)))
	((> x (entry set))
	 (make-tree (entry set)
		    (left-branch set)
		    (adjoin-set x (right-branch set))))))


					;Actual exercise

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))


(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


					;Let's see how do the results differ

(define tree (make-tree 7 (make-tree 3 (make-tree 1 '() '()) (make-tree 5 '() '())) (make-tree 9 '() (make-tree 11 '() '()))))
(define another (make-tree 3 (make-tree 1 '() '()) (make-tree 7 (make-tree 5 '() '()) (make-tree 9 '() (make-tree 11 '() '())))))
(define yet (make-tree 5 (make-tree 3 (make-tree 1 '() '()) '()) (make-tree 9 (make-tree 7 '() '()) (make-tree 11 '() '()))))

(tree->list-1 tree)
(tree->list-1 another)
(tree->list-1 yet)

(tree->list-2 tree)
(tree->list-2 another)
(tree->list-2 yet)

					;So far, I cannot see any differences between the two results

;; Solution to part b

;; On algorithm 1

;; T(n) = 2 * T(n/2) + O(n/2) is the equation for algorithm 1
;;        ·For both       ·For append
;; On solving this, we get T(n) = O(n * log(n))


;; On algorithm 2

;; T(n) = 2 * T(n/2) + Θ(1)
;; It takes Θ(n) time
;;       ·For both    ·Consing

