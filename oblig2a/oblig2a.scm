; IN2040 Obligatorisk innlevering 2a av Jørgen Stenshaugen og Yahya Isam

; Oppgave 1

" ---Oppgave 1a--- "
(define (p-cons x y)
  (lambda (proc) (proc x y)))

;; Prosedyre for p-car (car)
(define (p-car proc)
  (proc (lambda (x y) x)))

"Test - p-car: "
(p-car (p-cons "foo" "bar"))

;; Prosedyre for p-cdr (cdr)
(define (p-cdr proc)
  (proc (lambda (x y) y)))

"Test - p-cdr: "
(p-cdr (p-cons "foo" "bar"))

"Test - p-car og p-cdr: "
(p-car (p-cdr (p-cons "zoo" (p-cons "foo" "bar"))))

(newline)
" ---Oppgave 1b--- "
(define foo 42)

(let ((foo 5)
      (x foo))
  (if (= x foo)
      'same
      'different))

"Applikasjon av lambda-uttrykk (1/2): "
;; Følgende uttrykk evaluerer til 'different' akkurat som let-uttrykket ovenfor
((lambda (foo x)
   (= x foo)
   'same
   'different)
 5 foo)

;; Variant (Sjekk med Jørgen om dette stemmer eller ikke, sekvensielt/parallellt)
;; I et vanlig let-uttrykk opprettes variabelbindingene parallellt, mens parallellt i let*
((lambda (foo)
   ((lambda (x)
      (= x foo)
      'same
      'different)
    foo))
 5)

(newline)
(let ((bar foo)
      (baz 'towel))
  (let ((bar (list bar baz))
        (foo baz))
    (list foo bar)))

"Applikasjon av lambda-uttrykk (2/2): "
;; Følgende uttrykk evaluerer til '(towel (42 towel))' akkurat som let-uttrykket ovenfor
((lambda (bar)
   ((lambda (baz)
      ((lambda (bar)
         ((lambda (foo)
            (list foo bar))
          baz))
       (list bar baz)))
    'towel))
 foo)

(newline)
" ---Oppgave 1c--- "
(define foo (list 21 + 21))
(define baz (list 21 list 21))
(define bar (list 84 / 2))

(define (infix-eval exp)
  (let* ((operator (car (cdr exp)))
         (operand1 (car exp))
         (operand2 (car (cdr (cdr exp)))))
    (operator operand1 operand2)))

"Test - infix-eval: "
(infix-eval foo)
(infix-eval baz)
(infix-eval bar)

(newline)
;; ---Oppgave 1d--- 
(define bah '(84 / 2))
;;(infix-eval bah)

;; Forklaring av hvorfor utfallet blir annerledes:
#|
Resultatet av kallet med bah som argument gir oss en feilmelding som sier at /
ikke er en prosedyre, og dette er fordi quote ikke evaluerer på den vanlige
måten. På grunn av quote, blir / evaluert til et symbol i stedet for en prosedyre.
Dette var ikke tilfellet da vi gjorde kallet med bar, fordi da ble datastrukturen
list benyttet i stedet for quote, som er en del av definisjonen av prosedyren bah.
|#

;; " --- Oppgave 2a --- "

(load "huffman.scm")

(define (decode-h bits tree)
  (define (decode-1 bits current-branch result)
    (if (null? bits)
        (reverse result)
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (decode-1 (cdr bits) tree (cons (symbol-leaf next-branch) result) )
              (decode-1 (cdr bits) next-branch result)))))
  (decode-1 bits tree '()))

" --- Oppgave 2b --- "
(decode-h sample-code sample-tree)

" --- Oppgave 2c --- "
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))


(define (encode code tree)
  (define (encode-1 code current-branch result)
    (if (null? code)
        (reverse result)
        (if (leaf? current-branch)
            (if (eq? (car code) (car (symbols current-branch)))
                (encode-1 (cdr code) tree result)
                (list))
            
            (append (encode-1 code (left-branch current-branch) (cons 0 result))
                    (encode-1 code (right-branch current-branch) (cons 1 result))))))
  (encode-1 code tree '()))

(decode (encode '(ninjas fight ninjas) sample-tree) sample-tree)

" --- Oppgave 2d --- "
(define (grow-huffman-tree items)
  (define (grow-huffman-tree-1 leaf)
    (if (null? (cdr leaf))
        (car leaf)
        (let* ((left (car leaf))
              (right (cadr leaf))
              (branch (make-code-tree left right)))
          (grow-huffman-tree-1 (adjoin-set branch (cddr leaf))))))
  (grow-huffman-tree-1 (make-leaf-set items)))

(define freqs '((a 2) (b 5) (c 1) (d 3) (e 1) (f 3)))
(define codebook (grow-huffman-tree freqs))
(decode (encode '(a b c) codebook) codebook)

;; --- Oppgave 2e --- 

;; - Svar: Det blir brukt 43 bits på å kode meldingen.
;; - Svar: Den gjennomsnittlige lengden på hvert kodeord som brukes er 2.8.
;; - Svar: Vi starter med å telle hvor mange symboler vi har, som i vårt tilfelle er 16. Deretter tar vi 2^x frem til vi kommer til et svar som tilsvarer minst 16.
;;   Svaret på det minste antall bits man ville trengt er altså x, som blir 4 for oss siden 2^4 = 16.

" --- Oppgave 2f --- "
(define (huffman-leaves tree)
  (if (leaf? tree)
      (cons (list (symbol-leaf tree) (weight-leaf tree)) '())
      (append (huffman-leaves (left-branch tree))
              (huffman-leaves (right-branch tree)))))

(huffman-leaves sample-tree)
