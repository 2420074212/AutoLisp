;;;
;;;
;;;
(setq e1 (entget (car (entsel "\nSelect a block:"))));获取图快1的序列
(setq e2 (entget (car (entsel "\nSelect a block:"))));获取土块2的序列
(setq d1 (cdr (assoc 2 e1)))
(setq d2 (cdr (assoc 10 e1)))
(setq d3 (list (cdr (assoc 41 e1)) (cdr (assoc 42 e1)) (cdr (assoc 43 e1))))
(setq d4 (cdr (assoc 50 e1)));从图块1序列中提取数据
(setq record1 (list d1 d2 d3 d4))
(setq record2 (list (cdr (assoc 2 e2)) 
                    (cdr (assoc 10 e2))
                    (list (cdr (assoc 41 e2)) 
                          (cdr (assoc 42 e2))
                          (cdr (assoc 43 e2))
                    )
                    (cdr (assoc 50 e2))
              )
);从图块2序列中提取数据

;打开文件
(open filename  ;文件名称，包含路径
      mode ;打开模式：r→读、w→写、a→添加
)
(setq fp (open "C:\\Users\\yoophoon\\Desktop\\AutoLISP\\读写文件\\data.txt" "w"))

;写入数据
(prin1 record1 fp)
(princ "\n" fp)
(prin1 record2 fp)
(princ "\n" fp)

;关闭文件
(close fp)