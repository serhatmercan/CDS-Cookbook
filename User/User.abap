@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'SAP Users'
define view ZUSERS 
    as select from usr02
    left outer join usr21 on usr21.bname     = usr02.bname
    left outer join adrp  on adrp.persnumber = usr21.persnumber 
                         and adrp.date_from  = '00010101'         
                         and adrp.nation     = ' '
    left outer join adr6  on adr6.addrnumber = usr21.addrnumber 
                         and adr6.persnumber = usr21.persnumber
    left outer join adcp  on adcp.addrnumber = usr21.addrnumber 
                         and adcp.persnumber = usr21.persnumber  
                         and adcp.date_from  = '00010101' 
                         and adcp.nation     = ' '
    left outer join usr06 on usr06.bname     = usr02.bname 
{ 
    usr02.bname,    
    usr06.lic_type,
    usr02.ustyp,
    usr02.uflag,
    usr02.gltgb,
    adrp.name_text,
    usr02.class,  
    adcp.department,
    adcp.function, 
    cast( adr6.smtp_addr as abap.char(60)) as smtp_addr,
    adrp.name_first,    
    adrp.name_last,
    adrp.mc_namefir,
    adrp.mc_namelas,
    usr21.persnumber,   
    usr21.addrnumber
}