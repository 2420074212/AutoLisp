;;-------------------自动图层开始----------------------------------------------------------------
(defun xlr-autolayer () 
  (vl-load-com)
  ;; 图层初始化列表 内容：commands layers color linetype plottable
  (setq *doc (vla-get-activedocument (vlax-get-acad-object)))
  (setq *lays (vla-get-layers *doc))
  (setq *laylst (list 
                  (list "DIMANGULAR" "DIM" 3 "continuous" T)
                  (list "DIMALIGNED" "DIM" 3 "continuous" T)
                  (list "DIMBASELINE" "DIM" 3 "continuous" T)
                  (list "DIMCENTER" "DIM" 3 "continuous" T)
                  (list "DIMCONTINUE" "DIM" 3 "continuous" T)
                  (list "DIMDIAMETER" "DIM" 3 "continuous" T)
                  (list "DIMLINEAR" "DIM" 3 "continuous" T)
                  (list "DIMORDINATE" "DIM" 3 "continuous" T)
                  (list "DIMRADIUS" "DIM" 3 "continuous" T)
                  (list "QDIM" "DIM" 3 "continuous" T)
                  (list "QLEADER" "DIM" 3 "continuous" T)
                  (list "DTEXT" "PUB_TEXT" 7 "continuous" T)
                  (list "MTEXT" "PUB_TEXT" 7 "continuous" T)
                  (list "TEXT" "PUB_TEXT" 7 "continuous" T)
                  (list "BHATCH" "PUB_HATCH" 6 "continuous" T)
                  (list "HATCH" "PUB_HATCH" 6 "continuous" T)
                  (list "DONUT" "钢筋" 4 "Continuous" T)
                  (list "breakline" "折断线" 4 "Continuous" T)
                  (list "POINT" "点" 4 "continuous" T)
                  (list "XLINE" "辅助线" 8 "continuous" T)
                  (list "LINE" "0" NIL "continuous" T)
                  (list "XREF" "引用" 7 "continuous" T)
                  (list "pline" "多义线" 2 "center" T)
                  (list "*vports" "PUB_WINDW" 4 "Continuous" T)
                  (list "revcloud" "修订" 2 "Continuous" T)
                  (list "table" "表格" 7 "Continuous" T)
                  (list "imageattach" "引用" 7 "continuous" T)
                )
  )
  (setq OldLayer nil)
  (setq *cmdlst (mapcar 'strcase (mapcar 'car *laylst)))
  (mapcar '(lambda (x) (vlr-command-reactor nil x)) 
          (list '((:vlr-commandWillStart . xlr-start)) 
                '((:vlr-commandEnded . xlr-end))
                '((:vlr-commandCancelled . xlr-cancel))
          )
  )
  (vlr-editor-reactor 
    nil
    '((:vlr-commandwillstart . xlr-edit))
  )
)
;;;----------------------------------------------------------------------------;;;
(defun xlr-edit (CALL CALLBACK /) 
  (foreach N *laylst 
    (if (= (strcase (car CALLBACK)) (strcase (car N))) 
      ; 命令反应器返回信息如果与设置的命令相同.
      (progn  ;建立图层
             (apply 'xsetlays (cdr N))
             ;(setvar "CLAYER" (cadr N));设为当前层.
      )
    )
  )
)
;;;----------------------------------------------------------------------------;;;
(defun xlr-start (calling-reactor xlr-startInfo /) 
  (foreach N *laylst 
    (if (= (strcase (car xlr-startInfo)) (strcase (car N))) 
      ; 命令反应器返回信息如果与设置的命令相同.
      (progn  ;建立图层

             (apply 'xsetlays (cdr N))
             ;(setvar "CLAYER" (cadr N));设为当前层.
      )
    )
  )
)
;;;----------------------------------------------------------------------------;;;
(defun xlr-end (calling-reactor xlr-endInfo / cmd) 
  (setq cmd (car xlr-endInfo))
  (if (member cmd *cmdlst) 
    (if (/= oldlayer nil) 
      (progn 
        (setvar "CLAYER" OldLayer)
        (setq OldLayer nil)
      )
    )
  )
)
;;;----------------------------------------------------------------------------;;;
(defun xlr-cancel (calling-reactor xlr-cancelInfo / cmd) 
  (setq cmd (car xlr-cancelInfo))
  (if (member cmd *cmdlst) 
    (if (/= oldlayer nil) 
      (progn 
        (setvar "CLAYER" OldLayer)
        (setq OldLayer nil)
      )
    )
  )
)
;;;----------------------------------------------------------------------------;;; 
(defun xsetlays (LAY-NAM COLOR LTYPE plotk / LAYOBJ LTYPESOBJ) 
  (if (tblobjname "layer" LAY-NAM) 
    (progn 
      (if 
        (/= (strcase (getvar "CLAYER")) 
            (strcase LAY-NAM)
        )
        (setq OldLayer (getvar "CLAYER"))
        (progn 
          (if (= oldlayer nil) 
            (setq OldLayer LAY-NAM)
          )
        )
      )
      (setvar "CLAYER" lay-nam)
    )
    (progn  ;添加图层.
           (vl-catch-all-error-p 
             (vl-catch-all-apply 'vla-add (list *lays LAY-NAM))
           )
           (setq LAYOBJ (vla-item *lays LAY-NAM))
           (if (not (tblobjname "ltype" LTYPE))  ;添加线型.
             (progn 
               (setq LTYPESOBJ (vla-get-linetypes *doc))
               (vla-load LTYPESOBJ LTYPE (findfile "acad.lin"))
               ;>>>　要加强，在多个*.lin寻找
               (vlax-release-object LTYPESOBJ)
             )
           ) ;解冻(如冻结)，解锁,设图层为当前,设图层颜色，可打印特性.
           (vla-put-layeron layobj :vlax-true)
           (vla-put-lock layobj :vlax-false)
           (if (= (strcase (getvar "CLAYER")) (strcase lay-nam))  ;解冻.
             (vla-put-freeze layobj :vlax-false)
           )
           (vla-put-color layobj color)
           (vla-put-linetype layobj LTYPE)
           (vla-put-plottable 
             layobj
             (if plotk 
               :vlax-true
               :vlax-false
             )
           )
    )
  )
)
(xlr-autolayer)	;加载自动图层启动!
;;-------------------自动图层结束---------------------------------------------------------