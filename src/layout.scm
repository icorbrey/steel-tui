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
         Constraint::from_mins
         Direction::Horizontal
         Direction::Vertical
         Flex::SpaceBetween
         Flex::SpaceAround
         Flex::Center
         Flex::Start
         Flex::End
         Layout
         Layout->constraints
         Layout->direction
         Layout->spacing
         Layout->padding
         Layout->flex
         Padding
         Padding->Horizontal
         Padding->Vertical
         Rect
         Rect->height
         Rect->width
         Rect->left
         Rect->top
         Rect::bottom
         Rect::offset
         Rect::inner
         Rect::right
         Rect::area
         Rect::left
         Rect::top
         Spacing
         Spacing::Overlap
         Spacing::Space)

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

(define Direction::Horizontal "horizontal")
(define Direction::Vertical "vertical")

;; @doc Adds excess space between each element.
(define Flex::SpaceBetween "space-between")

;; @doc Adds excess space around each element.
(define Flex::SpaceAround "space-around")

;; @doc Centers items within the container.
(define Flex::Center "center")

;; @doc Aligns items to the start of the container.
(define Flex::Start "start")

;; @doc Aligns items to the end of the container.
(define Flex::End' "end")

(struct Layout (
          #:constraints [constraints '((Constraint::Fill 1))]
          #:direction [direction Direction::Horizontal]
          #:spacing [spacing (Spacing::Space 0)]
          #:padding [padding (Padding)]
          #:flex [flex Flex::Start]
        ))

(define Layout->constraints Layout-constraints)
(define Layout->direction Layout-direction)
(define Layout->spacing Layout-spacing)
(define Layout->padding Layout-padding)
(define Layout->flex Layout-flex)

;; @doc The amount of space to pad the inside of a rect with.
(struct Padding (
          #:horizontal [horizontal 0]
          #:vertical [vertical 0]
        ))

(define Padding->horizontal Padding-horizontal)
(define Padding->vertical Padding-vertical)

;; @doc The amount of space to shift a rect by.
(struct Offset (
          #:x [x 0]
          #:y [y 0]
        ))

(define Offset->x Offset-x)
(define Offset->y Offset-y)

;; @doc A rectangular area used to compute layout.
(struct Rect (
          #:height [height 0]
          #:width [width 0]
          #:left [left 0]
          #:top [top 0]
        ))

(define Rect->height Rect-height)
(define Rect->width Rect-width)
(define Rect->x Rect-x)
(define Rect->y Rect-y)

;; @doc The area of the rectangle.
(define (Rect::area self) (* (Rect->height self) (Rect->width self)))

;; @doc The y-value of the bottom edge of the rectangle.
(define (Rect::bottom self) (+ (Rect->height self) (Rect->y self)))

;; @doc The x-value of the right edge of the rectangle.
(define (Rect::right self) (+ (Rect->width self) (Rect->x self)))

;; @doc The x-value of the left edge of the rectangle.
(define Rect::left Rect->x)

;; @doc The y-value of the top edge of the rectangle.
(define Rect::top Rect->y)

;; @doc Returns a new rectangle placed within this rectangle padded by the
;;      given amount.
(define (Rect::inner self padding)
  (Rect #:height (- (Rect->height self) (* 2 (Padding->vertical padding)))
        #:width (- (Rect->width self) (* 2 (Padding->horizontal padding)))
        #:left (+ 1 (Rect->left self))
        #:top (+1 (Rect->top self))))

;; @doc Returns a new rectangle offset by the given amount.
(define (Rect::offset self offset)
  (Rect #:left (+ (Offset->x offset) (Rect->left self))
        #:top (+ (Offset->y offset) (Rect->top self))
        #:height (Rect->height self)
        #:width (Rect->width self)))

(struct Spacing (type value))

(define (Spacing::Overlap value) (Spacing "overlap" value))
(define (Spacing::Space value) (Spacing "space" value))
