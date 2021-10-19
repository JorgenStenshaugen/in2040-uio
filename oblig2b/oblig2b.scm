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
  (if (eq? stack make-stack) 
  stack))

(define (stack stack)
  stack)

(define (push! stack . args)
  stack)

;; Tests:
(pop! s1)
(stack s1)
(push! s1 'foo 'faa)
(stack s1)