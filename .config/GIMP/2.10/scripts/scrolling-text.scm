(define (script-fu-scrolling-text-animation image drawable text font size color width height scroll-speed num-frames)
(let* (
          ; use the current image
          (img image)
	  (bg (car (gimp-layer-new img width height RGB "Background" 100 NORMAL-MODE)))
          ; Create text layer long enough to scroll
          (text-layer (car (gimp-text-fontname img -1 0 0 text 0 TRUE size PIXELS font)))
          (text-width (car (gimp-drawable-width text-layer)))
          (frame 0)
          (x 0)
        )

    ; Add background layer and fill with white
    (gimp-image-undo-disable img)
    (gimp-image-insert-layer img bg 0 0)
    (gimp-context-set-foreground '(255 255 255))
    (gimp-drawable-fill bg FILL-FOREGROUND)

    ; Set text color
    (gimp-context-set-foreground color)

    ; Move the text layer to the initial position (fully off-screen to the right)
    (set! x width)

    ; Create each frame
    (while (< frame num-frames)
      (let* (
              (frame-layer (car (gimp-layer-new-from-drawable bg img)))
            )
        (gimp-image-insert-layer img frame-layer 0 0)

        ; Fill with background
        (gimp-drawable-fill frame-layer FILL-FOREGROUND)

        ; Copy the text layer
        (let* (
                (copy (car (gimp-layer-copy text-layer TRUE)))
              )
          (gimp-image-insert-layer img copy 0 -1)
          (gimp-layer-set-offsets copy x 0)
          (gimp-edit-copy-visible img)
          (gimp-floating-sel-anchor (car (gimp-edit-paste frame-layer TRUE)))
          (gimp-image-remove-layer img copy)
        )

        (gimp-item-set-name frame-layer (string-append "Frame " (number->string frame)))
        (set! x (- x scroll-speed))
        (set! frame (+ frame 1))
      )
    )

    ; Remove original layers
    (gimp-image-remove-layer img text-layer)
    (gimp-image-remove-layer img bg)

    (gimp-image-undo-enable img)
  )
)

(script-fu-register
  "script-fu-scrolling-text-animation"
  "Scrolling Text Animation"
  "Creates a simple scrolling text animation from right to left"
  "ChatGPT"
  "OpenAI 2024"
  "2024"
  "<Image>/Filters/Animation/Scrolling Text Animation"
  SF-IMAGE "Image" 0
  SF-DRAWABLE "Drawable" 0
  SF-STRING "Text" "This is scrolling text"
  SF-FONT "Font" "Sans"
  SF-ADJUSTMENT "Font size (px)" '(40 1 500 1 10 0 1)
  SF-COLOR "Text color" '(0 0 0)
  SF-ADJUSTMENT "Viewport Width (px)" '(300 50 2000 1 10 0 1)
  SF-ADJUSTMENT "Viewport Height (px)" '(50 10 1000 1 10 0 1)
  SF-ADJUSTMENT "Scroll speed (px/frame)" '(5 1 100 1 10 0 1)
  SF-ADJUSTMENT "Number of frames" '(60 1 500 1 10 0 1)
)
