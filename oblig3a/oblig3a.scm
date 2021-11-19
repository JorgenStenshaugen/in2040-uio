(load "prekode3a.scm")

;; --- Oppgave 1 ---
(define procs (make-table))
(define (mem name proc)
  ;; Message passing for å kalle på de ulike funksjonene basert på prosedyrene.
  (define (func name proc)
    (cond ((equal? name 'memoize) (memoize proc)) ;; Dersom man kaller på memoize
          ((equal? name 'unmemoize) (unmemoize proc)))) ;; Dersom man kaller på unmemoize
  
  ;; --- Oppgave 1a ---
  (define (memoize proc)
    (let ((table (make-table)))
      (let ((memoized 
             (lambda args
               (or (lookup args table)
                   (let ((value (apply proc args)))
                     (insert! args value table)
                     value)))))
      (insert! memoized proc procs)
      memoized)))

  ;; --- Oppgave 1b ---
  (define (unmemoize proc)
    (lookup proc procs))

  (func name proc))

(newline)
" --- Oppgave 1a tests --- "
(set! fib (mem 'memoize fib))
(fib 3)
(fib 3)
(fib 2)
(fib 4)

(newline)
" --- Oppgave 1b tests --- "
(set! fib (mem 'unmemoize fib))
(fib 3)

" --- Flere tests --- "
(set! test-proc (mem 'memoize test-proc))
(test-proc)
(test-proc)
(test-proc 40 41 42 43 44)
(test-proc 40 41 42 43 44)
(test-proc 42 43 44)

(newline)
" --- Oppgave 1c test --- "
(define mem-fib (mem 'memoize fib))

(mem-fib 3)
(mem-fib 3)
(mem-fib 2)

#|
Hver gang man kaller på mem-fib så blir prosedyren mem kalt på nytt og kun det første kallet fra fib blir lagret i tabellen.
I den memoiserte versjonen som settes med set! så kaller den alltid på den nye versjonen av fib, som altså har evaulerte verdier i tabellen sin.
|#

;; --- Oppgave 2a ---
(define (list-to-stream liste)
  (if (null? liste)
      the-empty-stream
      (cons-stream (car liste) (list-to-stream (cdr liste)))))

(define (stream-to-list stream . args)
  (if (stream-null? stream)
      '()
      (cond ((null? args)
            (cons (stream-car stream) (stream-to-list (stream-cdr stream))))
            ((= (car args) 0) '())
            (else (cons (stream-car stream)
                        (stream-to-list (stream-cdr stream) (- (car args) 1)))))))

(newline)
" --- Oppgave 2a tests --- "
(list-to-stream '(1 2 3 4 5))
(stream-to-list (stream-interval 10 20))
(show-stream nats 15)
(stream-to-list nats 10)


;; --- Oppgave 2b ---
(define (stream-take n stream)
  (if (or (stream-null? stream) (= n 0))
      the-empty-stream
      (cons-stream (stream-car stream)
            (stream-take (- n 1) (stream-cdr stream)))))

(newline)
" --- Oppgave 2b tests --- "
(define foo (stream-take 10 nats))
foo
(show-stream foo 5)
(show-stream foo 20)
(show-stream (stream-take 15 nats) 10)


;; --- Oppgave 2c ---
;; Et problem vi ser er at dersom vi har et uendelig strøm, vil prosedyrene gå inn i en uendelig løkke med kallet på stream-cdr.

;; --- Oppgave 2d ---
(define (remove-duplicates stream)
  (if (stream-null? stream)
      the-empty-stream
      (cons-stream (stream-car stream)
                   (remove-duplicates 
                    (stream-filter
                     (lambda (value) (not (equal? (stream-car stream) value)))
                     (stream-cdr stream))))))

(newline)
" --- Oppgave 2d tests --- "
(define test (list-to-stream '(2 2 3 4 5)))
(show-stream (remove-duplicates test) 5)