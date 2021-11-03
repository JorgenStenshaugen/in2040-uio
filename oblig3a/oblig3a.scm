(load "prekode3a.scm")

;; --- Oppgave 2 ---
(define (mem name proc)
  ;; Message passing for å kalle de ulike funksjonene basert på kallene.
  (define (func name proc)
    (cond ((equal? name 'memoize) (memoize proc)) ;; Dersom man kaller på memoize
          ((equal? name 'unmemoize) (unmemoize proc)))) ;; Dersom man kaller på unmemoize

  ;; --- Oppgave 2a ---
  ;; EXPLAIN HERE
  (define (memoize proc)
    (let ((table (make-table)))
      (lambda args
        (if (null? args)
            (proc args)
        (or (lookup args table)
            (let ((value (apply proc args)))
              (insert! args value table)
              value))))))

  ;; --- Oppgave 2b ---
  ;; EXPLAIN HERE
  (define (unmemoize proc)
    (define table (make-table))
    (or (lookup proc table)
       (proc)
       ))

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