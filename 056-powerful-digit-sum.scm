(define (digit-sum n)
  (if (= n 0)
      0
      (+ (digit-sum (quotient n 10))
         (remainder n 10))))

(define (max-digital-sum a b)
  (define (iter i j)
    (cond ((= i 0) 0)
          ((= j 0)
           (max 1 (iter (- i 1) b)))
          (else
            (max (digit-sum (expt i j))
                 (iter i (- j 1))))))
  (iter a b))

(display (max-digital-sum 99 99))
(newline)
