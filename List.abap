" ============================================================================
" Type        : Freeform ABAP SQL snippet
" Module      : BC (cross-application, user master)
" Business Object : User
" ----------------------------------------------------------------------------
" Description
"   Get Fullname by User Name. Resolves BNAME to the display name (NAME_TEXT)
"   via V_USR_NAME, joined against a RAP entity set alias (@et_entityset) on
"   its CRE_USER field.
"
" Common Use Cases
"   - Enriching a RAP entity result set with the created-by user's full name
" ============================================================================

SELECT DISTINCT t1~bname,
                t1~name_text
  FROM v_usr_name AS t1
         INNER JOIN
           @et_entityset AS t2 ON t2~cre_user = t1~bname
  INTO TABLE @DATA(lt_usernames).
