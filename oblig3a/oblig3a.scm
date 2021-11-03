(load "prekode3a.scm") ;; Last in prekode.

" --- Oppgave 2a --- "
(define (mem name proc)
	;; Message passing for å kalle de ulike funksjonene basert på kallene.
	(define (func)
		(cond ((equal? name 'memoize) (memoize proc)) ;; Dersom man kaller på memoize
			  ((equal? name 'unmemoize) (unmemoize proc)))) ;; Dersom man kaller på unmemoize

	;; EXPLAIN HERE
	(define (memoize proc)
		proc)

	;; EXPLAIN HERE
	(define (unmemoize proc)
		proc)

	func)

;; Tests:
(define fib (mem 'memoize fib))
(fib 3)
(fib 2)
(fib 4)
(set! fib (mem 'unmemoize fib))
(fib 3)
