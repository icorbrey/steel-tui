(provide Constraint
         Constraint::Percentage
         Constraint::Length
         Constraint::Fill
         Constraint::Max
         Constraint::Min
         Constraint::Percentage?
         Constraint::Length?
         Constraint::Fill?
         Constraint::Max?
         Constraint::Min?
         Constraint::from_percentages
         Constraint::from_lengths
         Constraint::from_fills
         Constraint::from_maxes
         Constraint::from_mins)

;; @doc A constraint that defines the size of a layout element.
;;
;; Constraints can be used to specify a fixed size, a percentage of the
;; available space, a minimum or maximum size, or a fill proportional value for
;; a layout element.
;;
;; Percentage constraints are calculated relative to the entire space being
;; divided, in contrast to fill constraints which are calculated from the space
;; available after applying fixed constraints (i.e. min, max, and length).
;;
;; Constraints are prioritized as: min, max, length, percentage, fill.
(struct Constraint (type value))

(define Constraint->value Constraint-value)
(define Constraint->type Constraint-type)

;; @doc Allocates a fixed percentage of the total available space for this
;;      element.
(define (Constraint::Percentage value) (Constraint "percentage" value))

;; @doc Allocates a fixed amount of space for this element.
(define (Constraint::Length value) (Constraint "length" value))

;; @doc Allocates a proportional amount of excess space for the given value
;;      compared to all other fill constraints. 
(define (Constraint::Fill value) (Constraint "fill" value))

;; @doc Ensures that at minimum the specified amount of space is allocated for
;;      this element.
(define (Constraint::Min value) (Constraint "min" value))

;; @doc Ensures that amount of space allocated for this element is no more than
;;      the specified amount.
(define (Constraint::Max value) (Constraint "max" value))

;; @doc Returns true if the given constraint is Constraint::Percentage.
;; 
;; # Example
;;
;; ```scheme
;; > (Constraint::Percentage? (Constraint::Percentage 100)) ;; => #t
;; > (Constraint::Percentage? (Constraint::Fill 1)) ;; => #f
;; ```
(define (Constraint::Percentage? self) (= "percentage" (Constraint->type self)))

;; @doc Returns true if the given constraint is Constraint::Length.
;; 
;; # Example
;;
;; ```scheme
;; > (Constraint::Length? (Constraint::Length 7)) ;; => #t
;; > (Constraint::Length? (Constraint::Fill 1)) ;; => #f
;; ```
(define (Constraint::Length? self) (= "length" (Constraint->type self)))

;; @doc Returns true if the given constraint is Constraint::Fill.
;; 
;; # Example
;;
;; ```scheme
;; > (Constraint::Fill? (Constraint::Fill 1)) ;; => #t
;; > (Constraint::Fill? (Constraint::Length 1)) ;; => #f
;; ```
(define (Constraint::Fill? self) (= "fill" (Constraint->type self)))

;; @doc Returns true if the given constraint is Constraint::Min.
;; 
;; # Example
;;
;; ```scheme
;; > (Constraint::Min? (Constraint::Min 1)) ;; => #t
;; > (Constraint::Min? (Constraint::Length 1)) ;; => #f
;; ```
(define (Constraint::Min? self) (= "min" (Constraint->type self)))

;; @doc Returns true if the given constraint is Constraint::Max.
;; 
;; # Example
;;
;; ```scheme
;; > (Constraint::Max? (Constraint::Max 1)) ;; => #t
;; > (Constraint::Max? (Constraint::Length 1)) ;; => #f
;; ```
(define (Constraint::Max? self) (= "max" (Constraint->type self)))

;; @doc Converts a list of values into percentage constraints.
;;
;; # Example
;; 
;; ```scheme
;; > (Constraint::from_percentages '(25 50 25))
;; ```
(define (Constraint::from_percentages values)
  (transduce values (mapping Constraint::Percentage) (into-list)))

;; @doc Converts a list of values into length constraints.
;;
;; # Example
;; 
;; ```scheme
;; > (Constraint::from_lengths '(1 2 3))
;; ```
(define (Constraint::from_lengths values)
  (transduce values (mapping Constraint::Length) (into-list)))

;; @doc Converts a list of values into fill constraints.
;;
;; # Example
;; 
;; ```scheme
;; > (Constraint::from_fills '(1 2 3))
;; ```
(define (Constraint::from_fills values)
  (transduce values (mapping Constraint::Fill) (into-list)))

;; @doc Converts a list of values into minimum constraints.
;;
;; # Example
;; 
;; ```scheme
;; > (Constraint::from_mins '(1 2 3))
;; ```
(define (Constraint::from_mins values)
  (transduce values (mapping Constraint::Min) (into-list)))

;; @doc Converts a list of values into maximum constraints.
;;
;; # Example
;; 
;; ```scheme
;; > (Constraint::from_maxes '(1 2 3))
;; ```
(define (Constraint::from_maxes values)
  (transduce values (mapping Constraint::Max) (into-list)))

