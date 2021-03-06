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
;
;实数
;
(rtos number [mode [precision]]);将实数按指定格式转换成字符串来看 real to string，类似的命令还有angtos(angle to string)
(setq number 123456789.123456789)
(rtos number 2 30)
(equal expr1 expr2 [fuzz]);比较时按fuzz作为容差进行比较
(equal 3.14159216 3.14159215 1.0e-7);返回相等
;
;字符串操作
;
(strcase string [which]);字符串大小写，which->T  则转换为小写
(strcat str1 str2 ...);字符串连接
(strlen str);字符串长度
(ascii "A");字符ASCII码的值
(vl-string-elt string position);返回字符出中指定位置字符的ASCII码
(chr 65);ASCII码值对应的字符
(vl-string->list "A65");将字符串的ASCII码值作为列表返回
(vl-list->string '(65 54 53));将ASCII码值列表转换为字符串放回
(strlen "string");字符串长度
(substr "string" START [length]);获取子字符串
(wcmatch string pattern);搜索子字符串
(vl-string-search pattern string [start-pos]);返回查找的子字符串在字符串中的位置


;
;坐标
;
(angle PT1 PT2);返回从PT1到PT2连线的角度（与正东方的夹角)
(polar pt ang dist);根据基准点、方位和距离返回下一点的坐标
(inters pt1 pt2 pt3 pt4 [onseg]);返回两条线的交点，可选参数onseg设置为“nil”，则返回会交点或延长线交点
(osnap pt mode);根据指定点和对象锁点模式返回对象锁点坐标

;
;序列
;
(foreach name list [expr]);name->参数名称、list->数据序列、expr->运算语句
(foreach m (list 152 38.5 49.268)  ;返回序列中每个元素的平方
  (setq m2 (* m m))
  (princ m2)
  (princ "\n")
)
(mapcar 'function list);将序列中的每个元素带入指定的函数内运算，并将各个结果组成一个序列返回
(mapcar 'sqrt '(152 38.5 49.268));返回序列中每个元素的平方根

(lambda arguments expr);定义匿名函数，arguments是参数，expr是执行语句
(mapcar '(lambda (x) (* x x)) '(152 38.5 49.268));配合mapcar函数使用
;
;矩阵
;
(type);序列返回list
(listp);序列、空、nil返回T
(vl-consp);序列返回T
(length 'list)
(vl-list-length 'list-or-cons-object);返回序列第一层元素的数目
(member expr 'list);返回序列中以指定元素开头的子序列，判断项目是否为序列的元素
(vl-position symbol 'list);返回项目在序列中第一次出现的位置
(last 'list);返回序列中最后一个元素
(reverse 'list);反转序列元素顺序
(cons new-first-element list-or-atom);在旧序列开头位置添加新元素
(append [ 'list1 'list2 ...]);将多个序列的内容组成一个大序列
(subst newitem olditem lst);以新项目替换序列内的旧项目，如果存在多个相同项目则均被替换
(vl-remove element 'list);将指定项目从序列中删除
;
;字符串序列
;
(acad_strlsort 'list);根据字母顺序来排列字符串序列内的元素
(acad_strlsort (list "dog" "Apple" "Red" "cat" "blue"));不区分大小写
;
;点对序列
;
(setq dp1 (cons 42 35.8));点对可以是数值或字符串
(setq dp2 (cons "Height" dp1));任然包含点对序列，无法使用(length\vl-list-length)查询序列长度，点号后的值只能通过cdr获取
(setq dp2 (cons "Height" 168.5))
(setq dp2 (cons "Height" '(168.5)));不会生成点对序列
;
;关联数据序列
;
(assoc element alist);element是元素序列的第一个元素内容，alist是一个关联数据序列(点对序列)
(setq dt (list 
           (cons "Name" "Helen")
           (cons "Phone" "545-3388")
           (cons "Height" 172.5)
           (cons "Weight" 58)
         )
)
(setq pa (assoc "Phone" dt))
(setq pa1 (cdr pa))
DRAWING_SCALE;;;YQ_DWGSCALE     源泉绘图比例
INSUNITS;;;插入时的缩放单位       源泉绘图单位

;
;标注
;
(defun C:BB () 
  (setq r1 5
        h1 3.5
  )
  (graphscr)
  ;(setq OCE (getvar "cmdecho"))
  ;(setvar "cmdecho" 0)
  (setq p1 (getpoint "\nFrom point:")
        p2 (getpoint "\nBubber center point:")
        a1 (angle p2 p1)
        p3 (polar p2 a1 r1)
        t1 (getstring "\nPart number:")
  )
  (command ".LINE" p1 p3 "")
  (command ".CIRCLE" p2 r1)
  (command ".TEXT" "M" p2 h1 0 t1)

  ;(setvar "cmdecho" oce)
  (princ)
)
(defun C:XIEBIAO (/ OCE) 
  (graphscr)
  (setq OLD_CMDECHO (getvar "cmdecho"))
  (setq OLD_OSMODE (getvar "OSMODE"))
  (setvar "cmdecho" 0)
  (setvar "OSMODE" 0)
  (setq CCENTER (getpoint "\n输入圆心位置："))
  (setq LSTART (getpoint "\n输入直线起点位置："))
  (setq CRADIUS (getreal "\n输入圆半径："))
  (setq DTEXT (getstring "\n输入标注文字："))
  (setq LEND (polar CCENTER (angle CCENTER LSTART) CRADIUS))
  (command ".CIRCLE" CCENTER CRADIUS)
  (command ".LINE" LSTART LEND "")
  (command ".TEXT" "M" CCENTER 3.5 0 DTEXT)

  (setvar "OSMODE" OLD_OSMODE)
  (setvar "cmdecho" OLD_CMDECHO)
  (princ)
)

;
;更新对象数据序列
;
(entlast);获取最后一个未删除的主图元名
(entsel);选取图元，获取图元名及图元坐标
(nentsel);选取图元
(ssname (ssget) 0);选择图元（selection set 选择集）

(entget);获取图元序列
(subst);置换序列变量内的数据项
(entmod);更新图元（entity modify）
(entupd);如果图元序列中还含有子序列 则用该函数进一步更新

;
;选择集（selection set）
;
(ssget [sel-method] [pt1] [pt2] [pt-list] [filter-list])
;选取通过指定点的对象
(setq p2 (getpoint "\nPick a point:"));选取一个点
(setq s2 (ssget p2));将该点作为选择集
(sslength s2);获取选择集对象数目

(setq p3 (list 450 250));直接指定选取点
(setq s3 (ssget p3));返回nil表示无图形通过该点，选择集未产生
(setq s4 (ssget (list 411 395)));等效上面语句

;指定选取区域
(setq p5 (getpoint "\nPick a point:"))
(setq p6 (getcorner p5 "\nPick opposite corner:"))
(setq s5 (ssget "w" p5 p6))
(setq s6 (ssget "cp" (list p2 p3 p4 p5 p6)))

;使用上一次编辑使用的选择集
(setq s7 (ssget "p"))

;选取最后建立的可见对象
(setq s8 (ssget "l"))

;选取图文件内的所有对象
(setq s9 (ssget "x"))

;过滤对象
(setq s10 (ssget "X" '((0 . "LINE") (8 . "0"))))
(setq s11 (ssget '(0 . "TEXT")))

(setq s12 (ssget "c" p5 p6 '((0 . "TEXT"))));指定选取区域及选取方式

;关系过滤，选择集
(setq s13 (ssget "X" '((0 . "CIRCLE") (-4 . ">") (40 . 10.0))));关系运算符的群码-4、半径的群码40
(setq s14 (ssget "X" 
                 '((0 . "CIRCLE")
                   (-4 . ">")
                   (40 . 10.0)
                   (-4 . "<")
                   (40 . 20.0)
                  )
          )
);每个关系运算符只影响它后方一个元素

;坐标关系
(setq s15 (ssget "X" 
                 '((0 . "LINE")
                   (-4 . ">,>,*")
                   (10 500.0 300.0 0.0)
                  )
          )
);找出所有起点X坐标大于500、Y坐标大于300、Z坐标不考虑的直线段
(setq s16 (ssget "X" 
                 '((0 . "LINE")
                   (-4 . ">,>")
                   (10 500.0 300.0 0.0)
                  )
          )
);与上例功能相同
;群码210（法向量）只能使用“*”、“=”、“!=”、“/=”、“<>”运算符进行比较

;逻辑过滤
(setq s17 (ssget "X" 
                 '((-4 . "<OR")
                   (-4 . "<AND")
                   (0 . "CIRCLE")
                   (40 . 10.0)
                   (-4 . "AND>")
                   (-4 . "<AND")
                   (0 . "ARC")
                   (-4 . "<")
                   (40 . 20.0)
                   (-4 . "AND>")
                   (-4 . "OR>")
                  )
          )
);找出图文件内所有半径为10的圆，以及所有半径小于20的弧

;取出选择集数据
(ssname ss index);ss选择集，index整数索引值