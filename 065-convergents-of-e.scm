(define (reciprocal n) (/ 1 n))

(define (continued-fraction n gen-proc)
  (if (zero? n)
      (gen-proc 0)
      (+ (gen-proc 0)
         (reciprocal
           (continued-fraction (- n 1)
                               (lambda (n)
                                 (gen-proc (+ n 1))))))))

(define proc
  (lambda (n)
    (cond ((zero? n) 2)
          ((= (remainder n 3) 2)
           (* 2 (+ 1 (quotient n 3))))
          (else 1))))

(define (digit-sum n)
  (if (zero? n)
      0
      (+ (digit-sum (quotient n 10))
         (remainder n 10))))

(display
  (digit-sum
    (numerator
      (continued-fraction 99 proc))))
(newline)
