(import stream)

(define (square n)
  (* n n))

; Solve problem
(define tl-spiral
  (stream-map
    (lambda (n)
      (+ (* 4
            (square (- n 1)))
         1))
    (integers-starting-from 2)))

(define tr-spiral
  (stream-map
    (lambda (n)
      (+ (* (- (* 4 n) 7)
            (- n 1))
         n))
    (integers-starting-from 2)))

(define bl-spiral
  (stream-map
    (lambda (n)
      (+ (* 2
            (- n 1)
            (- (* 2 n) 1))
         1))
    (integers-starting-from 2)))

(define br-spiral
  (stream-map
    (lambda (n)
      (square (- (* 2 n) 1)))
    (integers-starting-from 2)))

(define spirals
  (stream-zip tr-spiral tl-spiral bl-spiral br-spiral))

(define (one-if pred)
  (if pred 1 0))

(define spiral-prime-counts
  (stream-map
    (lambda (lst)
      (foldr
        (lambda (n result)
          (+ (one-if (prime? n)) result))
        0
        lst))
    spirals))

(define spiral-prime-accum
  (stream-add
    spiral-prime-counts
    (cons-stream 0 spiral-prime-accum)))

(define spiral-prime-ratio
  (stream-map
    (lambda (lst)
      (/ (car lst) (cadr lst)))
    (stream-zip spiral-prime-accum
         (stream-map
           (lambda (n)
             (+ (* 4 n) 1))
           (integers-starting-from 1)))))

(define (solve)
  (let* ((indexed-stream
           (stream-zip spiral-prime-ratio
                (integers-starting-from 2)))
         (pair
           (stream-first
             (lambda (pair) (< (car pair) 0.1))
             indexed-stream))
         (index (cadr pair)))
    (- (* 2 index) 1)))

(display (solve))
(newline)
