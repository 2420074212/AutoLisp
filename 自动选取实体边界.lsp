;;;La为图层名
(defun Layer_zdsb (La / sel make_point_list n mn en entype pt1 pt2 pL sel k p1 p2 
                   enlast ensel
                  ) 
  ;;;===============================
  ;;;表操作函数
  ;;;判断点 p1 是否在点集PL中，是返回T ，不是返回nil，a为精度
  ;;;例 (IsInPointList '(1.0001 1.001 0) '((1 1 0) (2 1 0)) 0.001),返回T
  (defun IsInPointList (p1 PL a) 
    ;(setq n (length PL))
    (if (member t (mapcar '(lambda (b) (equal p1 b a)) PL)) 
      t
      nil
    )
  )
  ;;;取出图元索引i对应的值
  (defun dxf (ent i) 
    (cdr (assoc i (entget ent)))
  )
  ;;;取圆弧的起点、终点。中点
  (defun arc_3point (a / cenp radius STP ENPmp arcmidpoint) 
    (setq cenp (cdr (assoc 10 (entget a))))
    (setq radius (cdr (assoc 40 (entget a))))
    (setq STP (vlax-curve-getPointAtParam A (vlax-curve-getstartparam A)))
    (setq ENP (vlax-curve-getPointAtParam A (vlax-curve-getEndParam A)))
    (setq arcmidpoint (polar (polar stp (angle stp enp) (/ (distance STP ENP) 2.0)) 
                             (angle cenp 
                                    (polar stp 
                                           (angle stp enp)
                                           (/ (distance STP ENP) 2.0)
                                    )
                             )
                             (- radius 
                                (distance 
                                  (polar stp 
                                         (angle stp enp)
                                         (/ (distance STP ENP) 2.0)
                                  )
                                  cenp
                                )
                             )
                      )
    )
    (list stp enp arcmidpoint)
  )


  ;;;根据选择集中的line、arc、circle，生成点集
  (defun make_point_list (s / PL) 
    (setq n  0
          PL '()
          mn (sslength s)
    )
    (repeat mn 
      (setq en     (ssname s n)
            enType (dxf en 0)
      )
      (cond 
        ((= enType "LINE")
         (setq pt1 (dxf en 10)
               pt2 (dxf en 11)
         )
         (if (not (IsInPointList pt1 pl 0.00001)) 
           (setq pl (cons pt1 pl))
         ) ;if
         (if (not (IsInPointList pt2 pl 0.00001)) 
           (setq pl (cons pt2 pl))
         ) ;if
        )
        ((= enType "ARC")
         (setq pt1 (car (arc_3point en))
               pt2 (cadr (arc_3point en))
         )
         (if (not (IsInPointList pt1 pl 0.00001)) 
           (setq pl (cons pt1 pl))
         ) ;if
         (if (not (IsInPointList pt2 pl 0.00001)) 
           (setq pl (cons pt2 pl))
         ) ;if
        )
      ) ;cond
      (setq n (1+ n))
    ) ;repeat
    (setq pl pl)
  ) ;make_point_list
  ;;;此处SEL选择集可自行修改为命令行选择代码
  (setq sel (ssget "x" (list '(0 . "line,arc,circle") (cons 8 La))))
  (if sel 
    (progn 
      (setq Plist (make_point_list sel))
      (setq enlast (entlast)
            ensel  (ssadd)
      )
      (setvar "CLAYER" la)
      (command "_.boundary" "a" "b" "n" sel "" "")
      (setq n  -1
            mn 0
            k  (length Plist)
      )
      (repeat k 
        (setq p0 (nth (setq n (1+ n)) Plist)
              mn n
        )
        (repeat (- k n 1) 
          (setq p1 (nth (setq mn (1+ mn)) Plist))
          (setq p2 (midpoint p0 p1))
          (command p2)
        ) ;repeat
      ) ;repeat
      (command "")
      (while (setq en (entnext enlast)) 
        (setq enlast en)
        (ssadd en ensel)
      ) ;while
      (command "erase" sel "")
      (setq ensel ensel)
    ) ;progn
    nil
  ) ;if
)   