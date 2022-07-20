;;-------------------�Զ�ͼ�㿪ʼ----------------------------------------------------------------
(defun xlr-autolayer () 
  (vl-load-com)
  ;; ͼ���ʼ���б� ���ݣ�commands layers color linetype plottable
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
                  (list "DONUT" "�ֽ�" 4 "Continuous" T)
                  (list "breakline" "�۶���" 4 "Continuous" T)
                  (list "POINT" "��" 4 "continuous" T)
                  (list "XLINE" "������" 8 "continuous" T)
                  (list "LINE" "0" NIL "continuous" T)
                  (list "XREF" "����" 7 "continuous" T)
                  (list "pline" "������" 2 "center" T)
                  (list "*vports" "PUB_WINDW" 4 "Continuous" T)
                  (list "revcloud" "�޶�" 2 "Continuous" T)
                  (list "table" "���" 7 "Continuous" T)
                  (list "imageattach" "����" 7 "continuous" T)
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
      ; ���Ӧ��������Ϣ��������õ�������ͬ.
      (progn  ;����ͼ��
             (apply 'xsetlays (cdr N))
             ;(setvar "CLAYER" (cadr N));��Ϊ��ǰ��.
      )
    )
  )
)
;;;----------------------------------------------------------------------------;;;
(defun xlr-start (calling-reactor xlr-startInfo /) 
  (foreach N *laylst 
    (if (= (strcase (car xlr-startInfo)) (strcase (car N))) 
      ; ���Ӧ��������Ϣ��������õ�������ͬ.
      (progn  ;����ͼ��

             (apply 'xsetlays (cdr N))
             ;(setvar "CLAYER" (cadr N));��Ϊ��ǰ��.
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
    (progn  ;���ͼ��.
           (vl-catch-all-error-p 
             (vl-catch-all-apply 'vla-add (list *lays LAY-NAM))
           )
           (setq LAYOBJ (vla-item *lays LAY-NAM))
           (if (not (tblobjname "ltype" LTYPE))  ;�������.
             (progn 
               (setq LTYPESOBJ (vla-get-linetypes *doc))
               (vla-load LTYPESOBJ LTYPE (findfile "acad.lin"))
               ;>>>��Ҫ��ǿ���ڶ��*.linѰ��
               (vlax-release-object LTYPESOBJ)
             )
           ) ;�ⶳ(�綳��)������,��ͼ��Ϊ��ǰ,��ͼ����ɫ���ɴ�ӡ����.
           (vla-put-layeron layobj :vlax-true)
           (vla-put-lock layobj :vlax-false)
           (if (= (strcase (getvar "CLAYER")) (strcase lay-nam))  ;�ⶳ.
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
(xlr-autolayer)	;�����Զ�ͼ������!
;;-------------------�Զ�ͼ�����---------------------------------------------------------