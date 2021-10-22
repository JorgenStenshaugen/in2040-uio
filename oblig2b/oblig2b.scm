; IN2040 Obligatorisk innlevering 2b av Jørgen Stenshaugen og Yahya Isam

;; Prosedyren make-counter returnerer en ny prosedyre som benytter innkapsling slik at den kan
;; holde styr på hvor mange ganger den blir kalt på. Her er 'count' en privat variabel som starter
;; med å bli initialisert til 0 og inkrementeres destruktivt med 1 ved bruk av set!, hver gang den blir kalt på.
" --- Oppgave 1a --- "
(define make-counter
  (lambda ()
  (let ((count 0)) 
    (lambda ()
    (set! count (+ count 1))
    count))))

(define count 42)
(define c1 (make-counter))
(define c2 (make-counter))

;; Tests:
(c1)
(c1)
(c1)
count
(c2)

;; --- Oppgave 1b --- ** TEGNING **

;; Prosedyren make-stack tar 'items' som parameter som skal returnere en stack.
;; make-stack har 3 beskjeder: 'push!, 'pop! og 'stack.



" --- Oppgave 2a --- "
(define (make-stack items)
  ;; Message passing for å kalle de ulike funksjonene basert på kallene.
  (define (func name . args)
    (cond ((equal? name 'pop!) (pop!)) ;; Dersom man kaller på pop!
          ((equal? name 'stack) (stack)) ;; Dersom man kaller på stack
          ((equal? name 'push!) (push! args)))) ;; Dersom man kaller på push med argumenter.

  ;; Beskjeden 'pop! destruktivt fjerner det øverste (altså elementet som er på toppen av stacken) elementet i stacken.
  (define (pop!)
    (if (not (null? items)) (set! items (cdr items))))

  ;; Beskjeden 'stack returnerer listen av alle elementer som er i stacken.
  (define (stack)
    items)
  ;; Beskjeden 'push! legger elementer destruktivt i stacken.
  (define (push! new-items)
    (set! items (append (reverse new-items) items)))
 
  func)

;; Tests:
(define s1 (make-stack (list 'foo 'bar)))
(define s2 (make-stack '()))

(s1 'pop!)
(s1 'stack)
(s2 'pop!)
(s2 'push! 1 2 3 4)
(s2 'stack)
(s1 'push! 'bah)
(s1 'push! 'zap 'zip 'baz)
(s1 'stack)


" --- Oppgave 2b --- "
;; Her gjør prosedyrene det samme som beskjedene i 2a,
;; bare at vi har abstrahert og definert et mer intuitivt grensesnitt.
(define (pop! stack)
  (stack 'pop!)) ;; Kaller på stack'ens prosedyre for pop!

(define (stack stack)
  (stack 'stack)) ;; Kaller på stack'ens prosedyre for stack

(define (push! stack . args) ;; Kaller på stack'ens prosedyre for push! og applyer argumentene på prosedyren
  (apply stack 'push! args))

;; Tests:
(pop! s1)
(stack s1)
(push! s1 'foo 'faa)
(stack s1)

" --- Oppgave 3a --- "

(define bar (list 'a 'b 'c 'd 'e))
(set-cdr! (cdddr bar) (cdr bar))
bar
(list-ref bar 0)
(list-ref bar 1)
(list-ref bar 2)
(list-ref bar 7)

;; a) I set-cdr! setter vi at d skal referere til (cdr bar) som skaper en uendelig løkke med indekser som vi kan referere til når vi gjør et kall på list-ref.


" --- Oppgave 3b --- "
(define bah (list 'bring 'a 'towel))
(set-car! bah (cdr bah))
bah
(set-car! (car bah) 42)
bah
(list-ref bah 0)
;; set-car! bytter ut verdien av (car (car bah)) til å peke mot verdien 42, som resulterer i ((42 towel) 42 towel).


;; Predikatet 'cycle?' sjekker om en listestruktur er syklisk eller ikke.
;; Dersom listestrukturen er syklisk, vil #t returneres, ellers #f.
" --- Oppgave 3c --- "
(define (cycle? items)
  (define (cycle-iter left right) ;; Hjelpe prosedyre
    (cond
      ((or (null? right) (null? (cdr right))) #f) ;; Dersom høyre listen eller cdr av høyre listen er tom, så er den ikke syklisk.
      ((eq? left right) #t) ;; Dersom venstre og høyre listen er like så er den syklisk.
      (else (cycle-iter (cdr left) (cddr right))))) ;; Kjør rekursjon hvor vi fjerner det første elementet på venstre listen, og 2 på høyre.

  ;; Liten sjekk om listen er tom eller ikke. Om den ikke er tom så kjører vi rekursjonen vår.
  ;; Vi starter med at høyre listen er en mindre enn venstre.
  (if (null? items)
      #f
      (cycle-iter items (cdr items))))

;; Tests: 
(cycle? '(hey ho))
(cycle? '(la la la))
(cycle? bah)
(cycle? bar)

;; --- Oppgave 3d ---
;; Sirkulære lister er ikke ekte lister på grunn av at representasjonen av en liste i Scheme er
;; sammensatte cons-par som alltid vil ende med en tom liste. Når det gjelder representasjonen
;; av sirkulære lister, vil de aldri ende med en tom liste.