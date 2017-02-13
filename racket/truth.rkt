(define-syntax-rule (while condition body)
	(begin
		(define (loop)
			(when condition
				(begin
					body
				(loop))))
		(loop)))

(define x (read))
(display x)
(while (not (= x 0))
	(begin
		(displayln x)))

