;这是单行注释
;|这是多行注释|;

;自定义直线命令
(defun C:MYLINE1 (/ OCE LP1 LP2) 
  (graphscr)
  (setq oce (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (setq LP1 (getpoint "\nStart point:"))
  (setq LP2 (getpoint "\nEnd point:"))
  (command "LINE" LP1 LP2 "")
  (setvar "cmdecho" OCE)
  (princ)
)