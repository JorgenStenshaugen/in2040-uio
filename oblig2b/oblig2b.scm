; IN2040 Obligatorisk innlevering 2b av Jørgen Stenshaugen og Yahya Isam

;; --- Oppgave 1a ---
(define make-counter
  (lambda ()
  (let ((count 0))
    (lambda ()
    (set! count (+ count 1))
    count))))

(define count 42)
(define c1 (make-counter))
(define c2 (make-counter))

;; --- Oppgave 1b --- ** TEGNING **
