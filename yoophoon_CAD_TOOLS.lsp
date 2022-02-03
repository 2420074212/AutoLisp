
;;;
;;;备份系统变量并初始化
;;;
(defun yoophoon_INITIALIZE (CMDECHO_ON OSMODE_ON) 
  ;;;备份回显状态并取消回显
  (setq OLD_CMDECHO (getvar "cmdecho"))
  (if (= CMDECHO_ON 0) 
    (setvar "cmdecho" 0)
  )


  ;;;备份捕捉模式并取消捕捉
  (setq OLD_OSMODE (getvar "OSMODE"))
  (if (= OSMODE_ON 0) 
    (setvar "OSMODE" 0)
  )


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

  ;;;画圆圈标注样式
(defun C:XIEBIAO (/ OCE) 
  (graphscr)
  (yoophoon_INITIALIZE 0 0)
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

  ;;;画双线（double line)
(defun C:DoubleLine () 
  (graphscr)
  (yoophoon_INITIALIZE 0 1)
  (setq LineWidth (getreal "\n输入双线间距:")
        p1        (getpoint "\n输入双线起始点:")
        p2        (getpoint "\n输入双线终止点:")
  )
  (command ".line" 
           (polar p1 (+ (angle p1 p2) (/ PI 2)) (/ LineWidth 2))
           (polar p2 (+ (angle p1 p2) (/ PI 2)) (/ LineWidth 2))
           ""
  )
  (command ".line" 
           (polar p1 (+ (angle p2 p1) (/ PI 2)) (/ LineWidth 2))
           (polar p2 (+ (angle p2 p1) (/ PI 2)) (/ LineWidth 2))
           ""
  )
  (yoophoon_RESUME)
  (princ)
)