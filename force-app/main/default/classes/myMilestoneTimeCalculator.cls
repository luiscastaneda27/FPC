global class myMilestoneTimeCalculator implements Support.MilestoneTriggerTimeCalculator { 
    global Integer calculateMilestoneTriggerTime(String caseId, String milestoneTypeId) {
    	Case c = [SELECT Id, AprobacionBeneficiarios__c, RecordTypeId,RecordType.Name,Type,Lugar_Nacimiento__c,Nacionalidad__c,Estado_Civil__c,Correo_Electronico__c,Telefono_Casa__c,Telefono_Movil__c,Telefono_Trabajo__c/*1*/,/*2*/Nombre_Cliente__c,Segundo_nombre__c,Apellidos__c,Segundo_apellido__c,Tipo_Identificacion__c,Identificacion__c,Sexo__c,Fecha_Nacimiento__c/*2*//*Otros*/,FPC_Asunto__c/*Otros*/,Status,Constancia__c,Es_primer_prestamo__c FROM Case WHERE Id=:caseId];
        MilestoneType mt = [SELECT Name FROM MilestoneType WHERE Id=:milestoneTypeId];        
        //Obteniendo valores de los SLA's
        System.debug(milestoneTypeId +' ----- '+caseId);
        List<SLA_gestion__mdt> servicio = [Select Id,MasterLabel,DeveloperName,Tiempo__c From SLA_gestion__mdt Order By MasterLabel]; 
        Integer tiempo;       
        for(SLA_gestion__mdt sla: servicio) {
            //Actualización de información - SAC
            if(c.RecordType.Name == 'Actualización de Información' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && (c.Nombre_Cliente__c == null && c.Segundo_nombre__c == null && c.Apellidos__c == null && c.Segundo_apellido__c == null && c.Tipo_Identificacion__c == null && c.Identificacion__c == null && c.Sexo__c == null && c.Fecha_Nacimiento__c == null && !c.AprobacionBeneficiarios__c) && sla.MasterLabel == 'Actualización de información / CNC - SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Actualización de información / Campos no Críticos SAC*/ break;
            } else if(c.RecordType.Name == 'Actualización de Información' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && (c.Nombre_Cliente__c != null || c.Segundo_nombre__c != null || c.Apellidos__c != null || c.Segundo_apellido__c != null || c.Tipo_Identificacion__c != null || c.Identificacion__c != null || c.Sexo__c != null || c.Fecha_Nacimiento__c != null || c.AprobacionBeneficiarios__c) && sla.MasterLabel == 'Actualización de información / CC - SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Actualización de información / Campos Críticos SAC*/ break;
            } else if(c.RecordType.Name == 'Actualización de Información' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Actualización de información / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Actualización de información / Reclamo */ break;
            }
            	//Devolución 1
            if(c.RecordType.Name == 'Actualización de Información' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && (c.Nombre_Cliente__c == null && c.Segundo_nombre__c == null && c.Apellidos__c == null && c.Segundo_apellido__c == null && c.Tipo_Identificacion__c == null && c.Identificacion__c == null && c.Sexo__c == null && c.Fecha_Nacimiento__c == null && !c.AprobacionBeneficiarios__c) && sla.MasterLabel == 'Actualización de información / CNC - SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Actualización de información / Campos no Críticos SAC */ break;
            } else if(c.RecordType.Name == 'Actualización de Información' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && (c.Nombre_Cliente__c != null || c.Segundo_nombre__c != null || c.Apellidos__c != null || c.Segundo_apellido__c != null || c.Tipo_Identificacion__c != null || c.Identificacion__c != null || c.Sexo__c != null || c.Fecha_Nacimiento__c != null || c.AprobacionBeneficiarios__c) && sla.MasterLabel == 'Actualización de información / CC - SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Actualización de información / Campos Críticos SAC*/ break;
            } else if(c.RecordType.Name == 'Actualización de Información' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Actualización de información / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Actualización de información / Reclamo*/ break;
            }
            	//Devolución 2
            if(c.RecordType.Name == 'Actualización de Información' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && (c.Nombre_Cliente__c == null && c.Segundo_nombre__c == null && c.Apellidos__c == null && c.Segundo_apellido__c == null && c.Tipo_Identificacion__c == null && c.Identificacion__c == null && c.Sexo__c == null && c.Fecha_Nacimiento__c == null && !c.AprobacionBeneficiarios__c) && sla.MasterLabel == 'Actualización de información / CNC - SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Actualización de información / Campos no Críticos SAC*/ break;
            } else if(c.RecordType.Name == 'Actualización de Información' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && (c.Nombre_Cliente__c != null || c.Segundo_nombre__c != null || c.Apellidos__c != null || c.Segundo_apellido__c != null || c.Tipo_Identificacion__c != null || c.Identificacion__c != null || c.Sexo__c != null || c.Fecha_Nacimiento__c != null || c.AprobacionBeneficiarios__c) && sla.MasterLabel == 'Actualización de información / CC - SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Actualización de información / Campos Críticos SAC*/ break;
            } else if(c.RecordType.Name == 'Actualización de Información' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Actualización de información / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Actualización de información / Reclamo*/ break;
            }
            //Cambio de subproducto - SAC
            else if(c.RecordType.Name == 'Cambio de Subproducto' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Cambio de subproducto / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Cambio de subproducto / Reclamo*/ break;
            } else if(c.RecordType.Name == 'Cambio de Subproducto' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Cambio de subproducto / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Cambio de subproducto / SAC*/ break;
            }
            	//Devolución 1
            else if(c.RecordType.Name == 'Cambio de Subproducto' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Cambio de subproducto / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Cambio de subproducto / Reclamo*/ break;
            } else if(c.RecordType.Name == 'Cambio de Subproducto' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Cambio de subproducto / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Cambio de subproducto / SAC*/ break;
            }
            	//Devolución 2
            else if(c.RecordType.Name == 'Cambio de Subproducto' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Cambio de subproducto / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Cambio de subproducto / Reclamo*/ break;
            } else if(c.RecordType.Name == 'Cambio de Subproducto' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Cambio de subproducto / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Cambio de subproducto / SAC*/ break;
            }
            //Constancias - SAC
            /*else if(c.RecordType.Name == 'Constancia' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Constancias / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC')) {
            	tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Constancias / Reclamo
                break;
            }*/ 
            else if(c.RecordType.Name == 'Constancia' && /*c.Constancia__c != 'P1' &&*/ /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Constancias / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Constancias / SAC*/ break;
            } else if(c.RecordType.Name == 'Constancia' && c.Es_primer_prestamo__c == true && c.Status == 'Esperando Documentación' && sla.MasterLabel == 'Constancias / SAC Pignoración' && mt.Name != null && mt.Name.equals('Oficiales SAC Pignoracón')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*188 horas - Constancias / SAC*/ break;
            }
            	//Devolución 1
            /*else if(c.RecordType.Name == 'Constancia' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Constancias / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) {
            	tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Constancias / Reclamo
                break;
            }*/ else if(c.RecordType.Name == 'Constancia' && /*c.Constancia__c != 'P1' &&*/ /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Constancias / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Constancias / SAC*/ break;
            }
            	//Devolución 2
            /*else if(c.RecordType.Name == 'Constancia' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Constancias / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) {
            	tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Constancias / Reclamo
                break;
            }*/ else if(c.RecordType.Name == 'Constancia' && /*c.Constancia__c != 'P1' &&*/ /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Constancias / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Constancias / SAC*/ break;
            }
            //Estados de cuenta - SAC 
            else if(c.RecordType.Name == 'Estados de Cuenta' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Estados de cuenta / General' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Estados de cuenta / General*/ break;
            } 
            else if(c.RecordType.Name == 'Estados de Cuenta' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Estados de cuenta / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Estados de cuenta / Reclamo*/ break;
            } 
            	//Devolución 1
            /*else if(c.RecordType.Name == 'Estados de Cuenta' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Estados de cuenta / General' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { 
				tiempo = Integer.valueOf(sla.Tiempo__C)*60; //4 horas - Estados de cuenta / General 
            	break;
            }*/
            /*else if(c.RecordType.Name == 'Estados de Cuenta' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Estados de cuenta / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { 
                tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Estados de cuenta / Reclamo
                break;
            }*/
            	//Devolución 2
            else if(c.RecordType.Name == 'Estados de Cuenta' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Estados de cuenta / General' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Estados de cuenta / General*/ break;
            } 
            else if(c.RecordType.Name == 'Estados de Cuenta' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Estados de cuenta / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Estados de cuenta / Reclamo*/ break;
            }
            //Modificación de aportes - SAC
            /*else if(c.RecordType.Name == 'Modificación de aportes' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Modificación de aportes / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC')) {
            	tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Modificación de aportes / Reclamo
                break;
            }*/ else if(c.RecordType.Name == 'Modificación de aportes' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Modificación de aportes / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Modificación de aportes / SAC*/ break;
            }
            	//Devolución 1
            /*else if(c.RecordType.Name == 'Modificación de aportes' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Modificación de aportes / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) {
            	tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Modificación de aportes / Reclamo
                break;
            }*/ else if(c.RecordType.Name == 'Modificación de aportes' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Modificación de aportes / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Modificación de aportes / SAC*/ break;
            }
            	//Devolución 2
            /*else if(c.RecordType.Name == 'Modificación de aportes' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Modificación de aportes / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) {
            	tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Modificación de aportes / Reclamo
                break;
            }*/ else if(c.RecordType.Name == 'Modificación de aportes' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Modificación de aportes / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Modificación de aportes / SAC*/ break;
            }
            //Otros - SAC
            /*else if(c.RecordType.Name == 'Otros' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Otros / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC')) {
            	tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Otros / Reclamo
                break;
            }*/ else if(c.RecordType.Name == 'Otros' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ c.FPC_Asunto__c == 'Consulta Seguro Vida' && sla.MasterLabel == 'Otros / Consulta Seguros' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*4 horas - Otros / Consulta Seguros*/ break;
            } else if(c.RecordType.Name == 'Otros' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ (c.FPC_Asunto__c == 'No se Realizó Aporte' || c.FPC_Asunto__c == 'Estado Cuenta' || c.FPC_Asunto__c == 'Modificación Aportes') && sla.MasterLabel == 'Otros / No se Realizó Aportes' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*16 horas - Otros / No se Realizó Aportes*/ break;
            } else if(c.RecordType.Name == 'Otros' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ (c.FPC_Asunto__c == 'Reposición Carnet' || c.FPC_Asunto__c == 'Problemas Sitio Transaccional' || c.FPC_Asunto__c == 'Problemas en la Aplicación Móvil' || c.FPC_Asunto__c == 'Problemas Interbanca' || c.FPC_Asunto__c == 'Problemas Caja Banco' || c.FPC_Asunto__c == 'Varios Débitos' || c.FPC_Asunto__c == 'Consulta de correo electrónico' || c.FPC_Asunto__c == 'Constancia' || c.FPC_Asunto__c == 'Actualización Información') && sla.MasterLabel == 'Otros / Reposición y Problemas CD' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*24 horas - Otros / Reposición y Problemas Canales Digitales*/ break;
            } else if(c.RecordType.Name == 'Otros' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ c.FPC_Asunto__c == 'Retiro Manual' && sla.MasterLabel == 'Otros / Retiro Manual' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*80 horas - Otros / Retiro Manual*/ break;
            } else if(c.RecordType.Name == 'Otros' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ (c.FPC_Asunto__c == 'Consulta Proceso Retiro' || c.FPC_Asunto__c == 'Consulta Préstamos' || c.FPC_Asunto__c == 'Consulta Cuenta') && sla.MasterLabel == 'Otros / Consultas' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Otros / Consultas*/ break;
            }
            //Reposición de carnet - SAC
            else if(c.RecordType.Name == 'Reposición de Carnet' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Reposición de carnet / General' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*24 horas - Reposición de carnet / General*/ break;
            }
            /*else if(c.RecordType.Name == 'Reposición de Carnet' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reposición de carnet / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC')) {
            	tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Reposición de carnet / Reclamo
                break;
            }*/
            	//Devolución 1
            else if(c.RecordType.Name == 'Reposición de Carnet' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reposición de carnet / General' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*24 horas - Reposición de carnet / General*/ break;
            }
            else if(c.RecordType.Name == 'Reposición de Carnet' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reposición de carnet / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Reposición de carnet / Reclamo*/ break;
            }
            	//Devolución 2
            else if(c.RecordType.Name == 'Reposición de Carnet' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reposición de carnet / General' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*24 horas - Reposición de carnet / General*/ break;
            }
            else if(c.RecordType.Name == 'Reposición de Carnet' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reposición de carnet / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Reposición de carnet / Reclamo*/ break;
            }
            //Retiros - SAC
            /*else if (c.RecordType.Name == 'Retiros' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Retiros / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC')) {
                tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Retiros / Reclamo
                break;
            }*/ else if (c.RecordType.Name == 'Retiros' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Retiros / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*24 horas - Retiros / SAC*/ break;
            }
            	//Devolución 1
            /*else if (c.RecordType.Name == 'Retiros' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Retiros / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) {
                tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Retiros / Reclamo
                break;
            }*/ else if (c.RecordType.Name == 'Retiros' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Retiros / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*24 horas - Retiros / SAC*/ break;
            }
            	//Devolución 2
            /*else if (c.RecordType.Name == 'Retiros' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Retiros / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) {
                tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Retiros / Reclamo
                break;
            }*/ else if (c.RecordType.Name == 'Retiros' && /*(c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') &&*/ sla.MasterLabel == 'Retiros / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*24 horas - Retiros / SAC*/ break;
            }
            //Reversiones - SAC
            else if(c.RecordType.Name == 'Reversiones' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reversiones / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Reversiones / Reclamo*/ break;
            } else if(c.RecordType.Name == 'Reversiones' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reversiones / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Reversiones / SAC*/ break;
            }
            	//Devolución 1
            else if(c.RecordType.Name == 'Reversiones' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reversiones / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Reversiones / Reclamo*/ break;
            } else if(c.RecordType.Name == 'Reversiones' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reversiones / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 1')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Reversiones / SAC*/ break;
            }
            	//Devolución 2
            else if(c.RecordType.Name == 'Reversiones' && (c.Type == 'Gestión' || c.Type == 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reversiones / Reclamo' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Reversiones / Reclamo*/ break;
            } else if(c.RecordType.Name == 'Reversiones' && (c.Type != 'Gestión' || c.Type != 'Gestión Usuario Financiero') && sla.MasterLabel == 'Reversiones / SAC' && mt.Name != null && mt.Name.equals('Oficiales SAC / Devolución 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; /*8 horas - Reversiones / SAC*/ break;
            }
        }
        System.debug('Tiempo SLA: '+tiempo);
        return tiempo;
    }
}