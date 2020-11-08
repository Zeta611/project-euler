; Uncomment and use the following when installing r7rs egg issue is resolved.
; (define-library (zeta stream)
;   (export cons-stream stream-car stream-cdr stream-null? the-empty-stream
;           stream-map stream-filter stream-first stream-take stream-accumulate
;           stream-add stream-zip integers-starting-from)
;   (import (scheme base)
;           (scheme lazy))
;   (begin
(module stream
  (cons-stream stream-car stream-cdr stream-null? the-empty-stream stream-map
    stream-filter stream-first stream-take stream-accumulate
    stream-add stream-zip integers-starting-from primes prime?)
  (import scheme
          (chicken base))

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
              (loop (stream-cdr ps)))))))
