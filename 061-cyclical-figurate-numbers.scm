(import srfi-1
        srfi-42)

(define (flatmap proc lst)
  (if (null? lst)
      '()
      (foldr append '() (map proc lst))))

(define (permutations s)
  (define (remove item sequence)
    (filter (lambda (x) (not (equal? x item)))
            sequence))
  (if (null? s)
      (list '())
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))

(define (triangle n)
  (/ (* n (+ n 1))
     2))

(define (square n)
  (* n n))

(define (pentagonal n)
  (/ (* n
        (- (* 3 n) 1))
     2))

(define (hexagonal n)
  (* n
     (- (* 2 n) 1)))

(define (heptagonal n)
  (/ (* n
        (- (* 5 n) 3))
     2))

(define (octagonal n)
  (* n
     (- (* 3 n) 2)))

(define (zero-at-10? n)
  (zero? (remainder (quotient n 10)
                    10)))

(define (polys-in-range poly)
  (let* ((lo-bound
           (let loop ((i 1))
             (if (> (poly i) 1000)
                 i
                 (loop (+ i 1)))))
         (up-bound
           (let loop ((i lo-bound))
             (if (> (poly i) 10000)
                 i
                 (loop (+ i 1))))))
    (list-ec (:range i lo-bound up-bound)
             (:let p (poly i))
             (not (zero-at-10? p))
             p)))

(define (digits-match? a b)
  (let ((a-upper-two-digits
          (quotient a 100))
        (b-lower-two-digits
          (remainder b 100)))
    (= a-upper-two-digits b-lower-two-digits)))

(define (unique-with? n . ms)  ; ms are already mutually unique
  (every (lambda (m) (not (= m n)))
          ms))

(define (caddddr l) (car (cddddr l)))
(define (cadddddr l) (cadr (cddddr l)))

(define six-cyclic-4-digit-numbers
  (let ((tris (polys-in-range triangle))
        (squs (polys-in-range square))
        (pens (polys-in-range pentagonal))
        (hexs (polys-in-range hexagonal))
        (heps (polys-in-range heptagonal))
        (octs (polys-in-range octagonal)))
    (first-ec #f
              (:list comb (permutations (list tris squs pens hexs heps octs)))
              (:let as (car comb))
              (:let bs (cadr comb))
              (:let cs (caddr comb))
              (:let ds (cadddr comb))
              (:let es (caddddr comb))
              (:let fs (cadddddr comb))
              (:list a as)
              (:list b bs)
              (and (unique-with? b a)
                   (digits-match? b a))
              (:list c cs)
              (and (unique-with? c b a)
                   (digits-match? c b))
              (:list d ds)
              (and (unique-with? d c b a)
                   (digits-match? d c))
              (:list e es)
              (and (unique-with? e d c b a)
                   (digits-match? e d))
              (:list f fs)
              (and (unique-with? f e d c b a)
                   (digits-match? f e)
                   (digits-match? a f))
              (list (list a b c d e f)
                    (+ a b c d e f)))))

(display six-cyclic-4-digit-numbers)
(newline)
