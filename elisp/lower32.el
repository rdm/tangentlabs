; elisp to change the way the lower 32 ascii characters
; are displayed. (normally emacs displays them as ^A, etc)
; this only affects the current buffer.
(setq disptab (make-display-table))
(setq buffer-display-table disptab)
(defun ord (chstr) (aref chstr 0))
(defun ascii-glyph (i name chstr)
  (aset disptab i (vector (make-glyph-code (ord chstr) 'escape-glyph))))

(mapcar
 (lambda (x) (apply 'ascii-glyph x))
 '( (00 'NUL "0") (01 'SOH "[") (02 'STX "|") (03 'ETX "]")

    ; the rest of these are all pretty much arbitrary:
    (04 'EOT "$") (05 'ENQ "?") (06 'ACK "/") (07 'BEL "@")
    (08 'BS  "<")                             (11 'VT  "^")
    (12 'FF  "%") (13 'CR  ",") (14 'SO  "N") (15 'SI  "O")
    (16 'DLE "P") (17 'DC1 "1") (18 'DC2 "2") (19 'DC3 "3")
    (20 'DC4 "4") (21 'NAK "\\")(22 'SYN "~") (23 'ETB ")")
    (24 'CAN "X") (25 'EM  "Y") (26 'SUB "Z") (27 'ESC "e")
    
    ; these separator characters probably ought to be something
    ; like "|" but in different colors or something:
    (28 'FS  "!") (29 'GS  ":") (30 'RS  ";") (31 'US  ",")

    ; and delete
    (128 'xxx ">")))

; here are the characters, so you can see the effect:
; ---------------------------------------------------
;   <\t><\n>
; 
; 
