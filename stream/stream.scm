(define-library (stream)
  (export cons-stream stream-car stream-cdr stream-null? the-empty-stream
          stream-map stream-filter stream-first stream-take stream-accumulate
          stream-add stream-zip integers-starting-from primes prime? integers
          merge-weighted weighted-pairs)
  (import (scheme base)
          (scheme lazy))
  (begin
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
      (if (stream-null? s)
          the-empty-stream
          (cons-stream
            (proc (stream-car s))
            (stream-map proc (stream-cdr s)))))

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

    (define (stream-take n stream)
      (cond ((= n 0) '())
            ((stream-null? stream)
             (error "End of stream reached -- STREAM-TAKE"))
            (else
              (cons (stream-car stream)
                    (stream-take (- n 1) (stream-cdr stream))))))

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
    (define (stream-zip . streams)
      (cons-stream
        (map stream-car streams)
        (apply stream-zip
               (map stream-cdr streams))))

    ; Primes
    (define (integers-starting-from n)
      (cons-stream
        n
        (integers-starting-from (+ n 1))))

    (define (divisible? n q)
      (= (remainder n q) 0))

    (define (merge-weighted s1 s2 weight)
      (cond ((stream-null? s1) s2)
            ((stream-null? s2) s1)
            (else
              (let* ((s1car (stream-car s1))
                     (s2car (stream-car s2))
                     (s1car-weight (weight s1car))
                     (s2car-weight (weight s2car)))
                (cond ((<= s1car-weight s2car-weight)
                       (cons-stream s1car
                                    (merge-weighted (stream-cdr s1) s2 weight)))
                      ((> s1car-weight s2car-weight)
                       (cons-stream s2car
                                    (merge-weighted s1 (stream-cdr s2)
                                                    weight))))))))
                      ; (else
                      ;   (cons-stream s1car
                      ;                (cons-stream s2car
                      ;                             (merge-weighted (stream-cdr s1)
                      ;                                             (stream-cdr s2)
                      ;                                             weight)))))))))

    (define (weighted-pairs s t weight)
      (cons-stream
        (list (stream-car s) (stream-car t))
        (merge-weighted
          (merge-weighted
            (stream-map (lambda (x) (list (stream-car s) x))
                        (stream-cdr t))
            (stream-map (lambda (x) (list x (stream-car t)))
                        (stream-cdr s))
            weight)
          (weighted-pairs (stream-cdr s)
                          (stream-cdr t)
                          weight)
          weight)))

    (define integers
      (integers-starting-from 1))

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
                (loop (stream-cdr ps))))))))
