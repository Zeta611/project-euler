(define (reverse n)
  (define (iter acc m)
    (if (= m 0)
        acc
        (iter (+ (remainder m 10)
                 (* acc 10))
              (quotient m 10))))
  (iter 0 n))

(define (palindrome? n)
  (= n (reverse n)))

(define (lychrel? n)
  (let ((thres 50))
    (define (iter count m)
      (cond ((>= count thres) true)
            ; Palindromic numbers can be Lychrel numbers like 4994, so check
            ; count > 0
            ((and (> count 0) (palindrome? m)) false)
            (else (iter (+ count 1)
                        (+ m (reverse m))))))
    (iter 0 n)))

(define (count predicate n)
  (cond ((= n 1) 0)
        ((predicate (- n 1)) (+ 1 (count predicate (- n 1))))
        (else (count predicate (- n 1)))))

(display
  (count lychrel? 10000))
(newline)
