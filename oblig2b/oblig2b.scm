; IN2040 Obligatorisk innlevering 2b av Jørgen Stenshaugen og Yahya Isam

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

" --- Oppgave 2a --- "
(define (make-stack items)
  (define (func name . args)
    (cond ((equal? name 'pop!) (pop!))
          ((equal? name 'stack) (stack))
          ((equal? name 'push!) (push! args))))

  (define (pop!)
    (if (not (null? items)) (set! items (cdr items))))

  
  (define (stack)
    items)

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

(define (pop! stack)
  (stack 'pop!))

(define (stack stack)
  (stack 'stack))

(define (push! stack . args)
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

;; b) set-car! bytter ut verdien av (car (car bah)) til å peke mot verdien 42, som resulterer i ((42 towel) 42 towel).
" --- Oppgave 3c --- "


(define (cycle? items)
  (define (cycle-iter left right)
    (cond
      ((or (null? right) (null? (cdr right))) #f)
      ((eq? left right) #t)
      (else (cycle-iter (cdr left) (cddr right)))))

  (if (null? items)
      #f
      (cycle-iter items (cdr items))))

;; Tests: 
(cycle? '(hey ho))
(cycle? '(la la la))
(cycle? bah)
(cycle? bar)

