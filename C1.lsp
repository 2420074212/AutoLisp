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
()