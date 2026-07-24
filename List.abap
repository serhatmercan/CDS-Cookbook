" Get Fullname by User Name
" Username SH
" View: V_USR_NAME
" Field: NAME_TEXT
" Condition: BNAME

SELECT DISTINCT t1~bname,
                t1~name_text
  FROM v_usr_name AS t1
         INNER JOIN
           @et_entityset AS t2 ON t2~cre_user = t1~bname
  INTO TABLE @DATA(lt_usernames).
