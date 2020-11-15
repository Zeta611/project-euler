(import (except srfi-1 concatenate)
        stream)

(define (concatenate n m)
  (define (count-digits n)
    (if (= n 0)
        0
        (+ 1 (count-digits (quotient n 10)))))
  (+ m
     (* n (expt 10 (count-digits m)))))

(define (check p . rest)
  (if (null? rest)
      #t
      (let ((l-concat
              (map (lambda (q) (concatenate p q))
                   rest))
            (r-concat
              (map (lambda (q) (concatenate q p))
                   rest)))
        (and (every prime? l-concat)
             (every prime? r-concat)))))

(define (flatmap proc lst)
  (if (null? lst)
      '()
      (foldr append '() (map proc lst))))

(define primes
  (stream-take-while (lambda (p) (< p 10000))
                     prime-stream))

(define satisfying-tuples
  (flatmap
    (lambda (p)
      (flatmap
        (lambda (q)
          (flatmap
            (lambda (r)
              (flatmap
                (lambda (s)
                  (map (lambda (t) (let ((satisfying (list p q r s t)))
                                     (display "Found (p q r s t), sum: ")
                                     (display satisfying)
                                     (display #\,)
                                     (display (+ p q r s t))
                                     (newline)
                                     satisfying))
                       (filter
                         (lambda (t) (check t s r q p))
                         (drop-while (lambda (t) (<= t s)) primes))))
                (filter
                  (lambda (s) (check s r q p))
                  (drop-while (lambda (s) (<= s r)) primes))))
            (filter
              (lambda (r) (check r q p))
              (drop-while (lambda (r) (<= r q)) primes))))
        (filter
          (lambda (q) (check q p))
          (drop-while (lambda (q) (<= q p)) primes))))
    primes))

(display satisfying-tuples)
(newline)
; (13 5197 5701 6733 8389), 26033
; real    12m19.669s
; user    12m13.482s
