(IF (NULL (TBLSEARCH "LAYER" "轮廓线")) 
  (PROGN 
    (COMMAND "LAYER" "N" "轮廓线" "c" "5" "轮廓线" "L" "CONTINUOUS" "轮廓线" "LW" "0.300" 
             "轮廓线" ""
    )
    (COMMAND "LAYER" "N" "中线  " "c" "1" "中线  " "L" "CENTER" "中线  " "LW" "0.150" 
             "中线  " ""
    )
    (COMMAND "LAYER" "N" "虚线  " "c" "210" "虚线  " "L" "DASHED" "虚线  " "LW" "0.150" 
             "虚线  " ""
    )
    (COMMAND "LAYER" "N" "参考线" "c" "250" "参考线" "L" "CONTINUOUS" "参考线" "LW" "0.150" 
             "参考线" ""
    )
    (COMMAND "LAYER" "N" "文字  " "c" "4" "文字  " "L" "CONTINUOUS" "文字  " "LW" "0.150" 
             "文字  " ""
    )
    (COMMAND "LAYER" "N" "标注  " "c" "30" "标注  " "L" "CONTINUOUS" "标注  " "LW" "0.150" 
             "标注  " ""
    )
    (COMMAND "LAYER" "N" "注释  " "c" "3" "注释  " "L" "CONTINUOUS" "注释  " "LW" "0.150" 
             "注释  " ""
    )
    (COMMAND "LAYER" "N" "图框内" "c" "7" "图框内" "L" "CONTINUOUS" "图框内" "LW" "0.150" 
             "图框内" ""
    )
    (COMMAND "LAYER" "N" "图框外" "c" "7" "图框外" "L" "CONTINUOUS" "图框外" "LW" "0.150" 
             "图框外" ""
    )
  )
)
