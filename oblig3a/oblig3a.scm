(load "prekode3a.scm")
(fib 3)
(fib 2)
(fib 1)
(fib 3)
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

;; Tests:
" --- Oppgave 2a tests --- "
(set! fib (mem 'memoize fib))
(fib 3)
(fib 3)
(fib 2)
(fib 4)
" --- Oppgave 2b tests --- "
(set! fib (mem 'unmemoize fib))
(fib 3)

" --- MORE TESTS --- "
(set! test-proc (mem 'memoize test-proc))
(test-proc)
(test-proc)
(test-proc 40 41 42 43 44)
(test-proc 40 41 42 43 44)
(test-proc 42 43 44)

" --- 1 c --- "
(define mem-fib (mem 'memoize fib))

(mem-fib 3)
(mem-fib 3)

#|
Hver gang man kaller på mem-fib så blir prosedyren mem kalt på nytt og kun det første kallet fra fib blir lagret i tabellen.
I den memoiserte versjonen som settes med set! så kaller den alltid på den nye versjonen av fib, som altså har evaulerte verdier i tabellen sin.
|#

(define (list-to-stream liste)

)

(define (stream-to-list stream)

)
