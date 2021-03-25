global class myMilestoneTimeCalculator2 implements Support.MilestoneTriggerTimeCalculator { 
    global Integer calculateMilestoneTriggerTime(String caseId, String milestoneTypeId) {
    	Case c = [SELECT Id,RecordTypeId,RecordType.Name,Type,/*2*/Nombre_Cliente__c,Segundo_nombre__c,Apellidos__c,Segundo_apellido__c,Tipo_Identificacion__c,Identificacion__c,Sexo__c,Fecha_Nacimiento__c,Correo_Electronico__c/*1*//*2*/,Enviar_aprobacion_AD__c,Aprobado__c/*2*//*3*/,Cuentas_seleccionada__c,Enviar_a_aprobacion__c/*3*/,Constancia__c FROM Case WHERE Id=:caseId];
        MilestoneType mt = [SELECT Name FROM MilestoneType WHERE Id=:milestoneTypeId];        
        //Obteniendo valores de los SLA's
        List<SLA_gestion__mdt> servicio = [Select Id,MasterLabel,DeveloperName,Tiempo__c From SLA_gestion__mdt Order By MasterLabel]; 
        Integer tiempo;       
        for(SLA_gestion__mdt sla: servicio) {
            //Actualización de información - Operaciones
            if(c.RecordType.Name == 'Actualización de Información' && (c.Nombre_Cliente__c != null || c.Segundo_nombre__c != null || c.Apellidos__c != null || c.Segundo_apellido__c != null || c.Tipo_Identificacion__c != null || c.Identificacion__c != null || c.Sexo__c != null || c.Fecha_Nacimiento__c != null || c.Correo_Electronico__c != null) && sla.MasterLabel == 'Actualización de información / CCO' && mt.Name != null && mt.Name.equals('Operaciones')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Actualización de información / Campos Críticos Operaciones
            } 
            	//Aprobación 2
            if(c.RecordType.Name == 'Actualización de Información' && (c.Nombre_Cliente__c != null || c.Segundo_nombre__c != null || c.Apellidos__c != null || c.Segundo_apellido__c != null || c.Tipo_Identificacion__c != null || c.Identificacion__c != null || c.Sexo__c != null || c.Fecha_Nacimiento__c != null || c.Correo_Electronico__c != null) && sla.MasterLabel == 'Actualización de información / CCO' && mt.Name != null && mt.Name.equals('Operaciones / Aprobación 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Actualización de información / Campos Críticos Operaciones
            }
            	//Aprobación 3
            if(c.RecordType.Name == 'Actualización de Información' && (c.Nombre_Cliente__c != null || c.Segundo_nombre__c != null || c.Apellidos__c != null || c.Segundo_apellido__c != null || c.Tipo_Identificacion__c != null || c.Identificacion__c != null || c.Sexo__c != null || c.Fecha_Nacimiento__c != null || c.Correo_Electronico__c != null) && sla.MasterLabel == 'Actualización de información / CCO' && mt.Name != null && mt.Name.equals('Operaciones / Aprobación 3')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Actualización de información / Campos Críticos Operaciones
            }
            //Cambio de subproducto - Subgerencia SAC
            else if(((c.RecordType.Name == 'Cambio de Subproducto' && c.Cuentas_seleccionada__c > 0 && c.Aprobado__c == false) || (c.RecordType.Name == 'Cambio de Subproducto' && c.Aprobado__c == false && c.Enviar_a_aprobacion__c == true)) && sla.MasterLabel == 'Cambio de subproducto / Subgerencia SAC' && mt.Name != null && mt.Name.equals('SubGerencia SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //16 horas - Cambio de subproducto / Reclamo
            }
            	//Aprobación 2
            else if(((c.RecordType.Name == 'Cambio de Subproducto' && c.Cuentas_seleccionada__c > 0 && c.Aprobado__c == false) || (c.RecordType.Name == 'Cambio de Subproducto' && c.Aprobado__c == false && c.Enviar_a_aprobacion__c == true)) && sla.MasterLabel == 'Cambio de subproducto / Subgerencia SAC' && mt.Name != null && mt.Name.equals('SubGerencia SAC 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //16 horas - Cambio de subproducto / Reclamo
            }
            	//Aprobación 3
            else if(((c.RecordType.Name == 'Cambio de Subproducto' && c.Cuentas_seleccionada__c > 0 && c.Aprobado__c == false) || (c.RecordType.Name == 'Cambio de Subproducto' && c.Aprobado__c == false && c.Enviar_a_aprobacion__c == true)) && sla.MasterLabel == 'Cambio de subproducto / Subgerencia SAC' && mt.Name != null && mt.Name.equals('SubGerencia SAC 3')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //16 horas - Cambio de subproducto / Reclamo
            }
            //Constancias - Subgerencia SAC
            else if(c.RecordType.Name == 'Constancia' && c.Constancia__c != 'P1' && sla.MasterLabel == 'Constancias / Subgerencia SAC' && mt.Name != null && mt.Name.equals('SubGerencia SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Constancias / Reclamo
            } 
            	//Aprobación 2
            else if(c.RecordType.Name == 'Constancia' && c.Constancia__c != 'P1' && sla.MasterLabel == 'Constancias / Subgerencia SAC' && mt.Name != null && mt.Name.equals('SubGerencia SAC 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Constancias / Reclamo
            }
            	//Aprobación 3
            else if(c.RecordType.Name == 'Constancia' && c.Constancia__c != 'P1' && sla.MasterLabel == 'Constancias / Subgerencia SAC' && mt.Name != null && mt.Name.equals('SubGerencia SAC 3')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //8 horas - Constancias / Reclamo
            }
            
            //Constancias - Subgerencia-Pignoración SAC
            else if(c.RecordType.Name == 'Constancia' && c.Constancia__c == 'P1' && sla.MasterLabel == 'Constancias / Subgerencia Pignoración' && mt.Name != null && mt.Name.equals('SubGerencia SAC')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //188 horas - Constancias / Reclamo
            } 
            	//Aprobación 2 Subgerencia-Pignoración SAC
            else if(c.RecordType.Name == 'Constancia' && c.Constancia__c == 'P1' && sla.MasterLabel == 'Constancias / Subgerencia Pignoración' && mt.Name != null && mt.Name.equals('SubGerencia SAC 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //188 horas - Constancias / Reclamo
            }
            	//Aprobación 3 Subgerencia-Pignoración SAC
            else if(c.RecordType.Name == 'Constancia' && c.Constancia__c == 'P1' && sla.MasterLabel == 'Constancias / Subgerencia Pignoración' && mt.Name != null && mt.Name.equals('SubGerencia SAC 3')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //188 horas - Constancias / Reclamo
            }
            
            //Modificación de aportes - Operaciones
            else if(c.RecordType.Name == 'Modificación de aportes' && c.Enviar_aprobacion_AD__c == true && c.Aprobado__c == false && sla.MasterLabel == 'Modificación de aportes / Operaciones' && mt.Name != null && mt.Name.equals('Operaciones')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //24 horas - Modificación de aportes / Reclamo
            }      
            	//Aprobación 2
            else if(c.RecordType.Name == 'Modificación de aportes' && c.Enviar_aprobacion_AD__c == true && c.Aprobado__c == false && sla.MasterLabel == 'Modificación de aportes / Operaciones' && mt.Name != null && mt.Name.equals('Operaciones / Aprobación 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //24 horas - Modificación de aportes / Reclamo
            }
            	//Aprobación 3
            else if(c.RecordType.Name == 'Modificación de aportes' && c.Enviar_aprobacion_AD__c == true && c.Aprobado__c == false && sla.MasterLabel == 'Modificación de aportes / Operaciones' && mt.Name != null && mt.Name.equals('Operaciones / Aprobación 3')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //24 horas - Modificación de aportes / Reclamo
            }
            //Retiros - Operaciones
            else if (c.RecordType.Name == 'Retiros' && sla.MasterLabel == 'Retiros / Operaciones' && mt.Name != null && mt.Name.equals('Operaciones')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //56 horas - Retiros / Operaciones
                //tiempo = 8*60;
            }
            	//Aprobación 2
            else if (c.RecordType.Name == 'Retiros' && sla.MasterLabel == 'Retiros / Operaciones' && mt.Name != null && mt.Name.equals('Operaciones / Aprobación 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //56 horas - Retiros / Operaciones
                //tiempo = 8*60;
            }
            	//Aprobación 3
            else if (c.RecordType.Name == 'Retiros' && sla.MasterLabel == 'Retiros / Operaciones' && mt.Name != null && mt.Name.equals('Operaciones / Aprobación 3')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //56 horas - Retiros / Operaciones
                //tiempo = 8*60;
            }
            //Reversiones - Operaciones
            else if(c.RecordType.Name == 'Reversiones' && c.Aprobado__c == false && sla.MasterLabel == 'Reversiones / Operaciones' && mt.Name != null && mt.Name.equals('Operaciones')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //24 horas - Reversiones / Reclamo
            }
            	//Aprobación 2
            else if(c.RecordType.Name == 'Reversiones' && c.Aprobado__c == false && sla.MasterLabel == 'Reversiones / Operaciones' && mt.Name != null && mt.Name.equals('Operaciones / Aprobación 2')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //24 horas - Reversiones / Reclamo
            }
            	//Aprobación 3
            else if(c.RecordType.Name == 'Reversiones' && c.Aprobado__c == false && sla.MasterLabel == 'Reversiones / Operaciones' && mt.Name != null && mt.Name.equals('Operaciones / Aprobación 3')) { tiempo = Integer.valueOf(sla.Tiempo__C)*60; //24 horas - Reversiones / Reclamo
            }
        }
        return tiempo; 
    }
}