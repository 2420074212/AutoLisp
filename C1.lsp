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

;自定义圆命令
(defun C:MYCIRCLE (/ OCE mycen myrad) 
  (graphscr)
  (setq OCE (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (setq mycen (getpoint "\nCenter point:"))
  (setq myrad (getdist mycen "\nRadius:"))
  (command "CIRCLE" mycen myrad)
  (setvar "cmdecho" OCE)
  (princ)
)