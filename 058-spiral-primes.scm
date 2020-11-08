; Stream utilities
(define-syntax cons-stream
  (syntax-rules ()
    ((_ a b)
     (cons a (delay b)))))

(define (stream-car stream)
  (car stream))
(define (stream-cdr stream)
  (force (cdr stream)))

(define (stream-null? stream)
  (null? stream))
(define the-empty-stream '())

(define (stream-map proc s)
  (cond ((stream-null? s) the-empty-stream)
        (else
          (cons-stream
            (proc (stream-car s))
            (stream-map proc (stream-cdr s))))))

(define (stream-filter pred s)
  (cond ((stream-null? s) the-empty-stream)
        ((pred (stream-car s))
         (cons-stream
           (stream-car s)
           (stream-filter pred (stream-cdr s))))
        (else
          (stream-filter pred (stream-cdr s)))))

(define (stream-first pred s)
  (cond ((stream-null? s) #f)
        ((pred (stream-car s)) (stream-car s))
        (else (stream-first pred (stream-cdr s)))))

(define (take n stream)
  (cond ((= n 0) '())
        ((stream-null? stream)
         (error "End of stream reached -- TAKE"))
        (else
          (cons (stream-car stream)
                (take (- n 1) (stream-cdr stream))))))

(define (stream-accumulate op init s)
  (if (stream-null? s)
      init
      (op (stream-car s)
          (stream-accumulate op init (stream-cdr s)))))

(define (stream-add s1 s2)
  (cons-stream
    (+ (stream-car s1)
       (stream-car s2))
    (stream-add (stream-cdr s1)
                (stream-cdr s2))))

; Only for infinite streams.
(define (zip . streams)
  (cons-stream
    (map stream-car streams)
    (apply zip
           (map stream-cdr streams))))

; Primes
(define (integers-starting-from n)
  (cons-stream
    n
    (integers-starting-from (+ n 1))))

(define (square n)
  (* n n))

(define (divisible? n q)
  (= (remainder n q) 0))

(define primes
  (cons-stream
    2
    (stream-filter prime?
                   (integers-starting-from 3))))

(define (prime? n)
  (let loop ((ps primes))
    (cond ((< n (square (stream-car ps)))
           #t)
          ((divisible? n (stream-car ps))
           #f)
          (else
            (loop (stream-cdr ps))))))

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
  (zip tr-spiral tl-spiral bl-spiral br-spiral))

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
    (zip spiral-prime-accum
         (stream-map
           (lambda (n)
             (+ (* 4 n) 1))
           (integers-starting-from 1)))))

(define (solve)
  (let* ((indexed-stream
           (zip spiral-prime-ratio
                (integers-starting-from 2)))
         (pair
           (stream-first
             (lambda (pair) (< (car pair) 0.1))
             indexed-stream))
         (index (cadr pair)))
    (- (* 2 index) 1)))

(display (solve))
(newline)
