;自定义画矩形
(defun C:MYRECT (/ OCE PT1 PT2) 
  (graphscr)
  (setq OCE (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (setq PT1 (getpoint "\nCorner Point1:"))
  (setq PT2 (getpoint "\nCorner Point2:"))
  (command ".PLINE" 
           PT1
           "W"
           0
           ""
           (list (car PT1) (cadr PT2))
           PT2
           (list (car PT2) (cadr PT1))
           "Close"
  )
  (setvar "cmdecho" OCE)
  (princ)
)