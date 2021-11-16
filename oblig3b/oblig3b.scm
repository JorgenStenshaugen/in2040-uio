(load "evaluator.scm")

;; --- Oppgave 1a ---
(set! the-global-environment (setup-environment))
(mc-eval '(+ 1 2) the-global-environment)
