(import srfi-1
        srfi-42)

(define (flatmap proc lst)
  (if (null? lst)
      '()
      (foldr append '() (map proc lst))))

(define (unique-with? n . ms)  ; ms are already mutually unique
  (every (lambda (m) (not (= m n)))
          ms))

(define (stringify ring)
  (foldr string-append
         ""
         (map (lambda (lst)
                (foldr string-append
                       ""
                       (map number->string lst)))
              ring)))

; Total can be 14, 15, 16, 17, 18, or 19:
;  (1 + ... + 5) + (1 + ... + 10) = 70 = 14 * 5
;  (6 + ... + 10) + (1 + ... + 10) = 95 = 19 * 5

; 10 should be not one of ei's in order to make a 16-digit string
(define magic-5-gon-rings
  (list-ec (:range total 14 20)
           (:range i1 1 10)
           (:range i2 1 10)
           (if (unique-with? i2 i1))
           (:range i3 1 10)
           (if (unique-with? i3 i2 i1))
           (:range i4 1 10)
           (if (unique-with? i4 i3 i2 i1))
           (:let in-sum (- (* 5 total) 55))
           (:let i5 (- in-sum i1 i2 i3 i4))
           (if (< 0 i5 10))
           (if (unique-with? i5 i4 i3 i2 i1))
           (:let e1 (- total i1 i2))
           (if (< 0 e1 11))
           (if (unique-with? e1 i5 i4 i3 i2 i1))
           (:let e2 (- total i2 i3))
           (if (< 0 e2 11))
           (if (unique-with? e2 e1 i5 i4 i3 i2 i1))
           (:let e3 (- total i3 i4))
           (if (< 0 e3 11))
           (if (unique-with? e3 e2 e1 i5 i4 i3 i2 i1))
           (:let e4 (- total i4 i5))
           (if (< 0 e4 11))
           (if (unique-with? e4 e3 e2 e1 i5 i4 i3 i2 i1))
           (:let e5 (- total i5 i1))
           (if (< 0 e5 11))
           (if (unique-with? e5 e4 e3 e2 e1 i5 i4 i3 i2 i1))
           (if (every (lambda (e) (> e e1))
                      (list e2 e3 e4 e5)))
           (list (list e1 i1 i2)
                 (list e2 i2 i3)
                 (list e3 i3 i4)
                 (list e4 i4 i5)
                 (list e5 i5 i1))))

(define (solve)
  (foldl (lambda (x y)
           (if (string>? x y)
               x
               y))
         ""
         (map stringify magic-5-gon-rings)))

(display (solve))
(newline)
