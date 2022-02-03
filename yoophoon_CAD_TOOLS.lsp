
;;;
;;;备份系统变量并初始化
;;;
(defun yoophoon_INITIALIZE () 
  ;;;备份回显状态并取消回显
  (setq OLD_CMDECHO (getvar "cmdecho"))
  (setvar "cmdecho" 0)

  ;;;备份捕捉模式并取消捕捉
  (setq OLD_OSMODE (getvar "OSMODE"))
  (setvar "OSMODE" 0)

  ;;;
)

;;;
;;;恢复系统之前状态
;;;
(defun yoophoon_RESUME () 
  ;;;恢复回显状态
  (setvar "cmdecho" OLD_CMDECHO)

  ;;;恢复捕捉模式
  (setvar "OSMODE" OLD_OSMODE)

  ;;;
)

(defun C:XIEBIAO (/ OCE) 
  (graphscr)
  (yoophoon_INITIALIZE)
  (setq CCENTER (getpoint "\n输入圆心位置："))
  (setq LSTART (getpoint "\n输入直线起点位置："))
  (setq CRADIUS (getreal "\n输入圆半径："))
  (setq DTEXT (getstring "\n输入标注文字："))
  (setq LEND (polar CCENTER (angle CCENTER LSTART) CRADIUS))
  (command ".CIRCLE" CCENTER CRADIUS)
  (command ".LINE" LSTART LEND "")
  (command ".TEXT" "M" CCENTER 3.5 0 DTEXT)

  (yoophoon_RESUME)
  (princ)
)