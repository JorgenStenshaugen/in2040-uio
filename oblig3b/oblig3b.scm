(load "evaluator.scm")

;; --- Oppgave 1a ---
(set! the-global-environment (setup-environment))

;; --- (foo 2 square) ---
;; Når vi kaller på prosedyren cond så blir den tolket som den innebygde prosedyren av den metasirkulære evaluatoren, og ikke variabelen cond.
;; Her benytter vi altså ikke cond som har blitt bundet til verdien 3, men heller den vi gir som parameter når vi gjør kallet på foo, som er verdien 2.
;; Siden cond tilsvarer verdien 2 blir returverdien 0 slik som det er definert i prosedyren foo.

;; --- (foo 4 square) ---
;; Det samme gjelder for dette kallet som den forrige, men her evaluerer vi i tillegg på else.
;; Først så tolker evaluatoren else som cond sin else. I kroppen til else vil else være square, som ble sendt inn som parameter.
;; Returverdien blir 16 siden prosedyren square blir anvendt på verdien 4 som gir 4 * 4.

#|
(cond ((= cond 2) 0)
(else (else 4)))
|#
;; Den metasirkulære evaluatoren tolker den første cond'en som den innebygde versjonen, mens cond'en i kroppen er variabelen som har blitt bundet til verdien 3.
;; Siden 3 ikke er lik 2, går vi videre til else hvor else'en i kroppen evalueres til prosedyren else som deler et tall på 2.
;; I dette tilfellet blir returverdien 2 siden prosedyren anvendes på verdien 4 som gir oss 4 / 2.


;; --- Oppgave 2a ---
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        (list 'not not)
        (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)
        (list '= =)
        (list 'eq? eq?)
        (list 'equal? equal?)
        (list 'display 
              (lambda (x) (display x) 'ok))
        (list 'newline 
              (lambda () (newline) 'ok))
        (list '1+ (lambda (x) (+ x 1))) ;; Lagt til en ny primitiv prosedyre som adderer med 1
        (list '1- (lambda (x) (- x 1))) ;; Lagt til en ny primitiv prosedyre som subtraherer med 1
        ))

(set! the-global-environment (setup-environment))

;; --- Oppgave 2b ---
(define (install-primitive! prim proc)
  (let ((extended (extend-environment (list prim) (list (list 'primitive proc)) the-global-environment)))
    (set! the-global-environment extended)))

" --- Oppgave 2b test --- "
(install-primitive! 'square (lambda (x) (* x x)))
(mc-eval '(square 4) the-global-environment)


;; --- Oppgave 3a ---



(read-eval-print-loop)