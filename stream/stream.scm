(define-library (stream)
  (export cons-stream stream-car stream-cdr stream-null? the-empty-stream
          stream-map stream-filter stream-first stream-take stream-accumulate
          stream-add stream-zip integers-starting-from prime-stream prime?
          nat-stream stream-merge-weighted stream-weighted-tuples)
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
      (cond ((zero? n) '())
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

    (define (integers-starting-from n)
      (cons-stream
        n
        (integers-starting-from (+ n 1))))

    (define (divisible? n q)
      (zero? (remainder n q)))

    (define (stream-merge-weighted weight s1 s2)
      (cond ((stream-null? s1) s2)
            ((stream-null? s2) s1)
            (else
              (let* ((s1car (stream-car s1))
                     (s2car (stream-car s2))
                     (s1car-weight (weight s1car))
                     (s2car-weight (weight s2car)))
                (cond ((<= s1car-weight s2car-weight)
                       (cons-stream
                         s1car
                         (stream-merge-weighted weight
                                                (stream-cdr s1)
                                                s2)))
                      ((> s1car-weight s2car-weight)
                       (cons-stream
                         s2car
                         (stream-merge-weighted weight
                                                s1
                                                (stream-cdr s2)))))))))

    (define (stream-weighted-tuples weight . streams)
      (if (null? streams)
          (cons-stream '() the-empty-stream)
          (let* ((stream (car streams))
                 (rest (cdr streams))
                 (rest-tuples
                   (apply stream-weighted-tuples
                          (lambda (tuple)  ; partial weight
                            (weight (cons (stream-car stream) tuple)))
                          rest)))
            (let combine-with-rest ((stream stream)
                                    (rest-tuples rest-tuples))
              (if (or (stream-null? stream)
                      (stream-null? rest-tuples))
                  the-empty-stream  ; {} x S = {}
                  (let ((s-car (stream-car stream))
                        (s-cdr (stream-cdr stream))
                        (r-car (stream-car rest-tuples))
                        (r-cdr (stream-cdr rest-tuples)))
                    (cons-stream (cons s-car r-car)
                                 (stream-merge-weighted
                                   weight
                                   (stream-map (lambda (t) (cons s-car t))
                                               r-cdr)
                                   (stream-merge-weighted
                                     weight
                                     (stream-map (lambda (x) (cons x r-car))
                                                 s-cdr)
                                     (combine-with-rest s-cdr r-cdr))))))))))

    (define nat-stream
      (integers-starting-from 1))

    (define prime-stream
      (cons-stream
        2
        (stream-filter prime?
                       (integers-starting-from 3))))

    (define (prime? n)
      (let loop ((ps prime-stream))
        (cond ((< n (square (stream-car ps)))
               #t)
              ((divisible? n (stream-car ps))
               #f)
              (else
                (loop (stream-cdr ps))))))))
