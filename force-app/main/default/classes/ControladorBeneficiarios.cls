public class ControladorBeneficiarios {
    
    @AuraEnabled
    public static ResultWrapper getBeneficiarios(String recordId, Boolean esCaso){
        System.debug(recordId+' -- '+esCaso);
        ResultWrapper resultado = new ResultWrapper();
        resultado.listBeneficiarios = new List<Beneficiario>();
        resultado.listBeneficiariosCont = new List<Beneficiario>();
        resultado.listBeneficiariosDirec = new List<Beneficiario>();
        resultado.listCuentas = new List<PicklistOption>();
        resultado.listCuentasSO = new List<SelectOption>();
        
        if(esCaso){
            resultado.listTipoBeneficiarios = getPicklistOptions('Beneficiario__C', 'TipoBeneficiario__c');
            resultado.listSexo = getPicklistOptions('Beneficiario__C', 'Sexo__c');
            resultado.listIdentificacion = getPicklistOptions('Beneficiario__C', 'Tipo_de_Identificaci_n__c');
            resultado.listParentesco = getPicklistOptions('Beneficiario__C', 'Parentesco__c');
        }else{
            resultado.listTipoBeneficiariosSO = getPicklistOptionsSO('Beneficiario__C', 'TipoBeneficiario__c');
            resultado.listSexoSO = getPicklistOptionsSO('Beneficiario__C', 'Sexo__c');
            resultado.listIdentificacionSO = getPicklistOptionsSO('Beneficiario__C', 'Tipo_de_Identificaci_n__c');
            resultado.listParentescoSO = getPicklistOptionsSO('Beneficiario__C', 'Parentesco__c'); 
        }
        
        resultado.listPorcentajes = new List<Porcentaje>();
        resultado.fechaMaxima = Date.today().addDays(-1);
        resultado.fechaMinima = Date.today().addYears(-100);
        resultado.modificado = false;
        resultado.desactivado = false;
        resultado.mapBeneficiarios = new Map<String, BeneficiarioWrapper>();
        Case caso = esCaso ? [Select Cuentas_seleccionada__c,AccountId, Status from case Where Id =:recordId] : new Case(); 
        System.debug('Nuevo: '+ (esCaso ? caso.AccountId : recordId));
        resultado.estado = caso.Status;
        for(Cuentas__c item: [Select Id,Codigo__c from Cuentas__c Where Cliente__c =: esCaso ? caso.AccountId : recordId and Activo__c = true order by Codigo__c]){
           resultado.listCuentas.add(new PicklistOption(item.Id, item.Codigo__c));
            if(!esCaso){
                resultado.listCuentasSO.add(new SelectOption(item.Id, item.Codigo__c));
            }
            Porcentaje porcentaje = new Porcentaje();
            porcentaje.cuenta = item.Codigo__c;
            porcentaje.porcentajeDireto = 0;
            porcentaje.porcentajeContingencia = 0;
            resultado.listPorcentajes.add(porcentaje);
            
            BeneficiarioWrapper benefWrp = new BeneficiarioWrapper();
            benefWrp.listBeneficiariosDirec = new List<Beneficiario> ();
            benefWrp.listBeneficiariosCont = new List<Beneficiario> ();
            resultado.mapBeneficiarios.put(item.Id, benefWrp);
        }
        String cuentas = '';
        if(!esCaso || caso.Cuentas_seleccionada__c == 0){
            for(Beneficiario__C item: 
                [Select Id,Cuenta__c,Cuenta__r.Codigo__c, Tipo_de_Identificaci_n__c, Identidad__c ,
                 Primer_Nombre__c, Segundo_Nombre__c,Primer_Apellido__c, Segundo_Apellido__c, 
                 TipoBeneficiario__c,Porcentaje__c,Fecha_Nacimiento__c, Sexo__c,
                 Grado_Parentesco__c,Parentesco__c, Id_Externo__c 
                 from Beneficiario__c
                 where Cuenta__r.Cliente__c =: (esCaso ? caso.AccountId : recordId) And Cuenta__r.Activo__c = true
                 order by Cuenta__r.Codigo__c, TipoBeneficiario__c,Primer_Nombre__c]){
                     Beneficiario benef = new Beneficiario();
                     benef.primerNombre = item.Primer_Nombre__c;
                     benef.segundoNombre = item.Segundo_Nombre__c;
                     benef.primerApellido = item.Primer_Apellido__c;
                     benef.segundoApellido = item.Segundo_Apellido__c;
                     benef.tipoIdentificacion = item.Tipo_de_Identificaci_n__c;
                     benef.identificacion = item.Identidad__c;
                     benef.cuenta = item.Cuenta__r.Codigo__c;
                     benef.cuentaId = item.Cuenta__c;
                     benef.tipoBeneficiario = item.TipoBeneficiario__c == null ? 'Directo' : item.TipoBeneficiario__c;
                     benef.porcentaje = item.Porcentaje__c;
                     benef.fechaNacimiento = item.Fecha_Nacimiento__c;
                     benef.fechaNacimientoShow = item.Fecha_Nacimiento__c != null ? item.Fecha_Nacimiento__c.addDays(1) : null;
                     benef.sexo = item.Sexo__c;
                     benef.parentesco = item.Parentesco__c;
                     benef.grado = getgradoLabel(benef.parentesco);
                     benef.idExterno = item.Id_Externo__c;
                     benef.modificado = false;
                     benef.index = resultado.listBeneficiarios.size();
                     resultado.listBeneficiarios.add(benef);
                     
                     BeneficiarioWrapper benefWrp = resultado.mapBeneficiarios.get(benef.cuentaId);
                     if(benef.tipoBeneficiario == 'Contingencia'){
                         benefWrp.listBeneficiariosCont.add(benef);
                     }else{
                         benefWrp.listBeneficiariosDirec.add(benef);
                     }
                     resultado.mapBeneficiarios.put(benef.cuentaId, benefWrp);
                 }
        }else{
            if(Caso.Status != 'Nuevo' && Caso.Status != 'Devuelto'){
                resultado.listCuentas = new List<PicklistOption>();
            }
             for(Detalle_caso__c item: 
                [Select Id,Cuenta__c,Cuenta__r.Codigo__c, Tipo_Identificacion__c, Identificacion__c , 
                 Primer_Nombre__c, Segundo_Nombre__c,Primer_Apellido__c, Segundo_Apellido__c, 
                 TipoBeneficiario__c,Porcentaje__c,Fecha_Nacimiento__c, Sexo__c,
                 Grado_Parentesco__c,Parentesco__c, Id_Externo__c,
                 ModificadoActInfo__c
                 from Detalle_caso__c
                 where Caso__c =: recordId And Cuenta__r.Activo__c = true
                 order by Cuenta__r.Codigo__c, TipoBeneficiario__c,Primer_Nombre__c]){
                     Beneficiario benef = new Beneficiario();
                     benef.id = Item.Id;
                     benef.primerNombre = item.Primer_Nombre__c;
                     benef.segundoNombre = item.Segundo_Nombre__c;
                     benef.primerApellido = item.Primer_Apellido__c;
                     benef.segundoApellido = item.Segundo_Apellido__c;
                     benef.tipoIdentificacion = item.Tipo_Identificacion__c;
                     benef.tipoIdentificacionLabel = getPicklistLabel(resultado.listIdentificacion, benef.tipoIdentificacion);
                     benef.identificacion = item.Identificacion__c;
                     benef.cuenta = item.Cuenta__r.Codigo__c;
                     benef.cuentaId = item.Cuenta__c;
                     benef.tipoBeneficiario = item.TipoBeneficiario__c == null ? 'Directo' : item.TipoBeneficiario__c;
                     benef.porcentaje = item.Porcentaje__c;
                     benef.fechaNacimiento = item.Fecha_Nacimiento__c;
                     benef.fechaNacimientoShow = item.Fecha_Nacimiento__c != null ? item.Fecha_Nacimiento__c.addDays(1) : null;
                     benef.sexo = item.Sexo__c;
                     benef.parentesco = getParentescoValue(item.Parentesco__c);
                     benef.parentescoLabel = getPicklistLabel(resultado.listParentesco, benef.parentesco);
                     benef.grado = getgradoLabel(benef.parentesco);
                     benef.idExterno = item.Id_Externo__c;
                     benef.index = resultado.listBeneficiarios.size();
                     benef.modificado = item.ModificadoActInfo__c;
                     resultado.listBeneficiarios.add(benef);
                     
                     BeneficiarioWrapper benefWrp = resultado.mapBeneficiarios.get(benef.cuentaId);
                     if(benef.modificado){
                         if(!cuentas.contains(item.Cuenta__c) && Caso.Status != 'Nuevo' && Caso.Status != 'Devuelto'){
                             cuentas += item.Cuenta__c;
                             resultado.listCuentas.add(new PicklistOption(item.Cuenta__c, item.Cuenta__r.Codigo__c));
                         }
                         if(String.isBlank(resultado.cuentaSelecionada)){
                             resultado.cuentaSelecionada = item.Cuenta__c;
                             resultado.cuentaSelecionadaLabel = item.Cuenta__r.Codigo__c;
                         }
                     }
                     if(benef.tipoBeneficiario == 'Contingencia'){
                         benefWrp.listBeneficiariosCont.add(benef);
                     }else{
                         benefWrp.listBeneficiariosDirec.add(benef);
                     }
                     resultado.mapBeneficiarios.put(benef.cuentaId, benefWrp);
                 }
        }
        //System.debug('Respuesta: '+Json.serialize(resultado));
        resultado.titulo = 'Beneficiarios ('+resultado.listBeneficiarios.size()+')';
        return resultado;
    }
    
    
    public class BeneficiarioWrapper{
        @AuraEnabled public List<Beneficiario> listBeneficiariosDirec{get;set;}
        @AuraEnabled public List<Beneficiario> listBeneficiariosCont{get;set;}
        @AuraEnabled public String titulo {get;set;}
        @AuraEnabled public String tituloCont {get;set;}
    }
    
    @AuraEnabled
    public static ResultWrapper insertarBeneficiarios(String recordId, String dataBeneficiarios){
        System.debug('dataBeneficiarios: '+dataBeneficiarios);
        ResultWrapper data =(ResultWrapper)Json.deserialize(dataBeneficiarios, ResultWrapper.class);
        List<Detalle_caso__c> listDetalleCaso = new List<Detalle_caso__c>();
        Map<Id, Detalle_caso__c> mapDetalle = new map<Id, Detalle_caso__c>([Select id, Name From Detalle_caso__c
                                                                       Where Caso__c = :recordId]);
        for(PicklistOption pk: data.listCuentas){
            data.listBeneficiarios = new List<Beneficiario>();
            if(data.cuentaSelecionada != pk.value || data.listBeneficiariosDirec == null){
                BeneficiarioWrapper benfWr = data.mapBeneficiarios.get(pk.value);
                data.listBeneficiarios.addAll(benfWr.listBeneficiariosDirec);
                data.listBeneficiarios.addAll(benfWr.listBeneficiariosCont);
                System.debug(pk.label +' ----- '+benfWr.listBeneficiariosDirec.size() + ' ---- '+benfWr.listBeneficiariosCont.size());
            }else{
                data.listBeneficiarios.addAll(data.listBeneficiariosDirec);
                data.listBeneficiarios.addAll(data.listBeneficiariosCont);
            }
            //data.listBeneficiarios = validacionCamposBeneficiario(data.listBeneficiarios);
            for(Beneficiario benef : data.listBeneficiarios){
                Detalle_caso__c detalleCaso = new Detalle_caso__c();
                detalleCaso.Id = benef.id;
                detalleCaso.Primer_Nombre__c = benef.primerNombre;
                detalleCaso.Segundo_Nombre__c = benef.segundoNombre;
                detalleCaso.Primer_Apellido__c = benef.primerApellido;
                detalleCaso.Segundo_Apellido__c = benef.segundoApellido;
                
                detalleCaso.Tipo_Identificacion__c = benef.tipoIdentificacion;
                detalleCaso.Identificacion__c = benef.identificacion;
                detalleCaso.cuenta__c = benef.cuentaId;
                detalleCaso.TipoBeneficiario__c = benef.tipoBeneficiario;
                detalleCaso.Id_Externo__c = benef.idExterno;
                
                detalleCaso.Sexo__c = benef.sexo;
                detalleCaso.Porcentaje__c = benef.porcentaje;
                detalleCaso.Fecha_nacimiento__c  = benef.fechaNacimiento;
                detalleCaso.Parentesco__c = getParentescoName(benef.parentesco);
                detalleCaso.Grado_parentesco__c = benef.grado;
                detalleCaso.ModificadoActInfo__c = benef.modificado != null ?  benef.modificado : false;
                if(benef.id == null){
                    detalleCaso.Caso__c = recordId;
                }else{
                    mapDetalle.remove(benef.id);
                }
                listDetalleCaso.add(detalleCaso);
            }
            
        } 
        System.debug('listDetalleCaso: '+Json.serialize(listDetalleCaso));
        upsert listDetalleCaso;
        Case caso = new case(Id=recordId, AprobacionBeneficiarios__c = listDetalleCaso.size() > 0 ); 
        update caso;
        delete mapDetalle.values();
        return getBeneficiarios(recordId, true);
    }
    
    public static List<Beneficiario> validacionCamposBeneficiario(List<Beneficiario> listBeneficiarios){
        for(Integer i=0; i<listBeneficiarios.size(); i++){
            listBeneficiarios[i].modificado = true;
            if(String.isBlank(listBeneficiarios[i].cuentaId) || String.isBlank(listBeneficiarios[i].tipoBeneficiario) ||
               String.isBlank(listBeneficiarios[i].primerNombre) || String.isBlank(listBeneficiarios[i].primerApellido) ||
               String.isBlank(listBeneficiarios[i].tipoIdentificacion) || String.isBlank(listBeneficiarios[i].identificacion) ||
               String.isBlank(listBeneficiarios[i].sexo) || listBeneficiarios[i].fechaNacimiento == null ||
               String.isBlank(listBeneficiarios[i].parentesco) || listBeneficiarios[i].porcentaje == null ){
                   listBeneficiarios[i].modificado =  false;
               }
        }
        return listBeneficiarios;
    }
    public static string getParentescoName(String parentesco){
        if(parentesco == '1'){
            return 'Conyuge';
        }else if(parentesco == '2'){
            return 'Hijo';
        }else if(parentesco == '3'){
            return 'Cuñado(a)';
        }else if(parentesco == '4'){
            return 'Yerno/Nuera';
        }else if(parentesco == '5'){
            return 'Padre';
        }else if(parentesco == '6'){
            return 'Hermano(a)';
        }else if(parentesco == '7'){
            return 'Abuelo(a)';
        }else if(parentesco == '8'){
            return 'Sobrino(a)';
        }else if(parentesco == '9'){
            return 'Primo(a)';
        }else if(parentesco == '11'){
            return 'Tio(a)';
        }else if(parentesco == '12'){
            return 'Afiliado(a)';
        }else if(parentesco == '13'){
            return 'Amigo(a)';
        }else if(parentesco == '14'){
            return 'Nieto(a)';
        }else if(parentesco == '15'){
            return 'Suegro(a)';
        }else if(parentesco == '16'){
            return 'Hijastro(a)';
        }
        return null;
    }
    
    public static string getParentescoValue(String parentesco){
        if(parentesco == 'Conyuge'){
            return '1';
        }else if(parentesco == 'Hijo'){
            return '2';
        }else if(parentesco == 'Cuñado(a)'){
            return '3';
        }else if(parentesco == 'Yerno/Nuera'){
            return '4';
        }else if(parentesco == 'Padre'){
            return '5';
        }else if(parentesco == 'Hermano(a)'){
            return '6';
        }else if(parentesco == 'Abuelo(a)'){
            return '7';
        }else if(parentesco == 'Sobrino(a)'){
            return '8';
        }else if(parentesco == 'Primo(a)'){
            return '9';
        }else if(parentesco == 'Tio(a)'){
            return '11';
        }else if(parentesco == 'Afiliado(a)'){
            return '12';
        }else if(parentesco == 'Amigo(a)'){
            return '13';
        }else if(parentesco == 'Nieto(a)'){
            return '14';
        }else if(parentesco == 'Suegro(a)'){
            return '15';
        }else if(parentesco == 'Hijastro(a)'){
            return '16';
        }
        return null;
    }
    
    
    public  static List<PicklistOption> getPicklistOptions(String objApiName, String fieldApiName){
        List<PicklistOption> lOptions = new List<PicklistOption>();
        SObjectType objectType = Schema.getGlobalDescribe().get(objApiName);
        List<Schema.PicklistEntry> ple = objectType.getDescribe().fields.getMap().get(fieldApiName).getDescribe().getPickListValues();
        for(Schema.PicklistEntry entry : ple)  {
            String label = entry.getLabel().length() < 13 ? entry.getLabel() : entry.getLabel().substring(0, 12);
            PicklistOption option = new PicklistOption(entry.getValue(), label);
            lOptions.add(option);
		}
        return lOptions;
    }
     public  static List<SelectOption> getPicklistOptionsSO(String objApiName, String fieldApiName){
        List<SelectOption> lOptions = new List<SelectOption>();
        SObjectType objectType = Schema.getGlobalDescribe().get(objApiName);
        List<Schema.PicklistEntry> ple = objectType.getDescribe().fields.getMap().get(fieldApiName).getDescribe().getPickListValues();
        for(Schema.PicklistEntry entry : ple)  {
            String label = entry.getLabel().length() < 13 ? entry.getLabel() : entry.getLabel().substring(0, 12);
            SelectOption option = new SelectOption(entry.getValue(), label);
            lOptions.add(option);
		}
        return lOptions;
    }
    public  static String getPicklistLabel(List<PicklistOption> lOptions, String valor){
        for(PicklistOption item : lOptions)  {
            if(item.value == valor){
                return item.label;
            }
        }
        return null;
    }
    
    public  static String getGradoLabel(String valor){
        if(valor == '1' || valor == '2'|| valor == '5'){
            return 'Primero';
        }else if(valor == '6' || valor == '7'|| valor == '14'){
            return 'Segundo';
        }else if(valor == '8' || valor == '9'|| valor == '11'){
            return  'Tercero';
        }else{
            return 'Cuarto';
        }
    }
    

    public class ResultWrapper{
        @AuraEnabled public List<Beneficiario> listBeneficiarios{get;set;}
        @AuraEnabled public List<Beneficiario> listBeneficiariosCont{get;set;}
        @AuraEnabled public List<Beneficiario> listBeneficiariosDirec{get;set;}
        
        @AuraEnabled public List<Porcentaje> listPorcentajes{get;set;}
        @AuraEnabled public List<PicklistOption> listParentesco{get;set;}
        @AuraEnabled public List<PicklistOption> listCuentas{get;set;}
        @AuraEnabled public List<PicklistOption> listSexo{get;set;}
        @AuraEnabled public List<PicklistOption> listIdentificacion{get;set;}
        @AuraEnabled public List<PicklistOption> listTipoBeneficiarios{get;set;}
        @AuraEnabled public Date fechaMaxima {get;set;}
        @AuraEnabled public Date fechaMinima {get;set;}
        @AuraEnabled public String titulo {get;set;}
        @AuraEnabled public String estado {get;set;}
        @AuraEnabled public Integer beneficiarioSelec {get;set;}
        @AuraEnabled public Boolean modificado {get;set;}
        @AuraEnabled public Boolean desactivado {get;set;}
        @AuraEnabled public String cuentaSelecionada {get;set;}
        @AuraEnabled public String cuentaSelecionadaLabel {get;set;}
        
        @AuraEnabled public Map<String, BeneficiarioWrapper> mapBeneficiarios{get;set;}
        
        @AuraEnabled public List<SelectOption> listParentescoSO{get;set;}
        @AuraEnabled public List<SelectOption> listCuentasSO{get;set;}
        @AuraEnabled public List<SelectOption> listSexoSO{get;set;}
        @AuraEnabled public List<SelectOption> listIdentificacionSO{get;set;}
        @AuraEnabled public List<SelectOption> listTipoBeneficiariosSO{get;set;}
    }
    
    public class Beneficiario{
        @AuraEnabled public String id {get;set;} 
        @AuraEnabled public String primerNombre {get;set;} 
        @AuraEnabled public String segundoNombre {get;set;} 
        @AuraEnabled public String primerApellido {get;set;} 
        @AuraEnabled public String segundoApellido {get;set;} 
        @AuraEnabled public String tipoIdentificacion {get;set;}
        @AuraEnabled public String tipoIdentificacionLabel {get;set;}
        @AuraEnabled public String identificacion {get;set;} 
        @AuraEnabled public String cuenta {get;set;}
        @AuraEnabled public String cuentaId {get;set;}
        @AuraEnabled public String tipoBeneficiario {get;set;} 
        @AuraEnabled public Decimal porcentaje {get;set;} 
        @AuraEnabled public Decimal idExterno {get;set;}
        @AuraEnabled public Date fechaNacimiento {get;set;} 
        @AuraEnabled public Date fechaNacimientoShow {get;set;} 
        @AuraEnabled public String sexo {get;set;} 
        @AuraEnabled public String parentesco {get;set;}
        @AuraEnabled public String parentescoLabel {get;set;}
        @AuraEnabled public String grado {get;set;} 
        @AuraEnabled public Integer index {get;set;}
        @AuraEnabled public Boolean modificado {get;set;}
    }
    
    public class PicklistOption{
        @AuraEnabled public String label{get;set;}
        @AuraEnabled public String value{get;set;}
        PicklistOption(String value, String label){
            this.label = label;
            this.value = value;
        }
    }
    
	public class Porcentaje{
        @AuraEnabled public String cuenta{get;set;}
        @AuraEnabled public Decimal porcentajeDireto{get;set;}
        @AuraEnabled public Decimal porcentajeContingencia{get;set;}
    }

}